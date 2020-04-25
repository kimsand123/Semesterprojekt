import json

from DatabaseServiceApp.helper_methods import is_key_in_dict
from DatabaseServiceApp.serializers import InviteSerializer
from DatabaseServiceApp.models import Invite, Game


class InviteDatabase:
    # -----------
    #   Get all
    # -----------
    @staticmethod
    def get_all():
        invite_query = Invite.objects.all()
        return invite_query

    @staticmethod
    def get_all_return_serialized():
        invite_query = InviteDatabase.get_all()
        serializer = InviteSerializer()
        return_data = json.loads(serializer.serialize(invite_query).__str__())
        return return_data

    # -----------
    #   Get one
    # -----------
    @staticmethod
    def get_one(invite_id):
        invite_query = Invite.objects.get(id=invite_id)
        return invite_query

    @staticmethod
    def get_one_return_serialized(invite_id):

        invite_query = InviteDatabase.get_one(invite_id)

        serializer = InviteSerializer()
        serialize_object = json.loads(serializer.serialize([invite_query]).__str__())

        return_data = serialize_object[0]

        return return_data

    # -----------
    #   Create one
    # -----------
    @staticmethod
    def create(json_body):
        # Early exit on missing invite in json
        if not is_key_in_dict(json_body, 'invite'):
            return 'invite'

        json_invite = json_body['invite']

        # Check for required attributes in the invite object
        if not is_key_in_dict(json_invite, 'sender_player_id'):
            return 'sender_player_id'
        elif not is_key_in_dict(json_invite, 'receiver_player_id'):
            return 'receiver_player_id'
        if not is_key_in_dict(json_invite, 'match_name'):
            return 'match_name'
        if not is_key_in_dict(json_invite, 'question_duration'):
            return 'question_duration'

        game = Game(match_name=json_invite['match_name'],
                    question_duration=json_invite['question_duration'])
        game.save()

        if is_key_in_dict(json_invite, 'accepted'):

            # Save the object in database
            invite = Invite(sender_player_id=json_invite['sender_player_id'],
                            receiver_player_id=json_invite['receiver_player_id'],
                            game_id=game.id,
                            accepted=json_invite['accepted'])
        else:
            # Save the object in database
            invite = Invite(sender_player_id=json_invite['sender_player_id'],
                            receiver_player_id=json_invite['receiver_player_id'],
                            game_id=game.id)
        invite.save()

        return invite

    @staticmethod
    def create_return_serialized(json_body):
        invite = InviteDatabase.create(json_body)

        # if it returns a string, return the string
        if isinstance(invite, str):
            return invite

        # Serialize the object
        serializer = InviteSerializer()
        serialize_object = json.loads(serializer.serialize([invite]).__str__())

        return_data = serialize_object[0]

        return return_data

    # -----------
    #   Update one
    # -----------
    @staticmethod
    def update(json_body, invite_id):
        # Early exit on missing invite in json
        if not is_key_in_dict(json_body, 'invite'):
            return 'invite'

        json_invite = json_body['invite']

        invite = InviteDatabase.get_one(invite_id)

        # Change only the provided attributes
        if is_key_in_dict(json_invite, 'sender_player_id'):
            invite.sender_player_id = json_invite['sender_player_id']

        if is_key_in_dict(json_invite, 'receiver_player_id'):
            invite.receiver_player_id = json_invite['receiver_player_id']

        if is_key_in_dict(json_invite, 'game_id'):
            invite.game_id = json_invite['game_id']

        if is_key_in_dict(json_invite, 'accepted'):
            invite.accepted = json_invite['accepted']

        invite.save()

        return invite

    @staticmethod
    def update_return_serialized(json_body, invite_id):
        invite = InviteDatabase.update(json_body, invite_id)

        # if it returns a string, return the string
        if isinstance(invite, str):
            return invite

        # Serialize the object
        serializer = InviteSerializer()
        serialize_object = json.loads(serializer.serialize([invite]).__str__())

        return_data = serialize_object[0]

        return return_data

    # -----------
    #   Delete one
    # -----------
    @staticmethod
    def delete(invite_id):
        invite = Invite.objects.get(id=invite_id)
        Invite.objects.get(id=invite_id).delete()
        return invite

    @staticmethod
    def delete_return_serialized(json_body):
        invite = InviteDatabase.delete(json_body)

        # if it returns a string, return the string
        if isinstance(invite, str):
            return invite

        # Serialize the object
        serializer = InviteSerializer()
        serialize_object = json.loads(serializer.serialize([invite]).__str__())

        return_data = serialize_object[0]

        return return_data
