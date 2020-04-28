import json
import datetime
token_player_list = []


# Check if token is in the token_list and return true otherwise return false
def token_status(token):
    print("token_list: " + str(token_player_list))
    print("token " + token)
    for json_object in token_player_list:
        data = json.loads(json_object)
        if data["user_token"] == token:
            return True
    return False

#NOT TESTED
def add_token(user_token, player_id):
    player_list_object = {"user_token": user_token, "time_stamp": str(datetime.now()), "player_id": player_id}
    player_list_object_json = json.dumps(player_list_object)
    token_player_list.append(player_list_object_json)

def get_token(user_token):
    for token in token_player_list:
        if user_token in token:
            token_response = user_token['user_token']
            player_id_response = user_token['player_id']
            time_stamp_response = user_token['time_stamp']
            return token_response, player_id_response, time_stamp_response
        else:
            return None, None, None

#NOT TESTED
def refresh_token(user_token):
    while True:
        for token in token_player_list:
            if user_token in token:
                player_id = user_token['player_id']
                token_player_list.remove({"user_token": token})
                token_player_list.add({"user_token":user_token, "player_id":player_id, "time_stamp":str(datetime.now())})

def clean_token_player_list():
    print("Not implemented yet")