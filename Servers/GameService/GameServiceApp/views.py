from django.shortcuts import render
import json
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt

from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
import random

import _thread
import time

import requests

from datetime import datetime

AUTH_SERVICE_ACCESS_KEY = "HBdjm4VDLxn8mU2Eh7EzwNdhAEYp7bm9HvgwEJVGeM6NaBFvFFS48qbSHUYKLkuZPRWKxvGJsu4RewuuR6SVEEbH5aUqjD7H8wMeEPBd5d4G8UfB7QxhuTPPF8KKZg53zvUdv63ravcBAzdgPRbxcVu7pb6NPRfVLf3fFznvCX5ey2by6kGe3HrZX6kBTsJxTS6cL4KwkQDaN5YTq5jzQrQ4wLaXBYzx9y4w5sXdfkhLWuCL5wdFMtgbd8cNTemR"
MAX_TOKEN_AGE_MIN = 30
FREQUENCY_OF_TOKEN_LIST_CHECK_SEC = 60
DATABASE_SERVICE_IP = "127.0.0.1"
DATABASE_SERVICE_PORT = "9600"

token_user_list = []

def check_token_list_for_old_tokens():
    while True:
        print("token_user_list before check: " + str(token_user_list))
        for token in token_user_list:
                now_time = datetime.now()
                token_time = datetime(token['time_stamp'])
                if now_time.minute < token_time.minute+ MAX_TOKEN_AGE_MIN:
                    token_user_list.remove({"user_token":token})
        print("token_user_list after check and removal: " + str(token_user_list))
        time.sleep(FREQUENCY_OF_TOKEN_LIST_CHECK_SEC)

def token_status(token):
    print("token_list: "+ str(token_user_list))
    print ("token "+ token)
    for json_object in token_user_list:
        data = json.loads(json_object)
        if data["user_token"] == token:
            return True
    return False

def connection_service(endpoint_url, body_data, method):
    build_URL = "http://"+DATABASE_SERVICE_IP+":"+DATABASE_SERVICE_PORT+endpoint_url
    print("METHOD: " + method)
    print("BODY_DATA: " + str(body_data))
    print ("URL: " + build_URL)
    try:
        if method == "POST":
            if body_data != None:
                r = requests.post(url=build_URL, json=body_data)
            else:
                r = requests.post(url = build_URL)
        if method == "GET":
            if body_data != None:
                r = requests.get(url = build_URL, json=body_data)
            else:
                r = requests.get( url = build_URL)
        if method == "PUT":
            if body_data != None:
                r = requests.put(url = build_URL, json=body_data)
            else:
                r = requests.put( url = build_URL)
        data = r.json()
    except requests.exceptions as e:
        return e
    return data

def get_json_data_object(request):
    try:
        decoded = request.body.decode('utf-8')
        request_json = json.loads(decoded)
        print("json : "+ str(request_json))
    except:
        return "json error"
    return request_json


#def main():
#    print("start token thread")
#    _thread.start_new_thread(check_token_list_for_old_tokens())

#main()


# Create your views here.
def nothing(request):
    return HttpResponse("Hello, user. You're at the root index of the Gameserver Here we could have the entire REST tree printed")

@api_view(['GET'])
def get_players(request):
    print("getplayers")
    req_json = get_json_data_object(request)
    if req_json == "json error":
        print ("json error")
        return Response(data = 'Json decode error. Your body should look like {"user_token":"Yourtoken"}', status = status.HTTP_400_BAD_REQUEST)
    print("req_json: "+ str(req_json))
    if token_status(req_json['user_token']):
        response = connection_service("/players/", None, "GET")
        return Response(data = response, status = status.HTTP_200_OK)
    else:
        return Response(data = "Token not valid. Please login again", status = status.HTTP_401_UNAUTHORIZED)

@api_view(['GET'])
def get_player(request, player_id):
    print("player_id " + player_id)
    print("request: " + str(request))
    req_json = get_json_data_object(request)
    #print("req_json: " + str(req_json))
    if req_json == "json error":
        print("json error")
        return Response(data='Json decode error. The endpoint is /players/player_id and your body should look like {"user_token":"Yourtoken"}',
                        status=status.HTTP_400_BAD_REQUEST)
    if token_status(req_json['user_token']):
        response = connection_service("/players/" + player_id+"/", None, "GET")
        #response = {"test":"kim"}
        return Response(data = response, status=status.HTTP_200_OK)
    else:
        return Response(data = "Token not valid. Please login again", status=status.HTTP_401_UNAUTHORIZED)

@api_view(['POST'])
def register_user(request):
    print("Register User")
    logfile = open('GameServerLog.txt', 'a')
    req_json = get_json_data_object(request)
    #print ("req_json "+  str(req_json))
    try:
        print("service_key: " + req_json['service_key'])
        #Is the access key right.
        if req_json['service_key'] == AUTH_SERVICE_ACCESS_KEY:

            # Check if user is in our database
            player_id = check_and_add_user(req_json['user_object'])

            #If the player is not already logged in
            if player_id not in token_user_list:

                # Add token, timestamp and player_id to token_user_list
                token = req_json['user_token']
                user_list_object = {"user_token": token, "time_stamp": str(datetime.now()), "player_id": player_id}
                user_list_object_json = json.dumps(user_list_object)
                token_user_list.append(user_list_object_json)
                #print("tokenlist: " + str(token_user_list))
                gameservice_ip = "127.0.0.1"
                gameservice_port ="9700"
                response={"gameservice_ip":gameservice_ip,"gameservice_port":gameservice_port,"player_id":player_id}
                print("response before sending: " + str(response))
                return Response(response, status=status.HTTP_200_OK)
            else:
                return Response(data = "You cannot log in twice at the same time", status = status.HTTP_208_ALREADY_REPORTED )
        else:
            return Response(status.HTTP_401_UNAUTHORIZED)
    except:
        return Response(data="error", status=status.HTTP_500_INTERNAL_SERVER_ERROR)

