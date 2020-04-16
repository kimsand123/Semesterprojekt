from DatabaseServiceApp.helper_methods import is_key_in_dict
from DatabaseServiceApp.sql_models import Invite


def invite_database_get_all():
    return Invite.objects.all()


def invite_database_get_one(invite_id):
    return Invite.objects.get(id=invite_id)


def invite_database_create(json_body):
    # Early exit on missing invite in json
    if not is_key_in_dict(json_body, 'invite'):
        return 'invite'

    json_user = json_body['invite']

    # Check for required attributes in the invite object
    if not is_key_in_dict(json_user, 'sender_player_id'):
        return 'sender_player_id'
    elif not is_key_in_dict(json_user, 'receiver_player_id'):
        return 'receiver_player_id'
    elif not is_key_in_dict(json_user, 'game_id'):
        return 'game_id'

    if is_key_in_dict(json_user, 'accepted'):
        # Save the object in database
        invite = Invite(sender_player_id=json_user['sender_player_id'],
                        receiver_player_id=json_user['receiver_player_id'],
                        game_id=json_user['game_id'],
                        accepted=json_user['accepted'])
    else:
        # Save the object in database
        invite = Invite(sender_player_id=json_user['sender_player_id'],
                        receiver_player_id=json_user['receiver_player_id'],
                        game_id=json_user['game_id'])
    invite.save()

    return invite


def invite_database_update(json_body, invite_id):
    # Early exit on missing invite in json
    if not is_key_in_dict(json_body, 'invite'):
        return 'invite'

    json_user = json_body['invite']

    invite = invite_database_get_one(invite_id)

    # Change only the provided attributes
    if is_key_in_dict(json_user, 'sender_player_id'):
        invite.sender_player_id = json_user['sender_player_id']

    if is_key_in_dict(json_user, 'receiver_player_id'):
        invite.receiver_player_id = json_user['receiver_player_id']

    if is_key_in_dict(json_user, 'game_id'):
        invite.game_id = json_user['game_id']

    if is_key_in_dict(json_user, 'accepted'):
        invite.accepted = json_user['accepted']

    invite.save()

    return invite


def invite_database_delete(invite_id):
    invite = Invite.objects.get(id=invite_id)
    Invite.objects.get(id=invite_id).delete()
    return invite
