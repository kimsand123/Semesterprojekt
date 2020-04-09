from django.shortcuts import render
import json
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt

from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

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
    print("Register User")
    logfile = open('GameServerLog.txt', 'a')
    try:
        decoded = request.body.decode('utf-8')
        response = json.loads(decoded)
        if response['AUTH_SERVICE_ACCESS_KEY'] == AUTH_SERVICE_ACCESS_KEY:
            token = response['user_token']
            user = response['user']
            #if user_id is found in db,



            list_object = {"token":token,}
            token_user_list.append()






        return Response(data="test", status=status.HTTP_200_OK)






