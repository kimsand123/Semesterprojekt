from django.shortcuts import render
import json

from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

# Create your views here.


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

#/players/token/player_id [GET] ()
#code: 200 (OK)
#{[userObject]}
#code 400 (Bad Request)
#{“reason”:”Your data is not formatted the proper way”,
#”helper”:”Correct way: /players/token”}
#code 401 (Unauthorized)
#{“reason: “Your token was invalid”}
@api_view(['GET'])
def get_player(request):


# /invites/token/invites/[GET]
# code: 200 (OK)
# {[invite_objects]}
# code 401 (Unauthorized)
# {“reason: “Your token was invalid”}
@api_view(['GET'])
def get_invites(request):

#/invites/token/ [POST] (formparam: {“invite_player_id”:”invite_player_id”,”invitation_parameters”:”invitation_parameters”})
#code: 200 (OK)
#{“”}
#code 400 (Bad Request)
#{“reason”:”Your data is not formatted the proper way”,
#”helper”:”Correct way: /players/token/invite and then a JSON formatted {“invite_player_id”:”invite_player_id”}}”
#code 401 (Unauthorized)
#{“reason: “Your token was invalid”}
@api_view(['POST'])
def invite_player(request):


#/invites/token/invite_id [PUT]
#code: 200 (OK)
#{“game_id”:”game_id”}
#code 400 (Bad Request)
#{“reason”:”Your data is not formatted the proper way”,
#”helper”:”Correct way: /players/token/invite_id
#code 401 (Unauthorized)
#{“reason: “Your token was invalid”}
@api_view(['PUT'])
def get_specific_invites(request):

#/players/registeruser/ [POST] (formparam: {“service_key”:”service_key”,”user_token”:”user_token”, “user_object”:“user_object”})
#code: 200 (OK)
#{“gameservice_ip”:”gameservice_ip”,”gameservice_port”:”gameservice_port”}
#code 400 (Bad Request)
#{“reason”:”Your data is not formatted the proper way”,
#”helper”:”Correct way: /registeruser and then a JSON formatted {“service_key”:”service_key”,”user_token”:”user_token”, “user_object”:“user_object”}”}
#code 500 (Internal Server Error)
#{“reason: “Something bad happened”}
@api_view(['POST'])
def register_user(request):






