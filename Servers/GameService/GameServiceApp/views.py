from django.shortcuts import render
import json
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt

from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

import requests

from datetime import datetime

AUTH_SERVICE_ACCESS_KEY = "HBdjm4VDLxn8mU2Eh7EzwNdhAEYp7bm9HvgwEJVGeM6NaBFvFFS48qbSHUYKLkuZPRWKxvGJsu4RewuuR6SVEEbH5aUqjD7H8wMeEPBd5d4G8UfB7QxhuTPPF8KKZg53zvUdv63ravcBAzdgPRbxcVu7pb6NPRfVLf3fFznvCX5ey2by6kGe3HrZX6kBTsJxTS6cL4KwkQDaN5YTq5jzQrQ4wLaXBYzx9y4w5sXdfkhLWuCL5wdFMtgbd8cNTemR"
token_user_list = []

# Create your views here.
def nothing(request):
    return HttpResponse("Hello, world. You're at the root index")

#/players/token [GET] ()
#code: 200 (OK)
#{[userObject]}
#code 400 (Bad Request)
#{“reason”:”Your data is not formatted the proper way”,
#”helper”:”“Correct way: /players”}
#code 401 (Unauthorized)
#{“reason: “Your token was invalid”}
@api_view(['GET'])
def get_players(request, token):
    None

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
    return None

# /invites/token/invites/[GET]
# code: 200 (OK)
# {[invite_objects]}
# code 401 (Unauthorized)
# {“reason: “Your token was invalid”}
@api_view(['GET'])
def get_invites(request, token):
    return None

#/invites/token/ [POST] (formparam: {“invite_player_id”:”invite_player_id”,”invitation_parameters”:”invitation_parameters”})
#code: 200 (OK)
#{“”}
#code 400 (Bad Request)
#{“reason”:”Your data is not formatted the proper way”,
#”helper”:”Correct way: /players/token/invite and then a JSON formatted {“invite_player_id”:”invite_player_id”}}”
#code 401 (Unauthorized)
#{“reason: “Your token was invalid”}
@api_view(['POST'])
def invite_player(request, token):
    return None


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
    print("Accept invitation")
    return Response(data="accept invitation", status=status.HTTP_200_OK)

#/players/registeruser/ [POST] (formparam: {“service_key”:”service_key”,”user_token”:”user_token”, “user_object”:“user_object”})
#code: 200 (OK)
#{“gameservice_ip”:”gameservice_ip”,”gameservice_port”:”gameservice_port”}
#code 400 (Bad Request)
#{“reason”:”Your data is not formatted the proper way”,
#”helper”:”Correct way: /registeruser and then a JSON formatted {“service_key”:”service_key”,”user_token”:”user_token”, “user_object”:“user_object”}”}
#code 500 (Internal Server Error)
#{“reason: “Something bad happened”}
@api_view(['POST'])
@csrf_exempt
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
        response = json.loads(decoded)
        if response['AUTH_SERVICE_ACCESS_KEY'] == AUTH_SERVICE_ACCESS_KEY:
            #adding token to token list
            token = response['user_token']
            token_user_list.append({"user_token":token,"time_stamp":str(datetime.now())})

            #getting ip and port and returning it to the caller
            gameservice_ip = "127.0.0.1"
            gameservice_port ="9700"
            yield Response(gameservice_ip, gameservice_port, status=status.HTTP_200_OK)

            #Check if user is in our database
            user = response['user']
            #Check database for user and add if not
            check_and_add_user(user);


            list_object = {"token":token,}
            token_user_list.append()
    except:
        return Response(data="error", status=status.HTTP_500_INTERNAL_SERVER_ERROR)



def check_and_add_user(user):
    dtu_usr_id = user.dtu
    get_usr_URL = "http://127.0.0.1:9600/user/"+dtu_usr_id
    add_URL = "http://127.0.0.1:9600/add_usr"
    check_params = {"dtu_user":user}
    r = requests.post(url = get_usr_URL)
    data = r.json()
    game_service_user_object = data['game_service_user_object']
    game_service_user_object.

    
    if r.status_code == status.HTTP_200_OK:
        return data['game_service_user_object']
    else:
        #Add user to database
        return False







    return None
