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

    print("login post")
    decoded = request.body.decode('utf-8')
    response = json.loads(decoded)
    username = response['username']
    password = response['password']
    url = 'http://javabog.dk:9901/brugeradmin?wsdl'
    client = Client(url, faults=True)
    user_token = None

    try:
        user = client.service.hentBruger(username, password)
        print ("user: " + str(user))
        user_token = uuid.uuid1()
        gameservice_ip = registerUserWithGameService(AUTH_SERVICE_ACCESS_KEY, user_token) == true:
        if gameservice_ip != None:
            user['usertoken'] = user_token
            user['gameservice_ip'] = gameservice_ip
            user['gameservice_port'] = gameservice_port
            return Response(user, status=status.HTTP_200_OK)

    except suds.WebFault as detail:
        if "Forkert brugernavn eller adgangskode" in str(detail):
            print("detail: " + str(detail))
            return Response("NULL", status=status.HTTP_400_BAD_REQUEST)
        #Here can we have more if statements for further error handling.
        #Because Python cant be bothered to implement switch statements

def registerUserWithGameService(service_key, user_token):
    gameservice_ip = "192-168.1.1"

    return gameservice_ip
