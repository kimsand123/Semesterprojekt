import json

token_user_list = ['{"user_token": "test"}']


# Check if token is in the token_list and return true otherwise return false
def token_status(token):
    print("token_list: " + str(token_user_list))
    print("token " + token)
    for json_object in token_user_list:
        data = json.loads(json_object)
        if data["user_token"] == token:
            return True
    return False
