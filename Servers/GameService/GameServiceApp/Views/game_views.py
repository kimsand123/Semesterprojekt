from rest_framework.decorators import api_view
from ..correct_data import CORRECT_GAME_OBJ

from GameServiceApp.active_player_list import token_status
from GameServiceApp.helper_methods import *


# -------------
# [GET / POST] /games/
# -------------
@api_view(['GET', 'POST'])
def games(request):
    # Early exit on missing authorization / invalid token
    if 'Authorization' not in request.headers:
        error_message = generate_error_json(status.HTTP_401_UNAUTHORIZED, "Authorization was not included in headers", None, None)
        return Response(data=error_message, status=status.HTTP_401_UNAUTHORIZED)
    else:
        if not token_status(request.headers['Authorization']):
            error_message = generate_error_json(status.HTTP_401_UNAUTHORIZED, "Token was invalid", None, None)
            return Response(data=error_message, status=status.HTTP_401_UNAUTHORIZED)

    # Goes to the different method calls
    if request.method == 'GET':
        return games_get(request)
    elif request.method == 'POST':
        return games_post(request)
    else:
        print("/games/ does not have a \'" + request.method + "\' handling")


# -------------
# [GET / PUT / DELETE] /games/game_id
# -------------
@api_view(['GET', 'PUT', 'DELETE'])
def single_game(request, game_id):
    # Early exit on missing authorization / invalid token
    if 'Authorization' not in request.headers:
        error_message = generate_error_json(status.HTTP_401_UNAUTHORIZED, "Authorization was not included in headers", None, None)
        return Response(data=error_message, status=status.HTTP_401_UNAUTHORIZED)
    else:
        if not token_status(request.headers['Authorization']):
            error_message = generate_error_json(status.HTTP_401_UNAUTHORIZED, "Token was invalid", None, None)
            return Response(data=error_message, status=status.HTTP_401_UNAUTHORIZED)

    if request.method == 'GET':
        return single_game_get(request, game_id)
    elif request.method == 'PUT':
        return single_game_put(request, game_id)
    elif request.method == 'DELETE':
        return single_game_delete(request, game_id)
    else:
        print("/games/game_id does not have a \'" + request.method + "\' handling")


# -------------
# [PUT] /games/game_id/player-status/game-round/
# -------------
@api_view(['PUT'])
def single_game_player_status_game_round(request, game_id):
    # Early exit on missing authorization / invalid token
    if 'Authorization' not in request.headers:
        error_message = generate_error_json(status.HTTP_401_UNAUTHORIZED, "Authorization was not included in headers", None, None)
        return Response(data=error_message, status=status.HTTP_401_UNAUTHORIZED)
    else:
        if not token_status(request.headers['Authorization']):
            error_message = generate_error_json(status.HTTP_401_UNAUTHORIZED, "Token was invalid", None, None)
            return Response(data=error_message, status=status.HTTP_401_UNAUTHORIZED)

    if request.method == 'PUT':
        return single_game_game_round_put(request, game_id)
    else:
        print("/games/game_id does not have a \'" + request.method + "\' handling")

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# INDIVIDUAL METHODS BENEATH
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


# -------------
# [GET] /games/
# -------------
def games_get(request):
    if 'player_id' in request.GET:
        param_player_id = request.GET['player_id']
        connection_params = "?player_id=" + param_player_id
        response = connection_service("/games/", None, connection_params, "GET")
        return Response(data=response, status=status.HTTP_200_OK)
    else:
        response = connection_service("/games/", None, None, "GET")
        return Response(data=response, status=status.HTTP_200_OK)


# -------------
# [POST] /games/
# -------------
def games_post(request):
    decode_error_message = generate_error_json(status.HTTP_400_BAD_REQUEST, 'Json decode error',
                                               'Your body should probably look like the value in correct_data',
                                               CORRECT_GAME_OBJ)

    json_request = get_json_data_object(request, decode_error_message)
    if type(json_request) is Response:
        return json_request

    game_req = json_request['game']
    json_body = {
        "game": {
            "match_name": game_req['match_name'],
            "question_duration": game_req['question_duration'],
            "questions": game_req['questions'],
            "player_status": game_req['player_status']
        }
    }
    response = connection_service("/games/", json_body, None, "POST")
    return Response(data=response, status=status.HTTP_201_CREATED)


# -------------
# [GET] /games/game_id/
# -------------
def single_game_get(request, game_id):
    response = connection_service(f"/games/{game_id}/", None, None, "GET")
    return Response(data=response, status=status.HTTP_200_OK)


# -------------
# [PUT] /games/game_id/
# -------------
def single_game_put(request, game_id):
    decode_error_message = generate_error_json(status.HTTP_400_BAD_REQUEST, 'Json decode error',
                                               'Your body should probably look like the value in correct_data',
                                               CORRECT_GAME_OBJ)

    json_request = get_json_data_object(request, decode_error_message)
    if type(json_request) is Response:
        return json_request

    game_req = json_request['game']
    json_body = {
        "game": {
            "match_name": game_req['match_name'],
            "question_duration": game_req['question_duration'],
            "questions": game_req['questions'],
            "player_status": game_req['player_status']
        }
    }
    response = connection_service(f"/games/{game_id}/", json_body, None, "PUT")
    return Response(data=response, status=status.HTTP_200_OK)


# -------------
# [DELETE] /games/game_id/
# -------------
def single_game_delete(request, game_id):
    response = connection_service(f"/games/{game_id}/", None, None, "DELETE")
    return Response(data=response, status=status.HTTP_200_OK)


# -------------
# [PUT] /games/game_id/player_status/game_round/
# -------------
def single_game_game_round_put(request, game_id):
    decode_error_message = generate_error_json(status.HTTP_400_BAD_REQUEST, 'Json decode error',
                                               'Your body should probably look like the value in correct_data',
                                               CORRECT_GAME_OBJ)

    json_request = get_json_data_object(request, decode_error_message)

    if type(json_request) is Response:
        return json_request

    player_id = request.GET["player_id"]

    response = connection_service(f"/games/{game_id}/player-status/game-round/?player_id={player_id}", json_request, None, "PUT")
    return Response(data=response, status=status.HTTP_200_OK)