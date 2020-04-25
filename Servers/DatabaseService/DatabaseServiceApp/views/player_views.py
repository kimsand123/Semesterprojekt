from json import JSONDecodeError

import django
from django.core.serializers.json import DjangoJSONEncoder
from django.db import IntegrityError
from rest_framework.decorators import api_view
from rest_framework.utils import json

from DatabaseServiceApp.database_helpers.player_database_helper import *
from DatabaseServiceApp.helper_methods import *
from DatabaseServiceApp.models import Player
from DatabaseServiceApp.views.default_views import bad_json, missing_property_in_json, wrong_property_type, \
    bad_or_missing_access_key

all_methods = ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'COPY', 'HEAD', 'OPTIONS', 'LINK', 'UNLINK', 'PURGE', 'LOCK',
               'UNLOCK', 'PROPFIND', 'VIEW']

__correct_player_json = {
    'player':
        {
            'username': 's123456',
            'email': 's123456@student.dtu.dk',
            'first_name': 'Søren',
            'last_name': 'Træsko',
            'study_programme': 'Software technology',
            'high_score': 20.1,
        }
}


# path: /players/
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
        return bad_json(request, __correct_player_json)

    except (AttributeError, KeyError) as e:
        print('AttributeError or KeyError occurred: ' + e.__str__())
        return bad_json(request, __correct_player_json)

    except (ValueError, TypeError) as e:
        print('ValueError or TypeError occurred: ' + e.__str__())
        return wrong_property_type(request, __correct_player_json)


# path: /players/<int:player_id>/
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
            return __bad_method(request, 'GET, PUT, DELETE')

    except JSONDecodeError as e:
        print('JSONDecodeError occurred: ' + e.__str__())
        return bad_json(request, __correct_player_json)

    except IntegrityError as e:
        print('IntegrityError occurred: ' + e.__str__())
        json_data = {
            'requested-url': '[' + request.method + '] ' + request.get_full_path(),
            'error': e.__str__(),
        }
        return JsonResponse(data=json_data, status=status.HTTP_409_CONFLICT, safe=False, encoder=DjangoJSONEncoder)

    except (Player.DoesNotExist, IndexError) as e:
        print('Player.DoesNotExist or IndexError occurred: ' + e.__str__())
        json_data = {
            'requested-url': '[' + request.method + '] ' + request.get_full_path(),
            'error': 'The player with id:\'' + player_id + '\' is not in the database',
        }
        return JsonResponse(data=json_data, status=status.HTTP_404_NOT_FOUND, safe=False, encoder=DjangoJSONEncoder)

    except (AttributeError, KeyError) as e:
        print('AttributeError or KeyError occurred: ' + e.__str__())
        return bad_json(request, __correct_player_json)

    except (ValueError, TypeError) as e:
        print('ValueError or TypeError occurred: ' + e.__str__())
        return wrong_property_type(request, __correct_player_json)


# Bad player path
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
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'error': 'This method is not allowed here',
        'helper': 'Only the following methods allowed:[' + allowed_methods + ']',
    }
    return JsonResponse(data=json_data, status=status.HTTP_405_METHOD_NOT_ALLOWED, safe=False,
                        encoder=DjangoJSONEncoder)


# -----------------------------
# Players GET
# -----------------------------
def __players_get(request):
    print_origin(request, 'Players')

    return_data = PlayerDatabase.get_all_return_serialized()

    json_data = {
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'players': return_data,
    }
    return JsonResponse(data=json_data, status=status.HTTP_200_OK, safe=False, encoder=DjangoJSONEncoder)


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
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'message': 'You have posted a new player',
        'player': return_data
    }
    return JsonResponse(data=json_data, status=status.HTTP_201_CREATED, safe=False, encoder=DjangoJSONEncoder)


# -----------------------------
# Single player GET
# -----------------------------
def __single_player_get(request, player_id):
    print_origin(request, 'Single player')

    return_data = PlayerDatabase.get_one_return_serialized(player_id)

    json_data = {
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'player': return_data
    }
    return JsonResponse(data=json_data, status=status.HTTP_200_OK, safe=False, encoder=DjangoJSONEncoder)


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
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'message': 'You have changed player with id: \'' + player_id + '\'',
        'player': return_data,
    }
    return JsonResponse(data=json_data, status=status.HTTP_202_ACCEPTED, safe=False, encoder=DjangoJSONEncoder)


# -----------------------------
# Single player DELETE
# -----------------------------
def __single_player_delete(request, player_id):
    print_origin(request, 'Single player')

    return_data = PlayerDatabase.delete_return_serialized(player_id)

    json_data = {
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'deleted_player': return_data
    }
    return JsonResponse(data=json_data, status=status.HTTP_202_ACCEPTED, safe=False, encoder=DjangoJSONEncoder)
