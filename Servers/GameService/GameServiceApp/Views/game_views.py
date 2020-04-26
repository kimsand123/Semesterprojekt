from rest_framework.decorators import api_view
from GameServiceApp.check_token import token_status
from GameServiceApp.helper_methods import *

# TIL SEBASTIAN. Husk at update timestamp til now i token_user_list for
# den token der foretager et "gamemove"
@api_view(['POST', 'GET'])
def games(request):
    decode_error_message = generate_error_json(status.HTTP_400_BAD_REQUEST, 'Json decode error',
                                               'Your body should probably look like the value in correct_data',
                                               {"user_token": "your_token"})

    json_request = get_json_data_object(request, decode_error_message)
    if type(json_request) is Response:
        return json_request

    if token_status(json_request['user_token']):
        if request.method == 'POST':
            game_req = json_request['game']
            print(game_req['player_status'])
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
            response = connection_service("/games/", None, "GET")
            return Response(data=response, status=status.HTTP_200_OK)
    else:
        error_message = generate_error_json(status.HTTP_401_UNAUTHORIZED, "Token was invalid", None, None)
        return Response(data=error_message, status=status.HTTP_401_UNAUTHORIZED)


@api_view(['GET', 'PUT'])
def single_game(request, game_id):
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
    else:
        error_message = generate_error_json(status.HTTP_401_UNAUTHORIZED, "Token was invalid", None, None)
        return Response(data=error_message, status=status.HTTP_401_UNAUTHORIZED)


@api_view(['GET'])
def get_all_player_status(request, game_id):
    json_request = get_json_data_object(request, "Error-message")
    if json_request == "json error":
        error_message = generate_error_json(status.HTTP_400_BAD_REQUEST, 'Json decode error',
                                            'Your body should look like {"user_token": "your_token"}',
                                            str(request.get_raw_uri()))
        return Response(data=error_message, status=status.HTTP_400_BAD_REQUEST)
    if token_status(json_request['user_token']):
        # response = connection_service(f"/games/{game_id}/", None, "GET")
        response = requests.get(url=f"http://127.0.0.1:9600/games/{game_id}/").json()
        data = response['game']['player_status']
        return Response(data=data, status=status.HTTP_200_OK)
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
