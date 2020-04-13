from django.shortcuts import render
import json
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt

from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

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

def _init_(self):
    print("start token thread")
    _thread.start_new_thread(check_token_list_for_old_tokens())

# Create your views here.
def nothing(request):
    return HttpResponse("Hello, user. You're at the root index of the Gameserver Here we could have the entire REST tree printed")

@api_view(['GET'])
def get_players(request):
    print("getplayers")
    if token_status(str(request['token'])):
        #get the players and return the list
        response = connection_service("/user/", None, "GET")
        return Response(response, status = status.HTTP_200_OK)
    else:
        return Response("Token not valid. Please login again", status = status.HTTP_401_UNAUTHORIZED)

@api_view(['GET'])
def get_player(request, token, user_id):
    if token_status(str(request['token'])):
        #get the player from the DB
        user_id = str(request['user_id'])
        response = connection_service("/user/" + user_id, None, "GET")
        return Response(response, status=status.HTTP_200_OK)
    else:
        return Response("Token not valid. Please login again", status=status.HTTP_401_UNAUTHORIZED)

@api_view(['GET'])
def get_invites(request, token):
    if token_status(str(request['token'])):
        #get users invites from DB and return list of invites
        user_id = {"user_id":str(request['user_id'])}
        response = connection_service("/invites/", user_id, "GET")
        return Response(response, status=status.HTTP_200_OK)
    else:
        return Response("Token not valid. Please login again", status=status.HTTP_401_UNAUTHORIZED)

@api_view(['POST'])
def invite_player(request, token):
    if token_status(str(request['token'])):
        response = connection_service("/user/"+str(request['invited_player_id']))
        if response != None:
            invite_data = {"invited_player_id":str(request['invited_player_id']),"game_data":str(request['game_data'])}
            response = connection_service("/invites/",invite_data, "POST")
            return Response("Player invited", status=status.HTTP_200_OK)
        else:
            return Response("Token not valid. Please login again", status=status.HTTP_401_UNAUTHORIZED)

@api_view(['PUT'])
def accept_invite(request):
    if token_status(str(request['token'])):
        invite_data = {"invite_id":str(request['invite_id']),"accept":True}
        response = connection_service("/invites/", invite_data, "PUT")
        return Response("Invitation Accepted", status = status.HTTP_200_OK)
    else:
        return Response("Token not valid. Please login again", status=status.HTTP_401_UNAUTHORIZED)

#Test for the AUTH_SERVICE_ACCESS_KEY
#If so
#   Add the user_token to the token list with a timestamp
#   Return own ip address and port number to AUTH
#   Decode the request for userdata
#   Test to see if a user is already in the database(use dtu username)
#       If !so add the user to the database
@api_view(['POST'])
def register_user(request):

    print("Register User")
    logfile = open('GameServerLog.txt', 'a')

    try:
        decoded = request.body.decode('utf-8')
        #print("decoded: " + decoded)
        response = json.loads(decoded)
        #print("service_key: " + response['service_key'])
        if response['service_key'] == AUTH_SERVICE_ACCESS_KEY:
            #adding token to token list
            token = response['user_token']
            #print ("token: " + token)
            list_object = {"user_token":token,"time_stamp":str(datetime.now())}
            list_object_json = json.dumps(list_object)
            #print ("list object: " + list_object_json)

            token_user_list.append(list_object_json)
            #print("tokenlist: "+ token_user_list)
            #getting ip and port and returning it to the caller
            gameservice_ip = "127.0.0.1"
            gameservice_port ="9700"
            response={"gameservice_ip":gameservice_ip,"gameservice_port":gameservice_port}

            #Check if user is in our database
            #user = response['user_object']
            #Check database for user and add if not
            #check_and_add_user(user);
            return Response(response, status=status.HTTP_200_OK)
        else:
            return Response(status.HTTP_401_UNAUTHORIZED)
    except:
        return Response(data="error", status=status.HTTP_500_INTERNAL_SERVER_ERROR)

def token_status(token):
    for token in token_user_list:
        if token["user_token"] == token:
            return True
        else:
            return False

def check_and_add_user(user):

    dtu_usr_id = user['username']
    #get_usr_URL = "http://127.0.0.1:9600/user/"+dtu_usr_id
    #add_URL = "http://127.0.0.1:9600/add_usr"
    #check_params = {"dtu_user":user}
    #r = requests.post(url = get_usr_URL)
    #data = r.json()
    #game_service_user_object = data['game_service_user_object']
   # game_service_user_object.

    #if r.status_code == status.HTTP_200_OK:
    #    return data['game_service_user_object']
    #else:
        #Add user to database
    #    return False

    return True

def check_token_list_for_old_tokens():

    while True:

        print("token_user_list before check: " + token_user_list)
        for token in token_user_list:
                now_time = datetime.now()
                token_time = datetime(token['time_stamp'])
                if now_time.minute < token_time.minute+ MAX_TOKEN_AGE_MIN:
                    token_user_list.remove({"user_token":token})
        print("token_user_list after check and removal: " + token_user_list)
        time.sleep(FREQUENCY_OF_TOKEN_LIST_CHECK_SEC)

def connection_service(endpoint_url, body_data, method):
    build_URL = DATABASE_SERVICE_IP+":"+DATABASE_SERVICE_PORT+endpoint_url
    try:
        # Connect to Database Service
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
        # gameservice_ip = "192.168.1.1"
        # gameservice_port = "9700"
    except requests.exceptions as e:
        return e
    return data

##TIL SEBASTIAN. Husk at update timestamp til now i token_user_list for
# den token der foretager et "gamemove"