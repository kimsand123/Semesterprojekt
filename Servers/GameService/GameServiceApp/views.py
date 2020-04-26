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

###Check if token is in the token_list and return true otherwise return false
def token_status(token):
    print("token_list: "+ str(token_user_list))
    print ("token "+ token)
    for json_object in token_user_list:
        data = json.loads(json_object)
        if data["user_token"] == token:
            return True
    return False

###Check if user is in db, if it is return id, if not create player and return id
def check_or_add_user(user):
    player = user['player']
    dtu_username = player['username']
    data = connection_service("/players/" + dtu_username + "/", None, "GET")

    # If the player doesnt exist
    if 'player' not in data:
        data = connection_service("/players/", user, "POST")

    player = data['player']
    player_id = player['id']
    return player_id

###A general request method that is called everytime there is a request.
def connection_service(endpoint_url, body_data, method):
    build_URL = "http://"+DATABASE_SERVICE_IP+":"+DATABASE_SERVICE_PORT+endpoint_url
    print("METHOD: " + method)
    print("BODY_DATA: " + str(body_data))
    print ("URL: " + build_URL)
    headers = {"Authorization" : "Bearer 5AF4813A4FCE13A2D5436A3E33BAA"}
    try:
        if method == "POST":
            if body_data != None:
                r = requests.post(url=build_URL, json=body_data, headers = headers)
            else:
                r = requests.post(url = build_URL, headers = headers)
        if method == "GET":
            if body_data != None:
                r = requests.get(url = build_URL, json=body_data, headers = headers)
            else:
                r = requests.get( url = build_URL, headers = headers)
        if method == "PUT":
            if body_data != None:
                r = requests.put(url = build_URL, json=body_data, headers = headers)
            else:
                r = requests.put( url = build_URL, headers = headers)
        data = r.json()
    except requests.exceptions as e:
        return e
    return data

###Get the json data object from the request that is sent to an endpoint from user
def get_json_data_object(request, error_message):
    try:
        decoded = request.body.decode('utf-8')
        request_json = json.loads(decoded)
        print("json : "+ str(request_json))
    except:
        return Response (data = error_message, status = status.HTTP_400_BAD_REQUEST)
    return request_json


#def main():
#    print("start token thread")
#    _thread.start_new_thread(check_token_list_for_old_tokens())

#main()


# Create your views here.
def nothing(request):
    return HttpResponse("Hello, user. You're at the root index of the Gameserver Here we could have the entire REST tree printed")


### PLAYERS ###

###Get all players
@api_view(['GET'])
def get_players(request):
    ###Check if request body is properly json formatted
    req_json = get_json_data_object(request, "There is an error in your body json format. It should be ex{'user_token':'Yourtoken'}")
    if type(req_json) == Response:
        return req_json

    ##If token is present in the list do the following
    if token_status(req_json['user_token']):
        response = connection_service("/players/", None, "GET")
        return Response(data = response, status = status.HTTP_200_OK)
    else:
        return Response(data = "Token not valid. Please login again", status = status.HTTP_401_UNAUTHORIZED)

###Get specific player
@api_view(['GET'])
def get_player(request, player_id):
    ###Check if request body is properly json formatted
    req_json = get_json_data_object(request, "There is an error in your body json format. It should be ex {'user_token':'Yourtoken'}")
    if type(req_json) == Response:
        return Response(req_json)

    ##If token is present in the list do the following
    if token_status(req_json['user_token']):
        response = connection_service("/players/" + player_id+"/", None, "GET")
        return Response(data = response, status=status.HTTP_200_OK)
    else:
        return Response(data = "Token not valid. Please login again", status=status.HTTP_401_UNAUTHORIZED)

