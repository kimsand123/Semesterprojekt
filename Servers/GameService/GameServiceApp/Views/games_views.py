from ..views import token_status, connection_service, get_json_data_object
from django.shortcuts import render
import json
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
import requests
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

##TIL SEBASTIAN. Husk at update timestamp til now i token_user_list for
# den token der foretager et "gamemove"

@api_view(['GET'])
def get_games(request):
    json_request = get_json_data_object(request)
    if json_request == "json error":
        error_message = generate_error_json(status.HTTP_400_BAD_REQUEST, 'Json decode error',  'Your body should look like {"user_token": "your_token"}', str(request.get_raw_uri()))
        return Response(data=error_message, status=status.HTTP_400_BAD_REQUEST)
    if token_status(json_request['user_token']):
        response = connection_service("/games/", None, "GET")
        return Response(data=response, status=status.HTTP_200_OK)
    else:
        error_message = generate_error_json(status.HTTP_401_UNAUTHORIZED, "Token was invalid", None, None)
        return Response(data=error_message, status=status.HTTP_401_UNAUTHORIZED)


@api_view(['GET'])
def get_game(request, game_id):
    json_request = get_json_data_object(request)
    if json_request == "json error":
        error_message = generate_error_json(status.HTTP_400_BAD_REQUEST, 'Json decode error',  'Your body should look like {"user_token": "your_token"}', str(request.get_raw_uri()))
        return Response(data=error_message, status=status.HTTP_400_BAD_REQUEST)
    if token_status(json_request['user_token']):
        response = connection_service(f"/games/{game_id}/", None, "GET")
        return Response(data=response, status=status.HTTP_200_OK)
    else:
        error_message = generate_error_json(status.HTTP_401_UNAUTHORIZED, "Token was invalid", None, None)
        return Response(data=error_message, status=status.HTTP_401_UNAUTHORIZED)

@api_view(['GET'])
def get_all_player_status(request, game_id):
    json_request = get_json_data_object(request)
    if json_request == "json error":
        error_message = generate_error_json(status.HTTP_400_BAD_REQUEST, 'Json decode error',  'Your body should look like {"user_token": "your_token"}', str(request.get_raw_uri()))
        return Response(data=error_message, status=status.HTTP_400_BAD_REQUEST)
    if token_status(json_request['user_token']):
        #response = connection_service(f"/games/{game_id}/", None, "GET")
        response = requests.get(url = f"https://api.dinodev.dk/games/{game_id}/").json()
        data = response['game']['player_status']
        return Response(data=data, status=status.HTTP_200_OK)
    else:
        error_message = generate_error_json(status.HTTP_401_UNAUTHORIZED, "Token was invalid", None, None)
        return Response(data=error_message, status=status.HTTP_401_UNAUTHORIZED)

@api_view(['POST'])
def set_player_status(request, game_id, player_id):
    decoded = request.body.decode('utf-8')
    data = json.loads(decoded)
    if token_status(data['token']):
        if request['game_user_status'] != None:
            game_player_status = {'game_user_status': str(request['game_user_status']), 'token': str(request['token'])}
            response = connection_service(f"/games/{game_id}/player_status/{player_id}/status", game_player_status, "POST")
            return Response(data=response, status=status.HTTP_200_OK)
        else:
            response = generate_error_json(status.HTTP_400_BAD_REQUEST,
            'Your data is not formatted the proper way',
            'Correct way: {/games/game_id/player_status/player_id/status} and then a JSON  in the body, formatted {“GameUserStatus”:GameUserStatus, "token": token}', str(request.get_raw_uri()))
            return Response(data=response, status=status.HTTP_400_BAD_REQUEST)
    else:
        response = generate_error_json(status.HTTP_401_UNAUTHORIZED, 'Your token was invalid', None, None)
        return Response(data=response, status=status.HTTP_401_UNAUTHORIZED)

def generate_error_json(status_code, reason, suggestion, endpoint):
    if suggestion == None and endpoint == None:
        json_message = {
            'status': status_code,
            'reason': reason
        }
    else:
        json_message = {
            'status': status_code,
            'reason': reason,
            'suggestion': suggestion,
            'correct_url': endpoint
        }
    return json_message