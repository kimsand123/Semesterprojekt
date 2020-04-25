import json

from DatabaseServiceApp.helper_methods import is_key_in_dict
from DatabaseServiceApp.models import Game, GameQuestion, GamePlayerRound, GamePlayer, GameRound
from DatabaseServiceApp.serializers import GameSerializer, GameQuestionSerializer, \
    GamePlayerRoundSerializer


class GameDatabase:
    # -----------
    #   Get all
    # -----------
    @staticmethod
    def get_all_return_serialized():
        # Get all from games_table
        game_query = Game.objects.all()
        serializer = GameSerializer()
        game_query_dict = json.loads(serializer.serialize(game_query).__str__())

        # Make a list of the correctly filled game objects
        return_list = []
        for game in game_query_dict:
            return_list.append(GameDatabase.get_one_return_serialized(game['id']))

        return return_list

    # -----------
    #   Get one
    # -----------
    @staticmethod
    def get_one_return_serialized(game_id):
        # Get single game from games_table
        game_query = Game.objects.get(id=game_id)
        serializer = GameSerializer()
        game_single_query_dict = json.loads(serializer.serialize([game_query]).__str__())
        game = game_single_query_dict[0]

        # --------------------
        # Add the game_questions
        game_question_query = GameQuestion.objects.filter(game=game['id'])
        serializer = GameQuestionSerializer()
        game_question_dict = json.loads(serializer.serialize(game_question_query).__str__())

        # Make sure the list is not empty
        if str(game_question_dict).count('{') >= 1:
            game['questions'] = game_question_dict

        # --------------------
        # Add the player_status
        player_status_query = GamePlayerRound.objects.filter(game=game['id'])
        serializer = GamePlayerRoundSerializer()
        player_status_dict = json.loads(serializer.serialize(player_status_query).__str__())

        # Make sure the list is not empty
        if str(player_status_dict).count('{') >= 1:
            for status in player_status_dict:
                # Gather needed objects form the status_dict
                game_player = [status['game_player']][0]
                game_player_id = game_player['player']['id']
                game_round = [status['game_round']][0]

                # Add a player_status dict, if it does not exist
                if not is_key_in_dict(game, 'player_status'):
                    game['player_status'] = {}

                # Get the underlying player_status dict+
                game_player_status = game['player_status']

                # Add a single player_status dict
                # containing a game_player and an empty game_round object
                if not is_key_in_dict(game_player_status, game_player_id):
                    game_player_status[game_player_id] = {'game_player': game_player, 'game_round': []}

                # Append the game on the player's rounds
                game_player_status[game_player_id]['game_round'].append(game_round)

        return game

    # -----------
    #   Create one
    # -----------
    @staticmethod
    def create_return_serialized(json_body):
        # Early exit on missing game in json
        if not is_key_in_dict(json_body, 'game'):
            return 'game'

        json_game = json_body['game']

        # If a game_id from invite was transferred, use that
        if is_key_in_dict(json_game, 'invite_game_id'):
            game = GameDatabase.get_one_return_serialized(json_game['invite_game_id'])
            created_game_id = game['id']

        # Else create a new game with the params
        else:
            # Check for required attributes in the game object
            if not is_key_in_dict(json_game, 'match_name'):
                return 'match_name'
            if not is_key_in_dict(json_game, 'question_duration'):
                return 'question_duration'

            game = Game(match_name=json_game['match_name'], question_duration=json_game['question_duration'])
            game.save()
            created_game_id = game.id

        # Add questions if it is in the json
        if is_key_in_dict(json_game, 'questions'):
            questions = json_game['questions']
            for question in questions:
                GameQuestion(game_id=created_game_id, question_id=question).save()

        # Add player_status if it is in the json
        if is_key_in_dict(json_game, 'player_status'):
            player_status = json_game['player_status']

            for status in player_status:
                # Check if data is in dict
                if not is_key_in_dict(status, 'game_player'):
                    return 'game_player (in player_status)'
                elif not is_key_in_dict(status, 'game_round'):
                    return 'game_round (in player_status)'

                # Get the game_player
                game_player_dict = status['game_player']

                # Check if data is in dict
                if not is_key_in_dict(game_player_dict, 'player_id'):
                    return 'player_id (in game_player)'
                elif not is_key_in_dict(game_player_dict, 'game_progress'):
                    return 'game_progress (in game_player)'
                elif not is_key_in_dict(game_player_dict, 'score'):
                    return 'score (in game_player)'

                game_player = GamePlayer(player_id=game_player_dict['player_id'],
                                         game_progress=game_player_dict['game_progress'],
                                         score=game_player_dict['score'])
                game_player.save()

                # Get the game_rounds
                game_round_dict = status['game_round']

                for round in game_round_dict:
                    # Check if data is in dict
                    if not is_key_in_dict(round, 'time_spent'):
                        return 'time_spent (in game_round)'
                    elif not is_key_in_dict(round, 'score'):
                        return 'score (in game_round)'

                    game_round = GameRound(time_spent=round['time_spent'], score=round['score'])
                    game_round.save()
                    game_player_round = GamePlayerRound(game_id=created_game_id,
                                                        game_player_id=game_player.id,
                                                        game_round_id=game_round.id)
                    game_player_round.save()

        # Gather all the again data to return it
        return_data = GameDatabase.get_one_return_serialized(created_game_id)

        return return_data

    # -----------
    #   Update one
    # -----------
    @staticmethod
    def update_return_serialized(json_body, game_id):
        # Early exit on missing game in json
        if not is_key_in_dict(json_body, 'game'):
            return 'game'

        json_game = json_body['game']

        existing_game = Game.objects.get(id=game_id)

        # Check for required attributes in the game object
        if is_key_in_dict(json_game, 'match_name'):
            existing_game.match_name = json_game['match_name']
        if is_key_in_dict(json_game, 'question_duration'):
            existing_game.question_duration = json_game['question_duration']

        existing_game.save()
        created_game_id = existing_game.id

        # Add questions if it is in the json
        if is_key_in_dict(json_game, 'questions'):
            questions = json_game['questions']
            GameQuestion.objects.filter(game_id=created_game_id).delete()
            for question in questions:
                GameQuestion(game_id=created_game_id, question_id=question).save()

        GamePlayerRound.objects.filter(game_id = created_game_id).delete()

        # Add player_status if it is in the json
        if is_key_in_dict(json_game, 'player_status'):
            player_status = json_game['player_status']

            for status in player_status:
                # Check if data is in dict
                if not is_key_in_dict(status, 'game_player'):
                    return 'game_player (in player_status)'
                elif not is_key_in_dict(status, 'game_round'):
                    return 'game_round (in player_status)'

                # Get the game_player
                game_player_dict = status['game_player']

                # Check if data is in dict
                if not is_key_in_dict(game_player_dict, 'player_id'):
                    return 'player_id (in game_player)'
                elif not is_key_in_dict(game_player_dict, 'game_progress'):
                    return 'game_progress (in game_player)'
                elif not is_key_in_dict(game_player_dict, 'score'):
                    return 'score (in game_player)'

                game_player = GamePlayer(player_id=game_player_dict['player_id'],
                                         game_progress=game_player_dict['game_progress'],
                                         score=game_player_dict['score'])
                game_player.save()

                # Get the game_rounds
                game_round_dict = status['game_round']

                for round in game_round_dict:
                    # Check if data is in dict
                    if not is_key_in_dict(round, 'time_spent'):
                        return 'time_spent (in game_round)'
                    elif not is_key_in_dict(round, 'score'):
                        return 'score (in game_round)'

                    game_round = GameRound(time_spent=round['time_spent'], score=round['score'])
                    game_round.save()
                    game_player_round = GamePlayerRound(game_id=created_game_id,
                                                        game_player_id=game_player.id,
                                                        game_round_id=game_round.id)
                    game_player_round.save()

        # Gather all the again data to return it
        return_data = GameDatabase.get_one_return_serialized(created_game_id)

        return return_data

    # -----------
    #   Delete one
    # -----------
    @staticmethod
    def delete_return_serialized(game_id):
        return_data = GameDatabase.get_one_return_serialized(game_id)
        Game.objects.get(id=game_id).delete()

        return return_data
