import json
from DatabaseServiceApp.serializers import InviteSerializer
from DatabaseServiceApp.models import Invite, Game


class InviteDatabase:
    # -----------
    #   Get all
    # -----------
    @staticmethod
    def get_all(query_params):
        invite_query = {}

        # Early exit on missing invite in json
        if 'player_id' not in query_params:
            invite_query = Invite.objects.all()
        else:
            # Cast to int, if it is a digit
            if str(query_params['player_id']).isdigit():
                player_id = int(query_params['player_id'])
            else:
                player_id = query_params['player_id']

            # Check if the player_id is int (then it is an id)
            if isinstance(player_id, int):
                invite_receiver_query = Invite.objects.all().filter(receiver_player_id=player_id)
                invite_sender_query = Invite.objects.all().filter(sender_player_id=player_id)

                invite_query = {
                    "invites_as_sender": invite_sender_query,
                    "invites_as_receiver": invite_receiver_query
                }

            else:
                invite_receiver_query = Invite.objects.all().filter(receiver_player__username=player_id)
                invite_sender_query = Invite.objects.all().filter(sender_player__username=player_id)

                invite_query = {

                    "invites_as_sender": invite_sender_query,
                    "invites_as_receiver": invite_receiver_query
                }

        return invite_query

    @staticmethod
    def get_all_return_serialized(json_body):
        invite_query = InviteDatabase.get_all(json_body)

        return_data = "[]"

        if isinstance(invite_query, dict):
            invites_as_sender = invite_query['invites_as_sender']
            invites_as_receiver = invite_query['invites_as_receiver']

            serializer = InviteSerializer()
            return_data = {
                "invites_as_sender": json.loads(serializer.serialize(invites_as_sender).__str__()),
                "invites_as_receiver": json.loads(serializer.serialize(invites_as_receiver).__str__())
            }

        else:
            invites = invite_query
            serializer = InviteSerializer()
            return_data = json.loads(serializer.serialize(invites).__str__())

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
        if 'invite' not in json_body:
            return 'invite'

        json_invite = json_body['invite']

        # Check for required attributes in the invite object
        if 'sender_player_id' not in json_invite:
            return 'sender_player_id'
        elif 'receiver_player_id' not in json_invite:
            return 'receiver_player_id'
        if 'match_name' not in json_invite:
            return 'match_name'
        if 'question_duration' not in json_invite:
            return 'question_duration'

        game = Game(match_name=json_invite['match_name'],
                    question_duration=json_invite['question_duration'])
        game.save()

        if 'accepted' in json_invite:

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
        if 'invite' not in json_body:
            return 'invite'

        json_invite = json_body['invite']

        invite = InviteDatabase.get_one(invite_id)
        game = Game.objects.get(id=invite.game_id)

        # Change only the provided attributes
        if 'sender_player_id' in json_invite:
            invite.sender_player_id = json_invite['sender_player_id']

        if 'receiver_player_id' in json_invite:
            invite.receiver_player_id = json_invite['receiver_player_id']

        if 'game_id' in json_invite:
            invite.game_id = json_invite['game_id']

        if 'accepted' in json_invite:
            invite.accepted = json_invite['accepted']

        if 'match_name' in json_invite:
            game.match_name = json_invite['match_name']

        if 'question_duration' in json_invite:
            game.question_duration = json_invite['question_duration']

        invite.save()
        game.save()

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
