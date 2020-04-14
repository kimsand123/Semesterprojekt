from django.core.serializers.json import DjangoJSONEncoder
from django.http import JsonResponse
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.utils import json

from DatabaseServiceApp.models import Invite

all_methods = ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'COPY', 'HEAD', 'OPTIONS', 'LINK', 'UNLINK', 'PURGE', 'LOCK',
               'UNLOCK', 'PROPFIND', 'VIEW']


# path: /invites/
@api_view(all_methods)
def invites(request):
    if request.method == 'GET':
        return __invites_get(request)

    elif request.method == 'POST':
        return __invites_post(request)
    else:
        return __bad_method(request, 'GET, POST')


# path: /invites/<int:user_id>/
@api_view(all_methods)
def single_invite(request, id):
    if request.method == 'GET':
        return __single_invite_get(request, id)
    elif request.method == 'PUT':
        return __single_invite_put(request, id)
    elif request.method == 'DELETE':
        return __single_invite_delete(request, id)
    else:
        return __bad_method(request, 'GET, PUT, DELETE')


"""
-----------------------------
METHOD IMPLEMENTATIONS
-----------------------------
"""


def __bad_method(request, allowed_methods):
    print('** Invites -Bad method-: ' + request.get_raw_uri())
    json_data = {
        'request-url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_405_METHOD_NOT_ALLOWED,
        'error': 'This method is not allowed here',
        'helper': 'Only the following methods allowed:[' + allowed_methods + ']',
    }
    return JsonResponse(data=json_data, status=status.HTTP_405_METHOD_NOT_ALLOWED)


def __invites_get(request):
    print('** Invites [GET]: ' + request.get_raw_uri())

    query_set = Invite.objects.all().values()
    object_data = json.dumps(list(query_set), ensure_ascii=False, cls=DjangoJSONEncoder)

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_200_OK,
        'invites': json.loads(object_data),
        'message': 'This is a dummy response'
    }
    return JsonResponse(data=json_data, status=status.HTTP_200_OK)


def __invites_post(request):
    print('** Invites [POST]: ' + request.get_raw_uri())

    json_dict = dict(json.loads(request.body))

    # TODO: Not working yet
    invite = Invite(sender_player_id=json_dict['sender_player_id'], receiver_player_id=json_dict['receiver_player_id'],
                    game_id=json_dict['game_id'], accepted=json_dict['accepted'])
    invite.save()

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_200_OK,
        'message': 'This is a dummy response',
    }
    return JsonResponse(data=json_data, status=status.HTTP_200_OK)


def __single_invite_get(request, id):
    print('** Single invite [GET]: ' + request.get_raw_uri())

    query_set = Invite.objects.all().filter(id=id).values()
    single_object = list(query_set)[0]
    object_data = json.dumps(single_object, ensure_ascii=False, cls=DjangoJSONEncoder)

    # TODO: exception handling

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_200_OK,
        'invite': json.loads(object_data),
        'message': 'This is a dummy response',
    }
    return JsonResponse(data=json_data, status=status.HTTP_200_OK)


def __single_invite_put(request, id):
    print('** Single invite [PUT]: ' + request.get_raw_uri())

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_200_OK,
        'message': 'This is a dummy response',
    }
    return JsonResponse(data=json_data, status=status.HTTP_200_OK)


def __single_invite_delete(request, id):
    print('** Single invite [DELETE]: ' + request.get_raw_uri())

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_200_OK,
        'message': 'This is a dummy response',
    }
    return JsonResponse(data=json_data, status=status.HTTP_200_OK)