def invites(request):
    if request.method == 'GET':
        if token_status(str(request['token'])):
            # get users invites from DB and return list of invites
            user_id = {"user_id": str(request['user_id'])}
            response = connection_service("/invites/", user_id, "GET")
            return Response(response, status=status.HTTP_200_OK)
        else:
            return Response("Token not valid. Please login again", status=status.HTTP_401_UNAUTHORIZED)
    if request.method == 'POST':
        if token_status(str(request['token'])):
            response = connection_service("/user/" + str(request['invited_player_id']))
            if response != None:
                invite_data = {"invited_player_id": str(request['invited_player_id']),
                               "game_data": str(request['game_data'])}
                response = connection_service("/invites/", invite_data, "POST")
                return Response("Player invited", status=status.HTTP_200_OK)
            else:
                return Response("Token not valid. Please login again", status=status.HTTP_401_UNAUTHORIZED)

@api_view(['POST', 'GET'])
@csrf_exempt
def invites(request):
    req_json = get_json_data_object(request)
    if token_status(req_json['user_token']):
        if request.method == 'POST':
            sender_player_id = req_json['sender_player_id']
            reciever_player_id = req_json['reciever_player_id']
            match_name = req_json['match_name']
            question_duration = req_json['question_duration']

            try:
                    response = connection_service("/players/" + str(reciever_player_id) +"/", None, "GET")
            except:
                    return Response ("The player you want to invite does not exist anymore", status=status.HTTP_204_NO_CONTENT)

            form_param = {"invite":{"sender_player_id":str(sender_player_id),"receiver_player_id":str(reciever_player_id),"match_name":match_name,"question_duration":str(question_duration),"accepted":False}}
            response = connection_service("/invites/", form_param, "POST")
            return Response(response = "Player " + response['first_name'] + " " + response['last_name']+ " has been invited to play", status = status.HTTP_200_OK)


        if request.method == 'GET':
            
            return Response("asdf", status=status.HTTP_200_OK)
        else:
            return Response("Token not valid. Please login again", status=status.HTTP_401_UNAUTHORIZED)


@api_view(['PUT'])
def accept_invite(request, invite_id):
    if token_status(str(request['token'])):
        invite_data = {"invite_id":invite_id,"accept":True}
        response = connection_service("/invites/", invite_data, "PUT")
        return Response(data = "Invitation Accepted", status = status.HTTP_200_OK)
    else:
        return Response("Token not valid. Please login again", status=status.HTTP_401_UNAUTHORIZED)

def check_and_add_user(user):
    player = user['player']
    dtu_username = player['username']
    #print("dtu_username: " + dtu_username)
    data = connection_service("/players/" + dtu_username+"/", None, "GET")
    #If the player exists

    if 'player' not in data:
        data = connection_service("/players/", user, "POST")

    player = data['player']
    player_id = player['id']
    return player_id











































##TIL SEBASTIAN. Husk at update timestamp til now i token_user_list for
# den token der foretager et "gamemove"

@api_view(['GET'])
def get_games(request):
    decoded = request.body.decode('utf-8')
    data = json.loads(decoded)
    if token_status(data['token']):
        response = connection_service("/games/", None, "GET")
        return Response(data=response, status=status.HTTP_200_OK)
    else:
        response = generate_error_json(status.HTTP_401_UNAUTHORIZED, 'Your token was invalid', None)
        return Response(data=response, status=status.HTTP_401_UNAUTHORIZED)


@api_view(['GET'])
def get_game(request, game_id):
    decoded = request.body.decode('utf-8')
    data = json.loads(decoded)
    if token_status(data['token']):
        response = connection_service(f"/games/{game_id}", None, "GET")
        return Response(data=response, status=status.HTTP_200_OK)
    else:
        response = generate_error_json(status.HTTP_401_UNAUTHORIZED, 'Your token was invalid', None)
        return Response(data=response, status=status.HTTP_401_UNAUTHORIZED)

@api_view(['GET'])
def get_all_player_status(request, game_id):
    decoded = request.body.decode('utf-8')
    data = json.loads(decoded)
    if token_status(data['token']):
        response = connection_service(f"/games/{game_id}/player_status/", None, "GET")
        return Response(data=response, status=status.HTTP_200_OK)
    else:
        response = generate_error_json(status.HTTP_401_UNAUTHORIZED, 'Your token was invalid', None)
        return Response(data=response, status=status.HTTP_401_UNAUTHORIZED)

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
            'Correct way: {/games/game_id/player_status/player_id/status} and then a JSON  in the body, formatted {“GameUserStatus”:GameUserStatus, "token": token}')
            return Response(data=response, status=status.HTTP_400_BAD_REQUEST)
    else:
        response = generate_error_json(status.HTTP_401_UNAUTHORIZED, 'Your token was invalid', None)
        return Response(data=response, status=status.HTTP_401_UNAUTHORIZED)

def generate_error_json(status_code, reason, suggestion):
    if suggestion == None:
        json_message = {
            'status': status_code,
            'reason': reason
        }
    else:
        json_message = {
            'status': status_code,
            'reason': reason,
            'suggestion': suggestion
        }
    return json_message