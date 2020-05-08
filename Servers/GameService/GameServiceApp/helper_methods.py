
from json import *

from django.http.response import HttpResponse, JsonResponse
from rest_framework.utils import json

import requests
from django.http import JsonResponse
from rest_framework import status
from rest_framework.response import Response

from GameServiceApp.constants import *


# Check if user is in db, if it is return id, if not create player and return id
def check_or_add_user(user):
    player = user['player']
    dtu_username = player['username']
    data = connection_service("/players/" + dtu_username + "/", None, None, "GET")

    # If the player doesnt exist
    if 'player' not in data:
        data = connection_service("/players/", user, None, "POST")

    player = data['player']
    return player


# A general request method that is called everytime there is a request.
def connection_service(endpoint_url, body_data, query_params, method):
    build_url = database_service_url() + endpoint_url
    print("METHOD: " + method)
    print("BODY_DATA: " + str(body_data))
    print("URL: " + build_url)
    headers = {"Authorization": "Bearer 5AF4813A4FCE13A2D5436A3E33BAA"}

    params = query_params
    if params is None:
        params = ""

    try:
        r = ""
        if method == "POST":
            if body_data is not None:
                r = requests.post(url=build_url + str(params), json=body_data, headers=headers)
            else:
                r = requests.post(url=build_url + str(params), headers=headers)
        elif method == "GET":
            r = requests.get(url=(build_url + params), headers=headers)
        elif method == "DELETE":
            r = requests.delete(url=build_url + str(params), headers=headers)
        elif method == "PUT":
            if body_data is not None:
                r = requests.put(url=build_url + str(params), json=body_data, headers=headers)
            else:
                r = requests.put(url=build_url + str(params), headers=headers)
        return r
    except Exception as e:
        error_response = Response()
        error_response.status_code = 500
        error_response.content = '{"error": "' + e.__str__() + '", "help": "Contact group 20"}'
        return error_response


# Get the json data object from the request that is sent to an endpoint from user
def get_json_data_object(request, error_message):
    try:
        # request_json = request.body.decode('uft-8')
        decoded = request.body.decode('utf-8')
        request_json = json.loads(decoded)

    except JSONDecodeError as e:
        print("Json error " + e.__str__())
        return Response(data=error_message, status=status.HTTP_400_BAD_REQUEST)
    return request_json


# -------------
# Generate error json
# -------------
def generate_error_json(status_code, reason, suggestion, correct_data):
    if suggestion is None and correct_data is None:
        json_message = {
            'status': status_code,
            'reason': reason
        }
    else:
        json_message = {
            'status': status_code,
            'reason': reason,
            'suggestion': suggestion,
            'correct_data': correct_data
        }
    return json_message
