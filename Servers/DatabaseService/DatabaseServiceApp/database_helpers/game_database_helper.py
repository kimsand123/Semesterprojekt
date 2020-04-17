from DatabaseServiceApp.helper_methods import is_key_in_dict
from DatabaseServiceApp.models import Game


def game_database_get_all():
    return Game.objects.all()


def game_database_get_one(game_id):
    return Game.objects.get(id=game_id)


def game_database_create(json_body):
    # Early exit on missing game in json
    if not is_key_in_dict(json_body, 'game'):
        return 'game'

    json_user = json_body['game']

    # Check for required attributes in the game object
    if not is_key_in_dict(json_user, 'match_name'):
        return 'match_name'
    elif not is_key_in_dict(json_user, 'question_duration'):
        return 'question_duration'

    game = Game(match_name=json_user['match_name'],
                question_duration=json_user['question_duration'])
    game.save()

    return game


def game_database_update(json_body, game_id):
    # Early exit on missing game in json
    if not is_key_in_dict(json_body, 'game'):
        return 'game'

    json_user = json_body['game']

    game = game_database_get_one(game_id)

    # Change only the provided attributes
    if is_key_in_dict(json_user, 'sender_player_id'):
        game.sender_player_id = json_user['sender_player_id']

    if is_key_in_dict(json_user, 'receiver_player_id'):
        game.receiver_player_id = json_user['receiver_player_id']

    if is_key_in_dict(json_user, 'game_id'):
        game.game_id = json_user['game_id']

    if is_key_in_dict(json_user, 'accepted'):
        game.accepted = json_user['accepted']

    game.save()

    return game


def game_database_delete(game_id):
    game = Game.objects.get(id=game_id)
    Game.objects.get(id=game_id).delete()
    return game
