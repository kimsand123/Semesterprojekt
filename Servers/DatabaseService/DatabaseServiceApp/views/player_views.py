from json import JSONDecodeError

from django.core.serializers.json import DjangoJSONEncoder
from django.db import IntegrityError
from rest_framework.decorators import api_view
from rest_framework.utils import json

from DatabaseServiceApp.database_helpers.player_database_helper import *
from DatabaseServiceApp.helper_methods import *
from DatabaseServiceApp.serializers import PlayerSerializer
from DatabaseServiceApp.sql_models import Player

all_methods = ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'COPY', 'HEAD', 'OPTIONS', 'LINK', 'UNLINK', 'PURGE', 'LOCK',
               'UNLOCK', 'PROPFIND', 'VIEW']

__correct_player_json = {'player':
                           {
                               'username': 's123456',
                               'email': 's123456@student.dtu.dk',
                               'first_name': 'Søren',
                               'last_name': 'Træsko',
                               'study_programme': 'Software technology',
                               'high_score': 's123456',
                            }}


# path: /players/
@api_view(all_methods)
def players(request):
    try:
        if request.method == 'GET':
            return __players_get(request)

        elif request.method == 'POST':
            return __players_post(request)
        else:
            return __bad_method(request, 'GET, POST')

    except JSONDecodeError:
        return bad_json(request, 'player', __correct_player_json)

    except IntegrityError as e:
        print('Error occurred: ' + e.__str__())
        json_data = {
            'url': '[' + request.method + '] ' + request.get_raw_uri(),
            'status': status.HTTP_409_CONFLICT,
            'error': e.__str__(),
        }
        return JsonResponse(data=json_data, safe=False, status=status.HTTP_409_CONFLICT)


# path: /players/<int:player_id>/
@api_view(all_methods)
def single_player(request, player_id):
    try:
        if request.method == 'GET':
            return __single_player_get(request, player_id)

        elif request.method == 'PUT':
            return __single_player_put(request, player_id)

        elif request.method == 'DELETE':
            return __single_player_delete(request, player_id)

        else:
            return __bad_method(request, 'GET, PUT, DELETE')

    except JSONDecodeError:
        return bad_json(request, 'player', __correct_player_json)

    except IntegrityError as e:
        json_data = {
            'url': '[' + request.method + '] ' + request.get_raw_uri(),
            'status': status.HTTP_404_NOT_FOUND,
            'error': e.__str__(),
        }
        return JsonResponse(data=json_data, safe=False, status=status.HTTP_409_CONFLICT)

    except (Player.DoesNotExist, IndexError):
        json_data = {
            'url': '[' + request.method + '] ' + request.get_raw_uri(),
            'status': status.HTTP_404_NOT_FOUND,
            'error': 'The player with id:\'' + player_id + '\' is not in the database',
        }
        return JsonResponse(data=json_data, safe=False, status=status.HTTP_404_NOT_FOUND)


# Bad player path
@api_view(all_methods)
def players_bad_path(request):
    print_origin(request, 'Players - bad path')
    default_url = 'http://' + request.get_host() + '/players/'

    json_data = {
        'request-url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_400_BAD_REQUEST,
        'error': 'You have requested a wrong path.',
        'available player endpoints': default_url + ', ' + default_url + 'player_id/',
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
    print_origin(request, 'Players - bad method')
    json_data = {
        'request-url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_405_METHOD_NOT_ALLOWED,
        'error': 'This method is not allowed here',
        'helper': 'Only the following methods allowed:[' + allowed_methods + ']',
    }
    return JsonResponse(data=json_data, status=status.HTTP_405_METHOD_NOT_ALLOWED, content_type='application/json')


# -----------------------------
# Players GET
# -----------------------------
def __players_get(request):
    print_origin(request, 'Players')

    players_query = player_database_get_all()
    serializer = PlayerSerializer()
    return_data = json.loads(serializer.serialize(players_query).__str__())

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_200_OK,
        'players': return_data,
    }
    return JsonResponse(data=json_data, status=status.HTTP_200_OK, content_type='application/json')


# -----------------------------
# Players POST
# -----------------------------
def __players_post(request):
    print_origin(request, 'Players')

    json_body = json.loads(request.body)

    # Get database response, and if it returns a string, send a missing property json back
    database_response = player_database_create(json_body)
    if isinstance(database_response, str):
        return missing_property_in_json(request, database_response, __correct_player_json)

    # Serialize the object
    serializer = PlayerSerializer()
    serialize_object = json.loads(serializer.serialize([database_response]).__str__())

    return_data = serialize_object[0]

    # Prepare jsonResponse data
    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_200_OK,
        'message': 'You have posted a new user',
        'player': return_data
    }
    return JsonResponse(data=json_data, status=status.HTTP_201_CREATED, safe=True, encoder=DjangoJSONEncoder,
                        content_type='application/json')


# -----------------------------
# Single player GET
# -----------------------------
def __single_player_get(request, player_id):
    print_origin(request, 'Single player')

    player_query = player_database_get_one(player_id)

    serializer = PlayerSerializer()
    serialize_object = json.loads(serializer.serialize([player_query]).__str__())

    return_data = serialize_object[0]

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_200_OK,
        'player': return_data
    }
    return JsonResponse(data=json_data, status=status.HTTP_200_OK, content_type='application/json')


# -----------------------------
# Single player PUT
# -----------------------------
def __single_player_put(request, player_id):
    print_origin(request, 'Single player')

    json_body = json.loads(request.body)

    # Get database response, and if it returns a string, send a missing property json back
    database_response = player_database_update(json_body, player_id)
    if isinstance(database_response, str):
        return missing_property_in_json(request, database_response, __correct_player_json)

    # Serialize the object
    serializer = PlayerSerializer()
    serialize_object = json.loads(serializer.serialize([database_response]).__str__())

    return_data = serialize_object[0]

    # Prepare jsonResponse data
    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_200_OK,
        'message': 'You have changed user with id: \'' + player_id + '\'',
        'player': return_data,
    }
    return JsonResponse(data=json_data, status=status.HTTP_201_CREATED, safe=True, encoder=DjangoJSONEncoder,
                        content_type='application/json')


# -----------------------------
# Single player DELETE
# -----------------------------
def __single_player_delete(request, player_id):
    print_origin(request, 'Single player')

    players_deleted = player_database_delete(player_id)

    serializer = PlayerSerializer()
    serialize_object = json.loads(serializer.serialize([players_deleted]).__str__())

    return_data = serialize_object[0]

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_202_ACCEPTED,
        'deleted_player': return_data
    }
    return JsonResponse(data=json_data, status=status.HTTP_202_ACCEPTED, content_type='application/json')
