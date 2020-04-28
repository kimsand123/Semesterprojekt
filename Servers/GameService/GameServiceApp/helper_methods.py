import json

import requests
from rest_framework import status
from rest_framework.response import Response

from GameServiceApp.constants import *


# Check if user is in db, if it is return id, if not create player and return id
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


# A general request method that is called everytime there is a request.
def connection_service(endpoint_url, body_data, method):
    build_url = database_service_url() + endpoint_url
    print("METHOD: " + method)
    print("BODY_DATA: " + str(body_data))
    print("URL: " + build_url)
    headers = {"Authorization": "Bearer 5AF4813A4FCE13A2D5436A3E33BAA"}
    try:
        if method == "POST":
            if body_data != None:
                r = requests.post(url=build_url, json=body_data, headers=headers)
            else:
                r = requests.post(url=build_url, headers=headers)
        if method == "GET":
            if body_data != None:
                r = requests.get(url=build_url, json=body_data, headers=headers)
            else:
                r = requests.get(url=build_url, headers=headers)
        if method == "DELETE":
            r = requests.delete(url=build_url, headers=headers)
        if method == "PUT":
            if body_data != None:
                r = requests.put(url=build_url, json=body_data, headers=headers)
            else:
                r = requests.put(url=build_url, headers=headers)
        data = r.json()
    except requests.exceptions as e:
        return e
    return data


# Get the json data object from the request that is sent to an endpoint from user
def get_json_data_object(request, error_message):
    try:
        decoded = request.body.decode('utf-8')
        request_json = json.loads(decoded)
        print("json : " + str(request_json))
    except:
        return Response(data=error_message, status=status.HTTP_400_BAD_REQUEST)
    return request_json
