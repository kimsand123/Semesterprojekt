from json import JSONDecodeError

from django.core.serializers.json import DjangoJSONEncoder
from django.db import IntegrityError
from rest_framework.decorators import api_view
from rest_framework.utils import json

from DatabaseServiceApp.database_helpers.game_database_helper import GameDatabase
from DatabaseServiceApp.helper_methods import *
from DatabaseServiceApp.models import Game
from DatabaseServiceApp.views.default_views import bad_json, missing_property_in_json, wrong_property_type, \
    bad_or_missing_access_key

all_methods = ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'COPY', 'HEAD', 'OPTIONS', 'LINK', 'UNLINK', 'PURGE', 'LOCK',
               'UNLOCK', 'PROPFIND', 'VIEW']

__correct_game_json = {

    'game':
        {
            "match_name": "Example name",
            "question_duration": 20.0,
            "questions":
                [
                    1,
                    2,
                    3
                ],
            "player_status":
                [
                    {
                        "game_player":
                            {
                                "player_id": 1,
                                "game_progress": 20,
                                "score": 10
                            },
                        "game_round":
                            [
                                {
                                    "time_spent": 20.0,
                                    "score": 10
                                },
                                {
                                    "time_spent": 34.0,
                                    "score": 345
                                }
                            ]
                    },
                    {
                        "game_player":
                            {
                                "player_id": 2,
                                "game_progress": 20,
                                "score": 10
                            },
                        "game_round":
                            [
                                {
                                    "time_spent": 20.0,
                                    "score": 10
                                },
                                {
                                    "time_spent": 34.0,
                                    "score": 345
                                }
                            ]
                    }
                ]

        }
}


# path: /games/
@api_view(all_methods)
def games(request):
    try:
        if not is_access_key_valid(request):
            return bad_or_missing_access_key(request)

        if request.method == 'GET':
            return __games_get(request)

        elif request.method == 'POST':
            return __games_post(request)
        else:
            return __bad_method(request, 'GET, POST')

    except IntegrityError as e:
        print('IntegrityError occurred: ' + e.__str__())

        json_data = {
            'requested-url': '[' + request.method + '] ' + request.get_full_path(),
            'error': e.__str__(),
        }
        return JsonResponse(data=json_data, status=status.HTTP_409_CONFLICT, safe=False, encoder=DjangoJSONEncoder)

    except JSONDecodeError as e:
        print('JSONDecodeError occurred: ' + e.__str__())
        return bad_json(request, __correct_game_json)

    except (AttributeError, KeyError) as e:
        print('AttributeError or KeyError occurred: ' + e.__str__())
        return bad_json(request, __correct_game_json)

    except (ValueError, TypeError) as e:
        print('ValueError or TypeError occurred: ' + e.__str__())
        return wrong_property_type(request, __correct_game_json)


# path: /games/<int:game_id>/
@api_view(all_methods)
def single_game(request, game_id):
    try:
        if not is_access_key_valid(request):
            return bad_or_missing_access_key(request)

        if request.method == 'GET':
            return __single_game_get(request, game_id)

        elif request.method == 'PUT':
            return __single_game_put(request, game_id)

        elif request.method == 'DELETE':
            return __single_game_delete(request, game_id)

        else:
            return __bad_method(request, 'GET, PUT, DELETE')

    except IntegrityError as e:
        print('IntegrityError occurred: ' + e.__str__())
        json_data = {
            'requested-url': '[' + request.method + '] ' + request.get_full_path(),
            'error': e.__str__(),
        }
        return JsonResponse(data=json_data, status=status.HTTP_409_CONFLICT, safe=False, encoder=DjangoJSONEncoder)

    except (Game.DoesNotExist, IndexError) as e:
        print('Game.DoesNotExist or IndexError occurred: ' + e.__str__())
        json_data = {
            'requested-url': '[' + request.method + '] ' + request.get_full_path(),
            'error': 'The game with id:\'' + game_id + '\' is not in the database',
        }
        return JsonResponse(data=json_data, status=status.HTTP_404_NOT_FOUND, safe=False, encoder=DjangoJSONEncoder)

    except JSONDecodeError as e:
        print('JSONDecodeError occurred: ' + e.__str__())
        return bad_json(request, __correct_game_json)

    except (AttributeError, KeyError) as e:
        print('AttributeError or KeyError occurred: ' + e.__str__())
        return bad_json(request, __correct_game_json)

    except (ValueError, TypeError) as e:
        print('ValueError or TypeError occurred: ' + e.__str__())
        return wrong_property_type(request, __correct_game_json)


# Bad games path
@api_view(all_methods)
def games_bad_path(request):
    print_origin(request, 'Games - Bad request')
    default_url = '/games/'

    json_data = {
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'error': 'You have requested a wrong path.',
        'helper': 'Maybe you have forgotten a ?slash',
        'games endpoint': default_url,
        'single game endpoint': default_url + '1/'
    }
    return JsonResponse(data=json_data, status=status.HTTP_400_BAD_REQUEST, safe=False, encoder=DjangoJSONEncoder)


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
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'error': 'This method is not allowed here',
        'helper': 'Only the following methods allowed:[' + allowed_methods + ']',
    }
    return JsonResponse(data=json_data, status=status.HTTP_405_METHOD_NOT_ALLOWED, safe=False,
                        encoder=DjangoJSONEncoder)


# -----------------------------
# Games GET
# -----------------------------
def __games_get(request):
    print_origin(request, 'Games')

    return_data = {}

    try:
        json_dict = json.loads(request.body)

        return_data = GameDatabase.get_all_return_serialized(json_dict)

    except JSONDecodeError:
        return_data = GameDatabase.get_all_return_serialized({})

    finally:
        json_data = {
            'requested-url': '[' + request.method + '] ' + request.get_full_path(),
            'games': return_data,
        }
        return JsonResponse(data=json_data, status=status.HTTP_200_OK, safe=False, encoder=DjangoJSONEncoder)


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
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'message': 'You have posted a new game',
        'game': return_data
    }
    return JsonResponse(data=json_data, status=status.HTTP_201_CREATED, safe=False, encoder=DjangoJSONEncoder)


# -----------------------------
# Single game GET
# -----------------------------
def __single_game_get(request, game_id):
    print_origin(request, 'Single game')

    return_data = GameDatabase.get_one_return_serialized(game_id)

    json_data = {
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'game': return_data
    }
    return JsonResponse(data=json_data, status=status.HTTP_200_OK, safe=False, encoder=DjangoJSONEncoder)


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
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'message': 'You have changed the game with id: \'' + game_id + '\'',
        'game': return_data,
    }
    return JsonResponse(data=json_data, status=status.HTTP_202_ACCEPTED, safe=False, encoder=DjangoJSONEncoder)


# -----------------------------
# Single game DELETE
# -----------------------------
def __single_game_delete(request, game_id):
    print_origin(request, 'Single game')

    return_data = GameDatabase.delete_return_serialized(game_id)

    json_data = {
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'deleted_game': return_data
    }
    return JsonResponse(data=json_data, status=status.HTTP_202_ACCEPTED, safe=False, encoder=DjangoJSONEncoder)
