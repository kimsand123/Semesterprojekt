from django.core.serializers.json import DjangoJSONEncoder
from rest_framework.decorators import api_view
from rest_framework.utils import json

from DatabaseServiceApp.helper_methods import *
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
    print_origin(request, 'Games - Bad request')
    default_url = 'http://' + request.get_host() + '/games/'

    json_data = {
        'request-url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_400_BAD_REQUEST,
        'error': 'You have requested a wrong path.',
        'available game endpoints': default_url + ', ' + default_url + 'id/',
        'helper': 'Maybe you have forgotten a slash ?'
    }
    return JsonResponse(data=json_data, status=status.HTTP_400_BAD_REQUEST, content_type='application/json')


"""
-----------------------------
METHOD IMPLEMENTATIONS
-----------------------------
"""


# -----------------------------
# Bad method
# -----------------------------
def __bad_method(request, allowed_methods):
    print_origin(request, 'Games - Bad method')
    json_data = {
        'request-url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_405_METHOD_NOT_ALLOWED,
        'error': 'This method is not allowed here',
        'helper': 'Only the following methods allowed:[' + allowed_methods + ']',
    }
    return JsonResponse(data=json_data, status=status.HTTP_405_METHOD_NOT_ALLOWED, content_type='application/json')


# -----------------------------
# Games GET
# -----------------------------
def __games_get(request):
    print_origin(request, 'Games')

    query_set = Game.objects.all().values()
    object_data = json.dumps(list(query_set), ensure_ascii=False, cls=DjangoJSONEncoder)

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_501_NOT_IMPLEMENTED,
        'message': 'This is not implemented yet',
        'games': json.loads(object_data)
    }
    return JsonResponse(data=json_data, status=status.HTTP_501_NOT_IMPLEMENTED, content_type='application/json')


# -----------------------------
# Games POST
# -----------------------------
def __games_post(request):
    print_origin(request, 'Games')

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_501_NOT_IMPLEMENTED,
        'message': 'This is not implemented yet',
    }
    return JsonResponse(data=json_data, status=status.HTTP_501_NOT_IMPLEMENTED, content_type='application/json')


# -----------------------------
# Single game GET
# -----------------------------
def __single_game_get(request, id):
    print_origin(request, 'Single game')

    query_set = Game.objects.all().filter(id=id).values()
    single_object = list(query_set)[0]
    object_data = json.dumps(single_object, ensure_ascii=False, cls=DjangoJSONEncoder)

    # TODO: exception handling

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_501_NOT_IMPLEMENTED,
        'message': 'This is not implemented yet',
        'game': json.loads(object_data)
    }
    return JsonResponse(data=json_data, status=status.HTTP_501_NOT_IMPLEMENTED, content_type='application/json')


# -----------------------------
# Single game PUT
# -----------------------------
def __single_game_put(request, id):
    print_origin(request, 'Single game')

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_501_NOT_IMPLEMENTED,
        'message': 'This is not implemented yet',
    }
    return JsonResponse(data=json_data, status=status.HTTP_501_NOT_IMPLEMENTED, content_type='application/json')


# -----------------------------
# Single game DELETE
# -----------------------------
def __single_game_delete(request, id):
    print_origin(request, 'Single game')

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_501_NOT_IMPLEMENTED,
        'message': 'This is not implemented yet',
    }
    return JsonResponse(data=json_data, status=status.HTTP_501_NOT_IMPLEMENTED, content_type='application/json')
