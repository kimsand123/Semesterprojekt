from django.core.serializers.json import DjangoJSONEncoder
from django.db import IntegrityError, OperationalError
from django.http import JsonResponse
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.utils import json

from DatabaseServiceApp.views.correct_jsons import CORRECT_PLAYER_JSON
from DatabaseServiceApp.database_helpers.player_database_helper import *
from DatabaseServiceApp.views.helper_methods import *
from DatabaseServiceApp.models import Player
from DatabaseServiceApp.views.default_views import bad_json, missing_property_in_json, wrong_property_type, \
    bad_or_missing_access_key, all_methods, bad_method


# -------------
# [GET / POST] /players/
# -------------
@api_view(all_methods)
def players(request):
    try:
        if not is_access_key_valid(request):
            return bad_or_missing_access_key(request)

        if request.method == 'GET':
            return __players_get(request)

        elif request.method == 'POST':
            return __players_post(request)
        else:
            return bad_method(request, 'GET, POST')

    except IntegrityError as e:
        print('IntegrityError occurred: ' + e.__str__())
        json_data = {
            'requested-url': '[' + request.method + '] ' + request.get_full_path(),
            'error': e.__str__(),
        }
        return JsonResponse(data=json_data, status=status.HTTP_409_CONFLICT, safe=False, encoder=DjangoJSONEncoder)

    except JSONDecodeError as e:
        print('JSONDecodeError occurred: ' + e.__str__())
        return bad_json(request, CORRECT_PLAYER_JSON)

    except (AttributeError, KeyError) as e:
        print('AttributeError or KeyError occurred: ' + e.__str__())
        return bad_json(request, CORRECT_PLAYER_JSON)

    except (ValueError, TypeError) as e:
        print('ValueError or TypeError occurred: ' + e.__str__())
        return wrong_property_type(request, CORRECT_PLAYER_JSON)

    except OperationalError as e:
        print('OperationalError: (SQLite file error)' + e.__str__())
        print(
            '*** It seems like the database is not migrated, please follow the "database_migration_help.txt" file ***')
        json_data = {
            'requested-url': '[' + request.method + '] ' + request.get_full_path(),
            'error': 'The database is corrupt, please contact group 20',
        }
        return JsonResponse(data=json_data, status=status.HTTP_500_INTERNAL_SERVER_ERROR, safe=False, encoder=DjangoJSONEncoder)


# -------------
# [GET / PUT / DELETE] /players/player_id
# -------------
@api_view(all_methods)
def single_player(request, player_id):
    try:
        if not is_access_key_valid(request):
            return bad_or_missing_access_key(request)

        if request.method == 'GET':
            return __single_player_get(request, player_id)

        elif request.method == 'PUT':
            return __single_player_put(request, player_id)

        elif request.method == 'DELETE':
            return __single_player_delete(request, player_id)

        else:
            return bad_method(request, 'GET, PUT, DELETE')

    except IntegrityError as e:
        print('IntegrityError occurred: ' + e.__str__())
        json_data = {
            'requested-url': '[' + request.method + '] ' + request.get_full_path(),
            'error': e.__str__(),
        }
        return JsonResponse(data=json_data, status=status.HTTP_409_CONFLICT, safe=False, encoder=DjangoJSONEncoder)

    except (Player.DoesNotExist, IndexError) as e:
        print('Game.DoesNotExist or IndexError occurred: ' + e.__str__())
        json_data = {
            'requested-url': '[' + request.method + '] ' + request.get_full_path(),
            'error': 'The game with id:\'' + player_id + '\' is not in the database',
        }
        return JsonResponse(data=json_data, status=status.HTTP_404_NOT_FOUND, safe=False, encoder=DjangoJSONEncoder)

    except JSONDecodeError as e:
        print('JSONDecodeError occurred: ' + e.__str__())
        return bad_json(request, CORRECT_PLAYER_JSON)

    except (AttributeError, KeyError) as e:
        print('AttributeError or KeyError occurred: ' + e.__str__())
        return bad_json(request, CORRECT_PLAYER_JSON)

    except (ValueError, TypeError) as e:
        print('ValueError or TypeError occurred: ' + e.__str__())
        return wrong_property_type(request, CORRECT_PLAYER_JSON)

    except OperationalError as e:
        print('OperationalError: (SQLite file error)' + e.__str__())
        print(
            '*** It seems like the database is not migrated, please follow the "database_migration_help.txt" file ***')
        json_data = {
            'requested-url': '[' + request.method + '] ' + request.get_full_path(),
            'error': 'The database is corrupt, please contact group 20',
        }
        return JsonResponse(data=json_data, status=status.HTTP_500_INTERNAL_SERVER_ERROR, safe=False,
                            encoder=DjangoJSONEncoder)


