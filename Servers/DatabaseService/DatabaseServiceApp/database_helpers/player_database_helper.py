import json

from DatabaseServiceApp.models import Player
from DatabaseServiceApp.serializers import PlayerSerializer


class PlayerDatabase:

    # -----------
    #   Get all
    # -----------
    @staticmethod
    def get_all():
        players_query = Player.objects.all()
        return players_query

    @staticmethod
    def get_all_return_serialized():
        players_query = PlayerDatabase.get_all()
        serializer = PlayerSerializer()
        return_data = json.loads(serializer.serialize(players_query).__str__())
        return return_data

    # -----------
    #   Get one
    # -----------
    @staticmethod
    def get_one(player_id):
        if str(player_id).isdigit():
            player_query = Player.objects.get(id=player_id)
        else:
            player_query = Player.objects.get(username=player_id)
        return player_query

    @staticmethod
    def get_one_return_serialized(player_id):
        player_query = PlayerDatabase.get_one(player_id)

        serializer = PlayerSerializer()
        serialize_object = json.loads(serializer.serialize([player_query]).__str__())

        return_data = serialize_object[0]

        return return_data

    # -----------
    #   Create one
    # -----------
    @staticmethod
    def create(json_body):
        # Early exit on missing player in json
        if 'player' not in json_body:
            return 'player'

        json_player = json_body['player']

        # Check for required attributes in the player object
        if 'username' not in json_player:
            return 'username'
        elif 'email' not in json_player:
            return 'email'
        elif 'first_name' not in json_player:
            return 'first_name'
        elif 'last_name' not in json_player:
            return 'last_name'
        elif 'study_programme' not in json_player:
            return 'study_programme'

        if 'high_score' in json_player:
            # Save the object in database
            player = Player(username=json_player['username'], email=json_player['email'],
                            first_name=json_player['first_name'], last_name=json_player['last_name'],
                            study_programme=json_player['study_programme'], high_score=json_player['high_score'])
        else:
            # Save the object in database
            player = Player(username=json_player['username'], email=json_player['email'],
                            first_name=json_player['first_name'], last_name=json_player['last_name'],
                            study_programme=json_player['study_programme'])
        player.save()

        return player

    @staticmethod
    def create_return_serialized(json_body):
        player = PlayerDatabase.create(json_body)

        # if it returns a string, return the string
        if isinstance(player, str):
            return player

        # Serialize the object
        serializer = PlayerSerializer()
        serialize_object = json.loads(serializer.serialize([player]).__str__())

        return_data = serialize_object[0]

        return return_data

    # -----------
    #   Update one
    # -----------
    @staticmethod
    def update(json_body, player_id):
        # Early exit on missing player in json
        if 'player' not in json_body:
            return 'player'

        json_player = json_body['player']

        player = PlayerDatabase.get_one(player_id)

        # Change only the provided attributes
        if 'username' in json_player:
            player.username = json_player['username']

        if 'email' in json_player:
            player.email = json_player['email']

        if 'first_name' in json_player:
            player.first_name = json_player['first_name']

        if 'last_name' in json_player:
            player.last_name = json_player['last_name']

        if 'study_programme' in json_player:
            player.study_programme = json_player['study_programme']

        if 'high_score' in json_player:
            player.high_score = json_player['high_score']

        player.save()

        return player

    @staticmethod
    def update_return_serialized(json_body, player_id):
        player = PlayerDatabase.update(json_body, player_id)

        # if it returns a string, return the string
        if isinstance(player, str):
            return player

        # Serialize the object
        serializer = PlayerSerializer()
        serialize_object = json.loads(serializer.serialize([player]).__str__())

        return_data = serialize_object[0]

        return return_data

    # -----------
    #   Delete one
    # -----------
    @staticmethod
    def delete(player_id):
        if str(player_id).isdigit():
            player = Player.objects.get(id=player_id)
            Player.objects.get(id=player_id).delete()
            return player
        else:
            player = Player.objects.get(username=player_id)
            Player.objects.get(username=player_id).delete()
            return player

    @staticmethod
    def delete_return_serialized(player_id):
        player = PlayerDatabase.delete(player_id)

        # if it returns a string, return the string
        if isinstance(player, str):
            return player

        # Serialize the object
        serializer = PlayerSerializer()
        serialize_object = json.loads(serializer.serialize([player]).__str__())

        return_data = serialize_object[0]

        return return_data
