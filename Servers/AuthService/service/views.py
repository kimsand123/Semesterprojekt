import os

from django.http import HttpResponse, JsonResponse
import json
import uuid
from rest_framework import status
from rest_framework.decorators import api_view
from zeep import Client
import requests
from datetime import datetime

from zeep.exceptions import Fault

AUTH_SERVICE_ACCESS_KEY = "HBdjm4VDLxn8mU2Eh7EzwNdhAEYp7bm9HvgwEJVGeM6NaBFvFFS48qbSHUYKLkuZPRWKxvGJsu4RewuuR6SVEEbH5aUqjD7H8wMeEPBd5d4G8UfB7QxhuTPPF8KKZg53zvUdv63ravcBAzdgPRbxcVu7pb6NPRfVLf3fFznvCX5ey2by6kGe3HrZX6kBTsJxTS6cL4KwkQDaN5YTq5jzQrQ4wLaXBYzx9y4w5sXdfkhLWuCL5wdFMtgbd8cNTemR"


def nothing(request):
    return HttpResponse("Hello, world. You're at the root index")


# Create your views here.
@api_view(['POST'])
def login(request):
    # Open up a logfile
    logfile = open('AuthServerLog.txt', 'a')
    time = datetime.now()
    # print login post to the logfile
    print("login post " + str(time), file=logfile)

    # get data from the json posted to the method
    try:
        decoded = request.body.decode('utf-8')
        response = json.loads(decoded)
        username = response['username']
        password = response['password']
    except (KeyError, json.JSONDecodeError) as err:
        print("400 bad credentials " + str(err) + " " + str(time), file=logfile)
        logfile.close()
        return JsonResponse(data={"reason": "Your data is not formatted the proper way",
                                  "helper": "[POST] at /login and then a JSON formatted like this, " +
                                            "{'username':'yourUserName','password':'yourPassword'}"},
                            status=status.HTTP_400_BAD_REQUEST)
    except RuntimeError:
        print("500 internal server error when decoding json" + str(time), file=logfile)
        logfile.close()
        return JsonResponse(data={"reason": "There was an internal server error",
                                  "helper": "Contact blablablabla"}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    # Create a soap client object
    url = 'http://javabog.dk:9901/brugeradmin?wsdl'
    client = Client(url)

    # try and get the userobject from javabog.dk
    try:
        # Get user and create token
        response = client.service.hentBruger(username, password)

        user_object = {
            'player':
                {
                    "username": response["brugernavn"],
                    "first_name": response["fornavn"],
                    "last_name": response["efternavn"],
                    "email": response["email"],
                    "study_programme": response["studeretning"],
                    "high_score": 0
                }
        }

        user_token = str(uuid.uuid1())

        # Register user at gameservice and get gameservice ip and port
        game_service_ip, game_service_port, player = register_user_with_game_service(AUTH_SERVICE_ACCESS_KEY,
                                                                                        user_token,
                                                                                        user_object)

        # If gameservice responds with proper data,
        # return the userobject, usertoken and gameservice ip and port to client.
        if game_service_ip is not None and player is not None:
            user_object['user_token'] = user_token
            user_object['game_service_ip'] = game_service_ip
            user_object['game_service_port'] = game_service_port
            user_object['player'] = player
            print(
                "user returned to client with token: " + user_token +
                ", ip: " + game_service_ip +
                ", port: " + game_service_port +
                " and player: " + str(player) +
                ", " + str(time), file=logfile)
            return JsonResponse(user_object, status=status.HTTP_200_OK)
        else:
            print(
                "user not returned to client, could not register user with gameservice due to error: " + str(
                    player) + ", " + str(
                    time), file=logfile)
            return JsonResponse(data={"reason": "Could not login with GameService",
                                      "helper": "Contact group 20"}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    # if the communication with javabog.dk did not go through as expected
    except RuntimeError:
        print("500 internal server error when fetching user " + str(time), file=logfile)
        logfile.close()
        return JsonResponse(data={"reason": "There was an internal server error",
                                  "helper": "Contact group 20"}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    except Fault as detail:
        if "Forkert brugernavn eller adgangskode" in str(detail):
            print("401 bad credentials " + str(time), file=logfile)
            return JsonResponse(data={"reason": "Your credentials were not correct"},
                                status=status.HTTP_401_UNAUTHORIZED)
        logfile.close()


def register_user_with_game_service(service_key, user_token, user_object):
    compose_env_url = os.getenv('DC_GS')

    if compose_env_url is None:
        URL = "http://127.0.0.1:9700/players/register_user/"
    else:
        URL = "http://" + str(compose_env_url) + ":9700/players/register_user/"

    body_data = {"service_key": service_key, "user_token": user_token, "user_object": user_object}

    try:
        # Connect to gameservice for registration of the user.
        r = requests.post(url=URL, json=body_data)

        if r.content.decode("UTF-8") == "error":
            print("Got an \"error\" from GameService - maybe the database is down?")
            return None, None, None

        data = json.loads(r.content.decode("UTF-8").__str__())

        game_service_ip = data["game_service_ip"]
        game_service_port = data['game_service_port']
        player = data['player']

        print("GameService response: game-ip: " + str(game_service_ip) +
              ", port: " + str(game_service_port) +
              ", player: " + str(player))

        return game_service_ip, game_service_port, player

    except requests.ConnectionError as e:
        print("Connection error in registerUserWithGameService")
        print(e.__str__())
        return None, None, None
