from django.shortcuts import render
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
import json
import uuid
from suds.client import Client
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
import suds
import requests
from datetime import datetime

AUTH_SERVICE_ACCESS_KEY = "HBdjm4VDLxn8mU2Eh7EzwNdhAEYp7bm9HvgwEJVGeM6NaBFvFFS48qbSHUYKLkuZPRWKxvGJsu4RewuuR6SVEEbH5aUqjD7H8wMeEPBd5d4G8UfB7QxhuTPPF8KKZg53zvUdv63ravcBAzdgPRbxcVu7pb6NPRfVLf3fFznvCX5ey2by6kGe3HrZX6kBTsJxTS6cL4KwkQDaN5YTq5jzQrQ4wLaXBYzx9y4w5sXdfkhLWuCL5wdFMtgbd8cNTemR"

def nothing(request):
    return HttpResponse("Hello, world. You're at the root index")

# Create your views here.
#@api_view(['GET'])
def index(request):
    return HttpResponse("Hello, world. You're at the service index")

@api_view(['POST'])
@csrf_exempt
def login(request):
    #try to do a log
    logfile = open('AuthServerLog.txt', 'a')

    time=datetime.now()
    print("login post " + str(time),file = logfile )
    #get data from the json posted to the method
    try:
        decoded = request.body.decode('utf-8')
        response = json.loads(decoded)
        username = response['username']
        password = response['password']
    except (KeyError, json.JSONDecodeError) as err:
        print("400 bad credentials " + str(err) + " " + str(time),file = logfile)
        return Response(data={"reason": "Your data is not formatted the proper way",
                              "helper": "[POST] at /login and then a JSON formatted like this, {'username':'yourUserName','password':'yourPassword'}"}, status=status.HTTP_400_BAD_REQUEST)
        logfile.close()
    except RuntimeError:
        print("500 interal server error when decoding json"+ str(time),file = logfile)
        return Response (data={"reason": "There was an internal server error",
                               "helper":"Contact blablablabla"}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        logfile.close()

    #Create a soap client object
    url = 'http://javabog.dk:9901/brugeradmin?wsdl'
    client = Client(url, faults=True)
    user_token = None

    #try and get the userobject from javabog.dk
    try:
        print("OK")
        #Get user and create token
        user = client.service.hentBruger(username, password)
        user_token = uuid.uuid1()

        #Register user at gameservice and get gameservice ip and port

        gameservice_ip, gameservice_port = registerUserWithGameService(AUTH_SERVICE_ACCESS_KEY, user_token, user)

        #If gameservice responds with proper data, return the userobject, usertoken and gameservice ip and port to client.
        if gameservice_ip != None:
            user['usertoken'] = user_token
            user['gameservice_ip'] = gameservice_ip
            user['gameservice_port'] = gameservice_port
            print("user: " + str(user))
            print("user returned to client with token, ip and port " + str(time), file=logfile)
            return Response(user, status=status.HTTP_200_OK)
        else:
            print("user not returned to client, could not register user with gameservice" + str(time), file=logfile)

    #if the communication with javabog.dk did not go through as expected
    except suds.WebFault as detail:
        if "Forkert brugernavn eller adgangskode" in str(detail):
            print("401 bad credentials "+ str(time),file = logfile)
            return Response(data={"reason":"Your credentials were not correct"}, status=status.HTTP_401_UNAUTHORIZED)
        logfile.close()
    except RuntimeError:
        print("500 interal server error when fetching user "+ str(time),file = logfile)
        return Response(data={"reason": "There was an internal server error",
                              "helper": "Contact blablablabla"}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        logfile.close()

def registerUserWithGameService(service_key, user_token, user):

    URL = "http://127.0.0.1:9700/registeruser"
    PARAMS = {"servicekey":service_key, "usertoken":user_token, "userobject":user}
    try:
        #Connect to gameservice for registration of the user.
        #r = requests.post(url = URL, params = PARAMS)
        #data = r.json()
        #gameservice_ip = data['gameservice_ip']
        #gameservice_port = data['gameservice_port']
        gameservice_ip = "192.168.1.1"
        gameservice_port = "9700"
    except requests.ConnectionError as e:
        return None, None
    return gameservice_ip, gameservice_port
