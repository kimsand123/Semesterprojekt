import json
from datetime import datetime

from GameService import settings

token_player_list = []


# Check if token is in the token_list and return true otherwise return false
def token_status(user_token):
    if settings.DEBUG:
        if user_token == "test":
            return True

    for json_object in token_player_list:
        print(json_object.__str__() + ", " + user_token)
        if json_object["user_token"] == user_token:
            return True
    return False


def add_token(user_token, player_id):
    player_list_object = {"user_token": user_token, "time_stamp": str(datetime.now()), "player_id": player_id}
    token_player_list.append(player_list_object)


def get_token(user_token):
    for token in token_player_list:
        if token['user_token'] == user_token:
            token_response = token['user_token']
            player_id_response = token['player_id']
            time_stamp_response = token['time_stamp']
            return token_response, player_id_response, time_stamp_response
    return None, None, None


def refresh_token(user_token):
    for idx, token in enumerate(token_player_list, start=0):
        player_id = token['player_id']
        if token['user_token'] == user_token:
            token_player_list.pop(idx)
            token_player_list.append(
                {"user_token": user_token, "time_stamp": str(datetime.now()), "player_id": player_id})
            break


def clean_token_player_list():
    print("Not implemented yet")
