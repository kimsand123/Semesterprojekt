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

# Open up a logfile
logfile = open('AuthServerLog.txt', 'a')

def nothing(request):
    return HttpResponse("Hello, world. You're at the root index")


# Create your views here.
@api_view(['POST'])
def login(request):

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
                                  "helper": "Contact group 20"}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    # Create a soap client object
    url = 'http://javabog.dk:9901/brugeradmin?wsdl'


    # try and get the userobject from javabog.dk
    try:
        client = Client(url)
        # Get user and create token
        response = client.service.hentBruger(username, password)

        # create the userobject for GameService
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

        # create the user_token. This should be exchanged for a creation of a JWT.
        user_token = str(uuid.uuid1())

        # Register user at gameservice and get gameservice ip and port
        game_service_ip, game_service_port, player = register_user_with_game_service(AUTH_SERVICE_ACCESS_KEY,
                                                                                        user_token,
                                                                                        user_object)
        if game_service_ip == None:
            return JsonResponse(data={"reason": "Could not login with GameService",
                                      "helper": "Contact group 20"}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

        # If gameservice responds with proper data,
        # return the userobject, usertoken and gameservice ip and port to client.
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


    # if the communication with javabog.dk did not go through as expected
    except RuntimeError as e:
        print("500 internal server error when fetching user " + str(time) + " error: " + e.__str__(), file=logfile)
        logfile.close()
        return JsonResponse(data={"reason": "There was an internal server error",
                                  "helper": "Contact group 20"}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    except Fault as e:
        if "Forkert brugernavn eller adgangskode" in str(e):
            print("401 bad credentials " + str(time), file=logfile)
            return JsonResponse(data={"reason": "Your credentials were not correct",
                                      "helper":"Use the proper credentials"}, status=status.HTTP_401_UNAUTHORIZED)
        logfile.close()

    except :
        print(
            "user not returned to client, could not register user with javabog.dk due to connection error at, " + str(
                time), file=logfile)
        logfile.close()
        return JsonResponse(data={"reason": "Could not login with Javabog.dk do to connection error",
                                  "helper": "Contact group 20"}, status=status.HTTP_404_NOT_FOUND)




def register_user_with_game_service(service_key, user_token, user_object):
    compose_env_url = os.getenv('DC_GS')
    #Check if the environment variable is none. If so run in debug environ
    if compose_env_url is None:
        URL = "http://127.0.0.1:9700/register_user/"
    else:
        URL = "http://" + str(compose_env_url) + ":9700/register_user/"

    body_data = {"service_key": service_key, "user_token": user_token, "user_object": user_object}

    try:
        # Connect to gameservice for registration of the user in our db, and setting the user_token.
        r = requests.post(url=URL, json=body_data)

        #json decode the response
        data = json.loads(r.content.decode("UTF-8").__str__())

        # extract the needed data from the response
        game_service_ip = data["game_service_ip"]
        game_service_port = data['game_service_port']
        player = data['player']

        # printing the
        #print("GameService response: game-ip: " + str(game_service_ip) +
        #     ", port: " + str(game_service_port) +
        #      ", player: " + str(player))

        return game_service_ip, game_service_port, player
    except requests.ConnectionError as e:
        print("Could not connect to " + URL + " at GameService using the following. service_key: " + service_key + ", user_token: "+ user_token + ", user_object: " + json.dumps(user_object) + ". Error: " + e.__str__(), file = logfile)
        logfile.close()
    return None, None, None


