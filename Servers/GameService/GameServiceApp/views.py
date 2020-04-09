from django.shortcuts import render
import json

from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

# Create your views here.


#/players/ [GET] (queryparam: token=token)
#code: 200 (OK)
#{[userObject]}
#code 400 (Bad Request)
#{“reason”:”Your data is not formatted the proper way”,
#”helper”:”“Correct way: /players”}
#code 401 (Unauthorized)
#{“reason: “Your token was invalid”}


#/players/token [GET] (queryparam: token=token)
#code: 200 (OK)
#{[userObject]}
#code 400 (Bad Request)
#{“reason”:”Your data is not formatted the proper way”,
#”helper”:”Correct way: /players/token”}
#code 401 (Unauthorized)
#{“reason: “Your token was invalid”}

#/players/token/invite/ [POST] (formparam: {“invite_player_id”:”invite_player_id”,”invitation_parameters”:”invitation_parameters”})
#code: 200 (OK)
#{“”}
#code 400 (Bad Request)
#{“reason”:”Your data is not formatted the proper way”,
#”helper”:”Correct way: /players/token/invite and then a JSON formatted {“invite_player_id”:”invite_player_id”}}”
#code 401 (Unauthorized)
#{“reason: “Your token was invalid”}

#/players/token/invites/[GET]
#code: 200 (OK)
#{[invite_objects]}
#code 401 (Unauthorized)
#{“reason: “Your token was invalid”}

#/players/token/invites/invite_id [POST]
#code: 200 (OK)
#{“game_id”:”game_id”}
#code 400 (Bad Request)
#{“reason”:”Your data is not formatted the proper way”,
#”helper”:”Correct way: /players/token/invite_id
#code 401 (Unauthorized)
#{“reason: “Your token was invalid”}

#/players/registeruser/ [POST] (formparam: {“service_key”:”service_key”,”user_token”:”user_token”, “user_object”:“user_object”})
#code: 200 (OK)
#{“gameservice_ip”:”gameservice_ip”,”gameservice_port”:”gameservice_port”}
#code 400 (Bad Request)
#{“reason”:”Your data is not formatted the proper way”,
#”helper”:”Correct way: /registeruser and then a JSON formatted {“service_key”:”service_key”,”user_token”:”user_token”, “user_object”:“user_object”}”}
#code 500 (Internal Server Error)
#{“reason: “Something bad happened”}

@api_view(['POST'])
def registeruser(request):






