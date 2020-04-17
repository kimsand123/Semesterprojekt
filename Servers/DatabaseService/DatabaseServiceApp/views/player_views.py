from json import JSONDecodeError

from django.core.serializers.json import DjangoJSONEncoder
from django.db import IntegrityError
from rest_framework.decorators import api_view
from rest_framework.utils import json

from DatabaseServiceApp.database_helpers.player_database_helper import *
from DatabaseServiceApp.helper_methods import *
from DatabaseServiceApp.serializers import PlayerSerializer
from DatabaseServiceApp.models import Player

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

    except AttributeError:
        return bad_json(request, 'player', __correct_player_json)


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
            'status': status.HTTP_409_CONFLICT,
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

    except AttributeError:
        return bad_json(request, 'player', __correct_player_json)


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

    return_data = PlayerDatabase.get_all_return_serialized()

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

    # Create a database entry
    return_data = PlayerDatabase.create_return_serialized(json_body)

    # if it returns a string, send a missing property json back
    if isinstance(return_data, str):
        return missing_property_in_json(request, return_data, __correct_player_json)

    # Prepare jsonResponse data
    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_201_CREATED,
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

    return_data = PlayerDatabase.get_one_return_serialized(player_id)

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

    # Update a database entry
    return_data = PlayerDatabase.update_return_serialized(json_body, player_id)

    # if it returns a string, send a missing property json back
    if isinstance(return_data, str):
        return missing_property_in_json(request, return_data, __correct_player_json)

    # Prepare jsonResponse data
    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_202_ACCEPTED,
        'message': 'You have changed user with id: \'' + player_id + '\'',
        'player': return_data,
    }
    return JsonResponse(data=json_data, status=status.HTTP_202_ACCEPTED, safe=True, encoder=DjangoJSONEncoder,
                        content_type='application/json')


# -----------------------------
# Single player DELETE
# -----------------------------
def __single_player_delete(request, player_id):
    print_origin(request, 'Single player')

    return_data = PlayerDatabase.delete_return_serialized(player_id)

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_202_ACCEPTED,
        'deleted_player': return_data
    }
    return JsonResponse(data=json_data, status=status.HTTP_202_ACCEPTED, content_type='application/json')

