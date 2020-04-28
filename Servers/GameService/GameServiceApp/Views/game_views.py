from rest_framework.decorators import api_view
from GameServiceApp.check_token import token_status
from GameServiceApp.helper_methods import *
from ..correct_data import CORRECT_GAME_OBJ

# TIL SEBASTIAN. Husk at update timestamp til now i token_user_list for
# den token der foretager et "gamemove"
@api_view(['POST', 'GET'])
def games(request):
    if request.method == 'POST':
        decode_error_message = generate_error_json(status.HTTP_400_BAD_REQUEST, 'Json decode error',
                                                   'Your body should probably look like the value in correct_data',
                                                   CORRECT_GAME_OBJ)
    else:
        decode_error_message = generate_error_json(status.HTTP_400_BAD_REQUEST, 'Json decode error',
                                                   'Your body should probably look like the value in correct_data',
                                                   {"user_token": "your_token"})

    json_request = get_json_data_object(request, decode_error_message)
    if type(json_request) is Response:
        return json_request

    if token_status(json_request['user_token']):
        if request.method == 'POST':
            game_req = json_request['game']
            json_body = {
                "game": {
                    "match_name": game_req['match_name'],
                    "question_duration": game_req['question_duration'],
                    "questions": game_req['questions'],
                    "player_status": game_req['player_status']
                }
            }
            response = connection_service("/games/", json_body, "POST")
            return Response(data=response, status=status.HTTP_201_CREATED)
        elif request.method == 'GET':
            if 'player_id' in json_request:
                json_body = {
                    "player_id": json_request['player_id']
                }
                response = connection_service("/games/", json_body, "GET")
                return Response(data=response, status=status.HTTP_200_OK)
            else:
                response = connection_service("/games/", None, "GET")
                return Response(data=response, status=status.HTTP_200_OK)
    else:
        error_message = generate_error_json(status.HTTP_401_UNAUTHORIZED, "Token was invalid", None, None)
        return Response(data=error_message, status=status.HTTP_401_UNAUTHORIZED)


@api_view(['GET', 'PUT', 'DELETE'])
def single_game(request, game_id):
    if request.method == "PUT":
        decode_error_message = generate_error_json(status.HTTP_400_BAD_REQUEST, 'Json decode error',
                                               'Your body should probably look like the value in correct_data',
                                               CORRECT_GAME_OBJ)
    else:
        decode_error_message = generate_error_json(status.HTTP_400_BAD_REQUEST, 'Json decode error',
                                                   'Your body should probably look like the value in correct_data',
                                                   {"user_token": "your_token"})

    json_request = get_json_data_object(request, decode_error_message)
    if type(json_request) is Response:
        return json_request

    if token_status(json_request['user_token']):
        if request.method == 'GET':
            response = connection_service(f"/games/{game_id}/", None, "GET")
            return Response(data=response, status=status.HTTP_200_OK)

        elif request.method == 'PUT':
            game_req = json_request['game']
            json_body = {
                "game": {
                    "match_name": game_req['match_name'],
                    "question_duration": game_req['question_duration'],
                    "questions": game_req['questions'],
                    "player_status": game_req['player_status']
                }
            }
            response = connection_service(f"/games/{game_id}/", json_body, "PUT")
            return Response(data=response, status=status.HTTP_200_OK)
        elif request.method == 'DELETE':
            response = connection_service(f"/games/{game_id}/", None, "DELETE")
            return Response(data=response, status=status.HTTP_200_OK)
    else:
        error_message = generate_error_json(status.HTTP_401_UNAUTHORIZED, "Token was invalid", None, None)
        return Response(data=error_message, status=status.HTTP_401_UNAUTHORIZED)


def generate_error_json(status_code, reason, suggestion, correct_data):
    if suggestion == None and correct_data == None:
        json_message = {
            'status': status_code,
            'reason': reason
        }
    else:
        json_message = {
            'status': status_code,
            'reason': reason,
            'suggestion': suggestion,
            'correct_data': correct_data
        }
    return json_message
