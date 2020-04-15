from django.core.serializers.json import DjangoJSONEncoder
from django.http import JsonResponse
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.utils import json

from DatabaseServiceApp.sql_models import Game

all_methods = ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'COPY', 'HEAD', 'OPTIONS', 'LINK', 'UNLINK', 'PURGE', 'LOCK',
               'UNLOCK', 'PROPFIND', 'VIEW']


# path: /games/
@api_view(all_methods)
def games(request):
    if request.method == 'GET':
        return __games_get(request)

    elif request.method == 'POST':
        return __games_post(request)
    else:
        return __bad_method(request, 'GET, POST')


# path: /games/<int:user_id>/
@api_view(all_methods)
def single_game(request, id):
    if request.method == 'GET':
        return __single_game_get(request, id)
    elif request.method == 'PUT':
        return __single_game_put(request, id)
    elif request.method == 'DELETE':
        return __single_game_delete(request, id)
    else:
        return __bad_method(request, 'GET, PUT, DELETE')


# Bad games path
@api_view(all_methods)
def games_bad_path(request):
    print('** Bad request under Game: ' + request.get_raw_uri())
    default_url = 'http://' + request.get_host() + '/games/'

    json_data = {
        'request-url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_400_BAD_REQUEST,
        'error': 'You have requested a wrong path.',
        'available game endpoints': default_url + ', ' + default_url + 'id/',
        'helper':'Maybe you have forgotten a slash ?'
    }
    return JsonResponse(data=json_data, status=status.HTTP_400_BAD_REQUEST)


"""
-----------------------------
METHOD IMPLEMENTATIONS
-----------------------------
"""


def __bad_method(request, allowed_methods):
    print('** Games -Bad method-: ' + request.get_raw_uri())
    json_data = {
        'request-url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_405_METHOD_NOT_ALLOWED,
        'error': 'This method is not allowed here',
        'helper': 'Only the following methods allowed:[' + allowed_methods + ']',
    }
    return JsonResponse(data=json_data, status=status.HTTP_405_METHOD_NOT_ALLOWED)


def __games_get(request):
    print('** Games [GET]: ' + request.get_raw_uri())

    query_set = Game.objects.all().values()
    object_data = json.dumps(list(query_set), ensure_ascii=False, cls=DjangoJSONEncoder)

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_200_OK,
        'games': json.loads(object_data)
    }
    return JsonResponse(data=json_data, status=status.HTTP_200_OK)


def __games_post(request):
    print('** Games [POST]: ' + request.get_raw_uri())

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_200_OK,
        'message': 'This is a dummy response'
    }
    return JsonResponse(data=json_data, status=status.HTTP_200_OK)


def __single_game_get(request, id):
    print('** Single Game [GET]: ' + request.get_raw_uri())

    query_set = Game.objects.all().filter(id=id).values()
    single_object = list(query_set)[0]
    object_data = json.dumps(single_object, ensure_ascii=False, cls=DjangoJSONEncoder)

    # TODO: exception handling

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_200_OK,
        'game': json.loads(object_data)
    }
    return JsonResponse(data=json_data, status=status.HTTP_200_OK)


def __single_game_put(request, id):
    print('** Single Game [PUT]: ' + request.get_raw_uri())

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_200_OK,
        'message': 'This is a dummy response'
    }
    return JsonResponse(data=json_data, status=status.HTTP_200_OK)


def __single_game_delete(request, id):
    print('** Single Game [DELETE]: ' + request.get_raw_uri())

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_200_OK,
        'message': 'This is a dummy response'
    }
    return JsonResponse(data=json_data, status=status.HTTP_200_OK)
