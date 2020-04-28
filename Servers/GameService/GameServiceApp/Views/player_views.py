from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

from GameServiceApp.constants import AUTH_SERVICE_ACCESS_KEY
from GameServiceApp.helper_methods import get_json_data_object, connection_service, check_or_add_user


### PLAYERS ###
###Get all players
@api_view(['GET'])
def get_players(request):
    ###Check if request body is properly json formatted
    req_json = get_json_data_object(request,
                                    "There is an error in your body json format. It should be ex{'user_token':'Yourtoken'}")
    if type(req_json) == Response:
        return req_json

    ##If token is present in the list do the following
    if token_status(req_json['user_token']):
        response = connection_service("/players/", None, "GET")
        return Response(data=response, status=status.HTTP_200_OK)
    else:
        return Response(data="Token not valid. Please login again", status=status.HTTP_401_UNAUTHORIZED)


###Get specific player
@api_view(['GET'])
def get_player(request, player_id):
    ###Check if request body is properly json formatted
    req_json = get_json_data_object(request,
                                    "There is an error in your body json format. It should be ex {'user_token':'Yourtoken'}")
    if type(req_json) == Response:
        return Response(req_json)

    ##If token is present in the list do the following
    if token_status(req_json['user_token']):
        response = connection_service("/players/" + player_id + "/", None, "GET")
        return Response(data=response, status=status.HTTP_200_OK)
    else:
        return Response(data="Token not valid. Please login again", status=status.HTTP_401_UNAUTHORIZED)


###Login   if player already present in db, return playerobject, otherwise create player in db and return playerobject
@api_view(['POST'])
def register_user(request):
    logfile = open('GameServerLog.txt', 'a')

    ###Check if request body is properly json formatted
    req_json = get_json_data_object(request,
                                    "There is an error in your body json format. It should be ex {'username':'Your_user_name','password':'Your_password'}")
    if type(req_json) == Response:
        return Response(req_json)

    try:
        # Is the access key right.
            if req_json['service_key'] == AUTH_SERVICE_ACCESS_KEY:

                # check or add user
                player_id = check_or_add_user(req_json['user_object'])

                # If the player is not already logged in
                if player_id not in token_player_list:

                    # Add token, timestamp and player_id to token_user_list
                    token = req_json['user_token']
                    add_token(token, player_id)
                    run_token_test()
                    gameservice_ip = "127.0.0.1"
                    gameservice_port = "9700"
                    response = {"gameservice_ip": gameservice_ip, "gameservice_port": gameservice_port,
                                "player_id": player_id}
                    print("response before sending: " + str(response))
                    return Response(response, status=status.HTTP_200_OK)
                else:
                    return Response(data="You cannot log in twice at the same time",
                                    status=status.HTTP_208_ALREADY_REPORTED)
            else:
                return Response(status.HTTP_401_UNAUTHORIZED)
    except:
        return Response(data="error", status=status.HTTP_500_INTERNAL_SERVER_ERROR)


from GameServiceApp.active_player_list import *

def run_token_test():

    add_token("TESTTOKEN", 1000)

    user_token, player_id, time_stamp = get_token("TESTTOKEN")
    if user_token != None:
        print("add_token worked")
    else:
        print("add_token didn't worked")

    if token_status("TESTTOKEN"):
        print("token_status worked")
    else:
        print("token_status didn't work")

    user_token, player_id, time_stamp = get_token("TESTTOKEN")
    if user_token == None:
        print("Token didn't exist")
    else:
        ts1 = time_stamp
        print ("timestamp before refresh: " + str(time_stamp))

    refresh_token("TESTTOKEN")


    user_token, player_id, time_stamp = get_token("TESTTOKEN")
    if user_token == None:
        print("Token didn't exist")
    else:
        ts2 = time_stamp
        print ("timestamp before refresh: " + str(time_stamp))

    if ts1 != ts2:
        print("refresh worked. Timestamp 1: " + str(ts1) + " vs Timestamp 2: " + str(ts2))


    print("Test done")
