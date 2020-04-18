from json import JSONDecodeError

from django.core.serializers.json import DjangoJSONEncoder
from django.db import IntegrityError
from rest_framework.decorators import api_view
from rest_framework.utils import json

from DatabaseServiceApp.database_helpers.game_database_helper import GameDatabase
from DatabaseServiceApp.helper_methods import *
from DatabaseServiceApp.models import Game

all_methods = ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'COPY', 'HEAD', 'OPTIONS', 'LINK', 'UNLINK', 'PURGE', 'LOCK',
               'UNLOCK', 'PROPFIND', 'VIEW']

__correct_game_json = {'game':
    {
        "match_name": "Example name",
        "question_duration": "20.0",
        "questions": [1, 2, 3],
        "player_status": {
            "16": {
                "game_player": {
                    "player_id": 16,
                    "game_progress": 20,
                    "score": 10
                },
                "game_round": [
                    {
                        "time_spent": "20.0",
                        "score": 10
                    },
                    {
                        "time_spent": "34.0",
                        "score": 345
                    }
                ]
            },
            "20": {
                "game_player": {
                    "player": 20,
                    "game_progress": 20,
                    "score": 10
                },
                "game_round": [
                    {
                        "time_spent": "20.0",
                        "score": 10
                    },
                    {
                        "time_spent": "34.0",
                        "score": 345
                    }
                ]
            }
        }
    }}


# path: /games/
@api_view(all_methods)
def games(request):
    try:

        if request.method == 'GET':
            return __games_get(request)

        elif request.method == 'POST':
            return __games_post(request)
        else:
            return __bad_method(request, 'GET, POST')

    except JSONDecodeError as e:
        print('Error occurred: ' + e.__str__())
        return bad_json(request, 'game', __correct_game_json)

    except IntegrityError as e:
        print('Error occurred: ' + e.__str__())
        json_data = {
            'url': '[' + request.method + '] ' + request.get_raw_uri(),
            'status': status.HTTP_409_CONFLICT,
            'error': e.__str__(),
        }
        return JsonResponse(data=json_data, safe=False, status=status.HTTP_409_CONFLICT)

    except AttributeError as e:
        print('Error occurred: ' + e.__str__())
        return bad_json(request, 'game', __correct_game_json)


# path: /games/<int:user_id>/
@api_view(all_methods)
def single_game(request, game_id):
    try:
        if request.method == 'GET':
            return __single_game_get(request, game_id)

        elif request.method == 'PUT':
            return __single_game_put(request, game_id)

        elif request.method == 'DELETE':
            return __single_game_delete(request, game_id)

        else:
            return __bad_method(request, 'GET, PUT, DELETE')

    except JSONDecodeError as e:
        print('Error occurred: ' + e.__str__())
        return bad_json(request, 'game', __correct_game_json)

    except IntegrityError as e:
        print('Error occurred: ' + e.__str__())
        json_data = {
            'url': '[' + request.method + '] ' + request.get_raw_uri(),
            'status': status.HTTP_409_CONFLICT,
            'error': e.__str__(),
        }
        return JsonResponse(data=json_data, safe=False, status=status.HTTP_409_CONFLICT)

    except (Game.DoesNotExist, IndexError) as e:
        print('Error occurred: ' + e.__str__())
        json_data = {
            'url': '[' + request.method + '] ' + request.get_raw_uri(),
            'status': status.HTTP_404_NOT_FOUND,
            'error': 'The game with id:\'' + game_id + '\' is not in the database',
        }
        return JsonResponse(data=json_data, safe=False, status=status.HTTP_404_NOT_FOUND)

    except AttributeError as e:
        print('Error occurred: ' + e.__str__())
        return bad_json(request, 'game', __correct_game_json)


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

    return_data = GameDatabase.get_all_return_serialized()

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_200_OK,
        'games': return_data,
    }
    return JsonResponse(data=json_data, status=status.HTTP_200_OK, content_type='application/json')


# -----------------------------
# Games POST
# -----------------------------
def __games_post(request):
    print_origin(request, 'Games')

    json_dict = json.loads(request.body)

    # Create a database entry
    return_data = GameDatabase.create_return_serialized(json_dict)

    # if it returns a string, send a missing property json back
    if isinstance(return_data, str):
        return missing_property_in_json(request, return_data, __correct_game_json)

    # Prepare jsonResponse data
    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_201_CREATED,
        'message': 'You have posted a new game',
        'game': return_data
    }
    return JsonResponse(data=json_data, status=status.HTTP_201_CREATED, safe=True, encoder=DjangoJSONEncoder,
                        content_type='application/json')


# -----------------------------
# Single game GET
# -----------------------------
def __single_game_get(request, game_id):
    print_origin(request, 'Single game')

    return_data = GameDatabase.get_one_return_serialized(game_id)

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_200_OK,
        'game': return_data
    }
    return JsonResponse(data=json_data, status=status.HTTP_200_OK, content_type='application/json')


# -----------------------------
# Single game PUT
# -----------------------------
def __single_game_put(request, game_id):
    print_origin(request, 'Single game')

    json_body = json.loads(request.body)

    # Update a database entry
    return_data = GameDatabase.update_return_serialized(json_body, game_id)

    # if it returns a string, send a missing property json back
    if isinstance(return_data, str):
        return missing_property_in_json(request, return_data, __correct_game_json)

    # Prepare jsonResponse data
    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_202_ACCEPTED,
        'message': 'You have changed the game with id: \'' + game_id + '\'',
        'game': return_data,
    }
    return JsonResponse(data=json_data, status=status.HTTP_202_ACCEPTED, safe=True, encoder=DjangoJSONEncoder,
                        content_type='application/json')


# -----------------------------
# Single game DELETE
# -----------------------------
def __single_game_delete(request, game_id):
    print_origin(request, 'Single game')

    return_data = GameDatabase.delete_return_serialized(game_id)

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_202_ACCEPTED,
        'deleted_game': return_data
    }
    return JsonResponse(data=json_data, status=status.HTTP_202_ACCEPTED, content_type='application/json')
