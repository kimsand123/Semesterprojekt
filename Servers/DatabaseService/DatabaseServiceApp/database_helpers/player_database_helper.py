from DatabaseServiceApp.helper_methods import is_key_in_dict
from DatabaseServiceApp.sql_models import Player


def player_database_get_all():
    return Player.objects.all()


def player_database_get_one(player_id):
    if str(player_id).isdigit():
        return Player.objects.get(id=player_id)
    else:
        return Player.objects.get(username=player_id)


def player_database_create(json_body):
    # Early exit on missing player in json
    if not is_key_in_dict(json_body, 'player'):
        return 'player'

    json_user = json_body['player']

    # Check for required attributes in the player object
    if not is_key_in_dict(json_user, 'username'):
        return 'username'
    elif not is_key_in_dict(json_user, 'email'):
        return 'email'
    elif not is_key_in_dict(json_user, 'first_name'):
        return 'first_name'
    elif not is_key_in_dict(json_user, 'last_name'):
        return 'last_name'
    elif not is_key_in_dict(json_user, 'study_programme'):
        return 'study_programme'

    if is_key_in_dict(json_user, 'high_score'):
        # Save the object in database
        player = Player(username=json_user['username'], email=json_user['email'],
                        first_name=json_user['first_name'], last_name=json_user['last_name'],
                        study_programme=json_user['study_programme'], high_score=json_user['high_score'])
    else:
        # Save the object in database
        player = Player(username=json_user['username'], email=json_user['email'],
                        first_name=json_user['first_name'], last_name=json_user['last_name'],
                        study_programme=json_user['study_programme'])
    player.save()

    return player


def player_database_update(json_body, player_id):
    # Early exit on missing player in json
    if not is_key_in_dict(json_body, 'player'):
        return 'player'

    json_user = json_body['player']

    player = player_database_get_one(player_id)

    # Change only the provided attributes
    if is_key_in_dict(json_user, 'username'):
        player.username = json_user['username']

    if is_key_in_dict(json_user, 'email'):
        player.email = json_user['email']

    if is_key_in_dict(json_user, 'first_name'):
        player.first_name = json_user['first_name']

    if is_key_in_dict(json_user, 'last_name'):
        player.last_name = json_user['last_name']

    if is_key_in_dict(json_user, 'study_programme'):
        player.study_programme = json_user['study_programme']

    if is_key_in_dict(json_user, 'high_score'):
        player.high_score = json_user['high_score']

    player.save()

    return player


def player_database_delete(player_id):
    if str(player_id).isdigit():
        player = Player.objects.get(id=player_id)
        Player.objects.get(id=player_id).delete()
        return player
    else:
        player = Player.objects.get(username=player_id)
        Player.objects.get(username=player_id).delete()
        return player
