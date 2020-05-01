from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

from GameServiceApp.correct_data import CORRECT_PLAYER_OBJ
from GameServiceApp.helper_methods import get_json_data_object, connection_service, check_or_add_user, \
    generate_error_json
from GameServiceApp.active_player_list import *


# -------------
# [GET / POST] /players/
# -------------
@api_view(['GET', 'POST'])
def players(request):
    # Early exit on missing authorization / invalid token
    if 'Authorization' not in request.headers:
        error_message = generate_error_json(status.HTTP_401_UNAUTHORIZED, "Authorization was not included in headers",
                                            None, None)
        return Response(data=error_message, status=status.HTTP_401_UNAUTHORIZED)
    else:
        if not token_status(request.headers['Authorization']):
            error_message = generate_error_json(status.HTTP_401_UNAUTHORIZED, "Token was invalid", None, None)
            return Response(data=error_message, status=status.HTTP_401_UNAUTHORIZED)

    # Goes to the different method calls
    if request.method == 'GET':
        return players_get(request)
    elif request.method == 'POST':
        return players_post(request)
    else:
        print("/players/ does not have a \'" + request.method + "\' handling")


# -------------
# [GET / PUT / DELETE] /players/player_id
# -------------
@api_view(['GET', 'PUT', 'DELETE'])
def single_player(request, player_id):
    # Early exit on missing authorization / invalid token
    if 'Authorization' not in request.headers:
        error_message = generate_error_json(status.HTTP_401_UNAUTHORIZED, "Authorization was not included in headers",
                                            None, None)
        return Response(data=error_message, status=status.HTTP_401_UNAUTHORIZED)
    else:
        if not token_status(request.headers['Authorization']):
            error_message = generate_error_json(status.HTTP_401_UNAUTHORIZED, "Token was invalid", None, None)
            return Response(data=error_message, status=status.HTTP_401_UNAUTHORIZED)

    if request.method == 'GET':
        return single_player_get(request, player_id)
    elif request.method == 'PUT':
        return single_player_put(request, player_id)
    elif request.method == 'DELETE':
        return single_player_delete(request, player_id)
    else:
        print("/players/player_id does not have a \'" + request.method + "\' handling")


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# INDIVIDUAL METHODS BENEATH
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# -------------
# [GET] /players/
# -------------
def players_get(request):
    response = connection_service("/players/", None, None, "GET")
    return Response(data=response, status=status.HTTP_200_OK)


# -------------
# [POST] /players/
# -------------
def players_post(request):
    decode_error_message = generate_error_json(status.HTTP_400_BAD_REQUEST, 'Json decode error',
                                               'Your body should probably look like the value in correct_data',
                                               CORRECT_PLAYER_OBJ)

    json_request = get_json_data_object(request, decode_error_message)
    if type(json_request) is Response:
        return json_request

    player_req = json_request['player']
    json_body = {
        "player": {
            "username": player_req['username'],
            "email": player_req['email'],
            "first_name": player_req['first_name'],
            "last_name": player_req['last_name'],
            "study_programme": player_req['study_programme'],
            "high_score": player_req['high_score']
        }
    }
    response = connection_service("/players/", json_body, None, "POST")
    return Response(data=response, status=status.HTTP_201_CREATED)


# -------------
# [GET] /players/player_id/
# -------------
def single_player_get(request, player_id):
    response = connection_service(f"/players/{player_id}/", None, None, "GET")
    return Response(data=response, status=status.HTTP_200_OK)


# -------------
# [PUT] /players/player_id/
# -------------
def single_player_put(request, player_id):
    decode_error_message = generate_error_json(status.HTTP_400_BAD_REQUEST, 'Json decode error',
                                               'Your body should probably look like the value in correct_data',
                                               CORRECT_PLAYER_OBJ)

    json_request = get_json_data_object(request, decode_error_message)
    if type(json_request) is Response:
        return json_request

    player_req = json_request['player']
    json_body = {
        "player": {
            "username": player_req['username'],
            "email": player_req['email'],
            "first_name": player_req['first_name'],
            "last_name": player_req['last_name'],
            "study_programme": player_req['study_programme'],
            "high_score": player_req['high_score']
        }
    }
    response = connection_service(f"/players/{player_id}/", json_body, None, "PUT")
    return Response(data=response, status=status.HTTP_200_OK)


# -------------
# [DELETE] /player/player_id/
# -------------
def single_player_delete(request, player_id):
    response = connection_service(f"/players/{player_id}/", None, None, "DELETE")
    return Response(data=response, status=status.HTTP_200_OK)
