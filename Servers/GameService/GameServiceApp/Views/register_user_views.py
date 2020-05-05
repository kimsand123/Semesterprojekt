from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

from GameServiceApp.constants import AUTH_SERVICE_ACCESS_KEY
from GameServiceApp.helper_methods import get_json_data_object, check_or_add_user, os
from GameServiceApp.active_player_list import *

from GameServiceApp.tests import run_token_test


# Login if player already present in db, return playerobject, otherwise create player in db and return playerobject
@api_view(['POST'])
def register_user(request):

    # Check if request body is properly json formatted
    req_json = get_json_data_object(request,
                                    "There is an error in your body json format. It should be ex {'username':'Your_user_name','password':'Your_password'}")
    if type(req_json) == Response:
        return Response(req_json)

    try:
        # Is the access key right.
        if req_json['service_key'] == AUTH_SERVICE_ACCESS_KEY:

            # check or add user
            player = check_or_add_user(req_json['user_object'])
            player_id = player['id']

            # If the player is not already logged in
            if player['id'] not in token_player_list:

                # Add token, timestamp and player_id to token_user_list
                token = req_json['user_token']
                add_token(token, player_id)
                #run_token_test()
                game_service_ip = "94.130.183.32"
                game_service_port = "9700"
                response = {"game_service_ip": game_service_ip, "game_service_port": game_service_port,
                            "player": player}
                print("response before sending: " + str(response))
                return Response(response, status=status.HTTP_200_OK)
            else:
                return Response(data="You cannot log in twice at the same time",
                                status=status.HTTP_208_ALREADY_REPORTED)
        else:
            return Response(status.HTTP_401_UNAUTHORIZED)
    except IndexError:
        return Response(data="error", status=status.HTTP_500_INTERNAL_SERVER_ERROR)