# -------------
# [ALL] Bad players path
# -------------
@api_view(all_methods)
def players_bad_path(request):
    print_origin(request, 'Players - bad path')
    default_url = '/players/'

    json_data = {
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'error': 'You have requested a wrong path.',
        'helper': 'Maybe you have forgotten a slash?',
        'players endpoint': default_url,
        'single player endpoint': default_url + 's123456/'
    }
    return JsonResponse(data=json_data, status=status.HTTP_400_BAD_REQUEST, safe=False, encoder=DjangoJSONEncoder)


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# INDIVIDUAL METHODS BENEATH
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# -------------
# [GET] /players/
# -------------
def __players_get(request):
    print_origin(request, 'Players')

    return_data = PlayerDatabase.get_all_return_serialized()

    json_data = {
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'players': return_data,
    }
    return JsonResponse(data=json_data, status=status.HTTP_200_OK, safe=False, encoder=DjangoJSONEncoder)


# -------------
# [POST] /players/
# -------------
def __players_post(request):
    print_origin(request, 'Players')

    json_body = json.loads(request.body)

    # Create a database entry
    return_data = PlayerDatabase.create_return_serialized(json_body)

    # if it returns a string, send a missing property json back
    if isinstance(return_data, str):
        return missing_property_in_json(request, return_data, CORRECT_PLAYER_JSON)

    # Prepare jsonResponse data
    json_data = {
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'message': 'You have posted a new player',
        'player': return_data
    }
    return JsonResponse(data=json_data, status=status.HTTP_201_CREATED, safe=False, encoder=DjangoJSONEncoder)


# -------------
# [GET] /players/player_id/
# -------------
def __single_player_get(request, player_id):
    print_origin(request, 'Single player')

    return_data = PlayerDatabase.get_one_return_serialized(player_id)

    json_data = {
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'player': return_data
    }
    return JsonResponse(data=json_data, status=status.HTTP_200_OK, safe=False, encoder=DjangoJSONEncoder)


# -------------
# [PUT] /players/player_id/
# -------------
def __single_player_put(request, player_id):
    print_origin(request, 'Single player')

    json_body = json.loads(request.body)

    # Update a database entry
    return_data = PlayerDatabase.update_return_serialized(json_body, player_id)

    # if it returns a string, send a missing property json back
    if isinstance(return_data, str):
        return missing_property_in_json(request, return_data, CORRECT_PLAYER_JSON)

    # Prepare jsonResponse data
    json_data = {
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'message': 'You have changed player with id: \'' + player_id + '\'',
        'player': return_data,
    }
    return JsonResponse(data=json_data, status=status.HTTP_202_ACCEPTED, safe=False, encoder=DjangoJSONEncoder)


# -------------
# [DELETE] /player/player_id/
# -------------
def __single_player_delete(request, player_id):
    print_origin(request, 'Single player')

    return_data = PlayerDatabase.delete_return_serialized(player_id)

    json_data = {
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'deleted_player': return_data
    }
    return JsonResponse(data=json_data, status=status.HTTP_202_ACCEPTED, safe=False, encoder=DjangoJSONEncoder)
