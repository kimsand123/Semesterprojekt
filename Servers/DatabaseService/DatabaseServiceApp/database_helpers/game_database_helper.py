import json

from DatabaseServiceApp.helper_methods import is_key_in_dict
from DatabaseServiceApp.models import Game, GameQuestion, GamePlayer, GameRound
from DatabaseServiceApp.serializers import GameSerializer, GameQuestionSerializer, GamePlayerSerializer, \
    GameRoundSerializer


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
        # Add the game_players
        game_players = GamePlayer.objects.filter(game_id=game['id'])
        serializer = GamePlayerSerializer()
        game_players_dict = json.loads(serializer.serialize(game_players).__str__())

        # Make sure the list is not empty
        if str(game_players_dict).count('{') >= 1:
            for status in game_players_dict:
                # Gather needed objects form the status_dict
                game_player_id = status['id']

                # Add a player_status dict, if it does not exist
                if not is_key_in_dict(game, 'player_status'):
                    game['player_status'] = []

                # Get the underlying player_status dict+
                game_player_status = game['player_status']

                # --------------------
                # Add the game_rounds
                game_round_query = GameRound.objects.filter(game_player_id=game_player_id)
                serializer = GameRoundSerializer()
                game_round_dict = json.loads(serializer.serialize(game_round_query).__str__())

                # Add a single player_status dict
                game_player_status.append({'game_player': status, 'game_round': game_round_dict})

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

            game = Game(match_name=json_game['match_name'],
                        question_duration=json_game['question_duration'])
            game.save()
            created_game_id = game.id

        # Add questions if it is in the json
        if is_key_in_dict(json_game, 'questions'):
            questions = json_game['questions']
            for question in questions:
                GameQuestion(game_id=created_game_id,
                             question_id=question).save()

        # Add player_status if it is in the json
        if is_key_in_dict(json_game, 'player_status'):
            player_status_list = json_game['player_status']

            for status in player_status_list:
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

                game_player = GamePlayer(game_id=created_game_id, player_id=game_player_dict['player_id'],
                                         game_progress=game_player_dict['game_progress'],
                                         score=game_player_dict['score'])
                game_player.save()

                # Get the game_rounds
                game_round_list = status['game_round']

                for g_round in game_round_list:
                    # Check if data is in dict
                    if not is_key_in_dict(g_round, 'time_spent'):
                        return 'time_spent (in game_round)'
                    elif not is_key_in_dict(g_round, 'score'):
                        return 'score (in game_round)'

                    game_round = GameRound(game_player_id=game_player.id,
                                           time_spent=g_round['time_spent'],
                                           score=g_round['score'])
                    game_round.save()

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

        # Update the game_player if it is in the json
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
                print('game_player_dict: ' + str(game_player_dict))

                # Delete existing game_players
                GamePlayer.objects.filter(game_id=created_game_id, player_id=game_player_dict['player_id']).delete()

                # Get the game_player
                game_player_dict = status['game_player']

                # Check if data is in dict
                if not is_key_in_dict(game_player_dict, 'player_id'):
                    return 'player_id (in game_player)'
                elif not is_key_in_dict(game_player_dict, 'game_progress'):
                    return 'game_progress (in game_player)'
                elif not is_key_in_dict(game_player_dict, 'score'):
                    return 'score (in game_player)'

                game_player = GamePlayer(game_id=created_game_id, player_id=game_player_dict['player_id'],
                                         game_progress=game_player_dict['game_progress'],
                                         score=game_player_dict['score'])

                game_player.save()

                print('game_player: ' + str(game_player))

                # Get the game_rounds
                game_round_list = status['game_round']

                for g_round in game_round_list:
                    # Check if data is in dict
                    if not is_key_in_dict(g_round, 'time_spent'):
                        return 'time_spent (in game_round)'
                    elif not is_key_in_dict(g_round, 'score'):
                        return 'score (in game_round)'

                    game_round = GameRound(game_player_id=game_player.id,
                                           time_spent=g_round['time_spent'],
                                           score=g_round['score'])
                    game_round.save()
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
