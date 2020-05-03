from datetime import *
from GameService import settings

token_player_list = []


# Check if token is in the token_list and return true otherwise return false
def token_status(user_token):
    if settings.DEBUG and user_token == "test":
        return True


    for idx, json_object in enumerate(token_player_list, start=0):
 #       print(json_object.__str__() + ", " + user_token)
        # If the token is in the list
        if json_object["user_token"] == user_token:
            break;
    else:
        return False
    # Get the element that carries the token.
    token_player_list_element = token_player_list[idx]
    # Check if the token is less than 30 minutes old
    token_time = datetime.strptime(token_player_list_element['time_stamp'], "%Y-%m-%d %H:%M:%S.%f")
    if (token_time > datetime.now()- timedelta(minutes=30)):
        # refresh it with new time stamp
        token_player_list.pop(idx)
        token_player_list.append({"user_token": user_token, "time_stamp": str(datetime.now()), "player_id": token_player_list_element['player_id']})
        return True
    else:
        # Remove the token
        token_player_list.pop(idx)
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

def clean_token_player_list():
    print("Not implemented yet")
