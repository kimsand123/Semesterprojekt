from django.core.serializers.json import DjangoJSONEncoder
from django.http import JsonResponse
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.utils import json

from DatabaseServiceApp.sql_models import Player

all_methods = ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'COPY', 'HEAD', 'OPTIONS', 'LINK', 'UNLINK', 'PURGE', 'LOCK',
               'UNLOCK', 'PROPFIND', 'VIEW']


# path: /players/
@api_view(all_methods)
def players(request):
    if request.method == 'GET':
        return __players_get(request)

    elif request.method == 'POST':
        return __players_post(request)
    else:
        return __bad_method(request, 'GET, POST')


# path: /players/<int:user_id>/
@api_view(all_methods)
def single_player(request, id):
    if request.method == 'GET':
        return __single_player_get(request, id)
    elif request.method == 'PUT':
        return __single_player_put(request, id)
    elif request.method == 'DELETE':
        return __single_player_delete(request, id)
    else:
        return __bad_method(request, 'GET, PUT, DELETE')


# Bad player path
@api_view(all_methods)
def players_bad_path(request):
    print('** Bad request under PLayer: ' + request.get_raw_uri())
    default_url = 'http://' + request.get_host() + '/players/'

    json_data = {
        'request-url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_400_BAD_REQUEST,
        'error': 'You have requested a wrong path.',
        'available player endpoints': default_url + ', ' + default_url + 'id/',
        'helper':'Maybe you have forgotten a slash ?'
    }
    return JsonResponse(data=json_data, status=status.HTTP_400_BAD_REQUEST)


"""
-----------------------------
METHOD IMPLEMENTATIONS
-----------------------------
"""


def __bad_method(request, allowed_methods):
    print('** Players -Bad method-: ' + request.get_raw_uri())
    json_data = {
        'request-url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_405_METHOD_NOT_ALLOWED,
        'error': 'This method is not allowed here',
        'helper': 'Only the following methods allowed:[' + allowed_methods + ']',
    }
    return JsonResponse(data=json_data, status=status.HTTP_405_METHOD_NOT_ALLOWED)


def __players_get(request):
    print('** Players [GET]: ' + request.get_raw_uri())

    query_set = Player.objects.all().values()
    object_data = json.dumps(list(query_set), ensure_ascii=False, cls=DjangoJSONEncoder)

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_200_OK,
        'players': json.loads(object_data)
    }
    return JsonResponse(data=json_data, status=status.HTTP_200_OK)


def __players_post(request):
    print('** Players [POST]: ' + request.get_raw_uri())

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_200_OK,
        'message': 'This is a dummy response'
    }
    return JsonResponse(data=json_data, status=status.HTTP_200_OK)


def __single_player_get(request, id):
    print('** Single player [GET]: ' + request.get_raw_uri())

    query_set = Player.objects.all().filter(id=id).values()
    single_object = list(query_set)[0]
    object_data = json.dumps(single_object, ensure_ascii=False, cls=DjangoJSONEncoder)

    # TODO: exception handling

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_200_OK,
        'player': json.loads(object_data)
    }
    return JsonResponse(data=json_data, status=status.HTTP_200_OK)


def __single_player_put(request, id):
    print('** Single player [PUT]: ' + request.get_raw_uri())

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_200_OK,
        'message': 'This is a dummy response'
    }
    return JsonResponse(data=json_data, status=status.HTTP_200_OK)


def __single_player_delete(request, id):
    print('** Single player [DELETE]: ' + request.get_raw_uri())

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_200_OK,
        'message': 'This is a dummy response'
    }
    return JsonResponse(data=json_data, status=status.HTTP_200_OK)
