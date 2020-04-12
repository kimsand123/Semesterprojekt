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
token_user_list = []

def _init_(self):
    print("start token thread")
    _thread.start_new_thread(check_token_list_for_old_tokens())

# Create your views here.
def nothing(request):
    return HttpResponse("Hello, user. You're at the root index of the Gameserver Here we could have the entire REST tree printed")

#/players/token [GET] ()
#code: 200 (OK)
#{[userObject]}
#code 400 (Bad Request)
#{“reason”:”Your data is not formatted the proper way”,
#”helper”:”“Correct way: /players”}
#code 401 (Unauthorized)
#{“reason: “Your token was invalid”}
@api_view(['GET'])
def get_players(request):
    print("getplayers")
    if token_status(request['token']):
        #get the players and return the list
        return Response("get_players")

#/players/token/player_id [GET] ()
#code: 200 (OK)
#{[userObject]}
#code 400 (Bad Request)
#{“reason”:”Your data is not formatted the proper way”,
#”helper”:”Correct way: /players/token”}
#code 401 (Unauthorized)
#{“reason: “Your token was invalid”}
@api_view(['GET'])
def get_player(request, token, player_id):
    if token_status(request['token']):
        #get the player from the DB
        print("getplayer")
        return Response("get_player")

# /invites/token/invites/[GET]
# code: 200 (OK)
# {[invite_objects]}
# code 401 (Unauthorized)
# {“reason: “Your token was invalid”}
@api_view(['GET'])
def get_invites(request, token):
    if token_status(request['token']):
        #get users invites from DB and return list of invites
        return Response("get_invites")

#/invites/token/ [POST] (formparam: {“invite_player_id”:”invite_player_id”,”invitation_parameters”:”invitation_parameters”})
#code: 200 (OK)
#{“”}
#code 400 (Bad Requestt
#{“reason”:”Your data is not formatted the proper way”,
#”helper”:”Correct way: /players/token/invite and then a JSON formatted {“invite_player_id”:”invite_player_id”,"invitation":"invitation_parameters"}}”
#code 401 (Unauthorized)
#{“reason: “Your token was invalid”}
@api_view(['POST'])
def invite_player(request, token):
    if token_status(request['token']):
        #check if invited player exists
        #create invitation with invite_player_id and invitation_parameters
        return Response("invite_player")


#/invites/token/invite_id [PUT]
#code: 200 (OK)
#{“game_id”:”game_id”}
#code 400 (Bad Request)
#{“reason”:”Your data is not formatted the proper way”,
#”helper”:”Correct way: /players/token/invite_id
#code 401 (Unauthorized)
#{“reason: “Your token was invalid”}
@api_view(['PUT'])
def get_specific_invites(request, token, invite_id):
    if token_status(request['token']):
        #get specific invite from db with invite_id
        print("Accept invitation")
        return Response("get_specific_invites")

#/players/registeruser/ [POST] (formparam: {“service_key”:”service_key”,”user_token”:”user_token”, “user_object”:“user_object”})
#code: 200 (OK)
#{“gameservice_ip”:”gameservice_ip”,”gameservice_port”:”gameservice_port”}
#code 400 (Bad Request)
#{“reason”:”Your data is not formatted the proper way”,
#”helper”:”Correct way: /registeruser and then a JSON formatted {“service_key”:”service_key”,”user_token”:”user_token”, “user_object”:“user_object”}”}
#code 500 (Internal Server Error)
#{“reason: “Something bad happened”}
@api_view(['POST'])
#@csrf_exempt
def register_user(request):
    #Test for the AUTH_SERVICE_ACCESS_KEY
    #If so
    #   Add the user_token to the token list with a timestamp
    #   Return own ip address and port number to AUTH
    #   Decode the request for userdata
    #   Test to see if a user is already in the database(use dtu username)
    #       If !so add the user to the database
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

##TIL SEBASTIAN. Husk at update timestamp til now i token_user_list for
# den token der foretager et "gamemove"