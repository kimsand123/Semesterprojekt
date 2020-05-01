from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

from GameServiceApp.active_player_list import token_status
from GameServiceApp.correct_data import CORRECT_INVITE_OBJ
from GameServiceApp.helper_methods import get_json_data_object, connection_service, generate_error_json


# -------------
# [GET / POST] /invites/
# -------------
@api_view(['GET', 'POST'])
def invites(request):
    # Early exit on missing authorization / invalid token
    if 'Authorization' not in request.headers:
        error_message = generate_error_json(status.HTTP_401_UNAUTHORIZED, "Authorization was not included in headers", None, None)
        return Response(data=error_message, status=status.HTTP_401_UNAUTHORIZED)
    else:
        if not token_status(request.headers['Authorization']):
            error_message = generate_error_json(status.HTTP_401_UNAUTHORIZED, "Token was invalid", None, None)
            return Response(data=error_message, status=status.HTTP_401_UNAUTHORIZED)

    # Goes to the different method calls
    if request.method == 'GET':
        return invites_get(request)
    elif request.method == 'POST':
        return invites_post(request)
    else:
        print("/invites/ does not have a \'" + request.method + "\' handling")


# -------------
# [GET / PUT / DELETE] /invites/invite_id
# -------------
@api_view(['GET', 'PUT', 'DELETE'])
def single_invite(request, invite_id):
    # Early exit on missing authorization / invalid token
    if 'Authorization' not in request.headers:
        error_message = generate_error_json(status.HTTP_401_UNAUTHORIZED, "Authorization was not included in headers", None, None)
        return Response(data=error_message, status=status.HTTP_401_UNAUTHORIZED)
    else:
        if not token_status(request.headers['Authorization']):
            error_message = generate_error_json(status.HTTP_401_UNAUTHORIZED, "Token was invalid", None, None)
            return Response(data=error_message, status=status.HTTP_401_UNAUTHORIZED)

    if request.method == 'GET':
        return single_invite_get(request, invite_id)
    elif request.method == 'PUT':
        return single_invite_put(request, invite_id)
    elif request.method == 'DELETE':
        return single_invite_delete(request, invite_id)
    else:
        print("/invites/invite_id does not have a \'" + request.method + "\' handling")


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# INDIVIDUAL METHODS BENEATH
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


# -------------
# [GET] /invites/
# -------------
def invites_get(request):
    if 'player_id' in request.GET:
        param_player_id = request.GET['player_id']
        connection_params = "?player_id=" + param_player_id
        response = connection_service("/invites/", None, connection_params, "GET")
        return Response(data=response, status=status.HTTP_200_OK)
    else:
        response = connection_service("/invites/", None, None, "GET")
        return Response(data=response, status=status.HTTP_200_OK)


# -------------
# [POST] /invites/
# -------------
def invites_post(request):
    decode_error_message = generate_error_json(status.HTTP_400_BAD_REQUEST, 'Json decode error',
                                               'Your body should probably look like the value in correct_data',
                                               CORRECT_INVITE_OBJ)

    json_request = get_json_data_object(request, decode_error_message)
    if type(json_request) is Response:
        return json_request

    invite = json_request['invite']
    json_body = {
        "invite": {
            "sender_player_id": invite['sender_player_id'],
            "receiver_player_id": invite['receiver_player_id'],
            "match_name": invite['match_name'],
            "question_duration": invite['question_duration'],
            "accepted": invite['accepted']
        }
    }
    response = connection_service("/invites/", json_body, None, "POST")
    return Response(data=response, status=status.HTTP_201_CREATED)


# -------------
# [GET] /invites/invite_id/
# -------------
def single_invite_get(request, invite_id):
    response = connection_service(f"/invites/{invite_id}/", None, None, "GET")
    return Response(data=response, status=status.HTTP_200_OK)


# -------------
# [PUT] /invites/invite_id/
# -------------
def single_invite_put(request, invite_id):
    decode_error_message = generate_error_json(status.HTTP_400_BAD_REQUEST, 'Json decode error',
                                               'Your body should probably look like the value in correct_data',
                                               CORRECT_INVITE_OBJ)

    json_request = get_json_data_object(request, decode_error_message)
    if type(json_request) is Response:
        return json_request

    invite = json_request['invite']
    json_body = {
        "invite": {
            "sender_player_id": invite['sender_player_id'],
            "receiver_player_id": invite['receiver_player_id'],
            "match_name": invite['match_name'],
            "question_duration": invite['question_duration'],
            "accepted": invite['accepted']
        }
    }
    response = connection_service(f"/invites/{invite_id}/", json_body, None, "PUT")
    return Response(data=response, status=status.HTTP_200_OK)


# -------------
# [DELETE] /invites/invite_id/
# -------------
def single_invite_delete(request, invite_id):
    response = connection_service(f"/invites/{invite_id}/", None, None, "DELETE")
    return Response(data=response, status=status.HTTP_200_OK)