###Login   if player already present in db, return playerobject, otherwise create player in db and return playerobject
@api_view(['POST'])
def register_user(request):
    logfile = open('GameServerLog.txt', 'a')

    ###Check if request body is properly json formatted
    req_json = get_json_data_object(request, "There is an error in your body json format. It should be ex {'username':'Your_user_name','password':'Your_password'}")
    if type(req_json) == Response:
        return Response(req_json)

    try:
        #Is the access key right.
        if req_json['service_key'] == AUTH_SERVICE_ACCESS_KEY:

            # check or add user
            player_id = check_or_add_user(req_json['user_object'])

            #If the player is not already logged in
            if player_id not in token_user_list:

                # Add token, timestamp and player_id to token_user_list
                token = req_json['user_token']
                user_list_object = {"user_token": token, "time_stamp": str(datetime.now()), "player_id": player_id}
                user_list_object_json = json.dumps(user_list_object)
                token_user_list.append(user_list_object_json)
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


### INVITES ###
###POST = Invite player. GET = get all invites
@api_view(['POST', 'GET'])
@csrf_exempt
def invites(request):
    invite_response = ""
    ##Check if the request body has the proper json format
    req_json = get_json_data_object(request, "There is an error in your body json format. It should be ex {'user_token':'your_user_token','sender_player_id':38,'reciever_player_id':39,'match_name':'TestMatch','question_duration':5}")
    if type(req_json) == Response:
        return req_json

    ##If token is present in the list do the following
    if token_status(req_json['user_token']):
        if request.method == 'POST':
            ##Getting relevant data from the request to use later
            sender_player_id = req_json['sender_player_id']
            reciever_player_id = req_json['reciever_player_id']
            match_name = req_json['match_name']
            question_duration = req_json['question_duration']

            ##Check if the invited player already exists in DB
            try:
                    response = connection_service("/players/" + str(reciever_player_id) +"/", None, "GET")
            except:
                    return Response ("The player you want to invite does not exist anymore", status=status.HTTP_204_NO_CONTENT)
            ##End Check

            ##Setting parameters and getting the response
            form_param = {"invite":{"sender_player_id":str(sender_player_id),"receiver_player_id":str(reciever_player_id),"match_name":match_name,"question_duration":str(question_duration),"accepted":False}}
            response = connection_service("/invites/", form_param, "POST")

            ##Getting data for  the invite_response var
            invite_object = response['invite']
            reciever_player = invite_object['receiver_player']

            invite_response = "Player " + reciever_player['first_name'] + " " + reciever_player['last_name']+ " has been invited to play"

        if request.method == 'GET':
            form_param = {"player_id":req_json['player_id']}
            invite_response = connection_service("/invites/", form_param, "GET")
        return Response(data = invite_response , status=status.HTTP_200_OK)
    else:
        return Response("Token not valid. Please login again", status=status.HTTP_401_UNAUTHORIZED)


###Hent alle invites til en spiller.
@api_view(['GET'])
def get_invites_for_player(request):
    req_json = get_json_data_object(request, "There is an error in your body json format. It should be ex {'user_token':'your_user_token'")
    if type(req_json) == Response:
        return Response(req_json)


###Accept invitation
@api_view(['PUT'])
def accept_invite(request, invite_id):
    ##Check if the request body has the proper json format
    req_json = get_json_data_object(request, "There is an error in your body json format. It should be ex {'user_token':'your_user_token'")
    if type(req_json) == Response:
        return Response(req_json)

    ##If token is present in the list do the following
    if token_status(req_json['user_token']):
        ##Create the json package for the request
        invite_data = {"invite":{"sender_player_id":str(req_json['sender_player_id']),
                       "reciever_player_id":str(req_json['reciever_player_id']),
                       "match_name":req_json['match_name'],
                       "question_duration":req_json['question_duration'],
                       "accepted":True}}
        response = connection_service("/invites/"+invite_id+"/", invite_data, "PUT")
        return Response(data = "Invitation Accepted", status = status.HTTP_200_OK)
    else:
        return Response("Token not valid. Please login again", status=status.HTTP_401_UNAUTHORIZED)


