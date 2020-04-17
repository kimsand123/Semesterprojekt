from json import JSONDecodeError

from django.core.serializers.json import DjangoJSONEncoder
from django.db import IntegrityError
from rest_framework.decorators import api_view
from rest_framework.utils import json

from DatabaseServiceApp.database_helpers.invite_database_helper import InviteDatabase
from DatabaseServiceApp.helper_methods import *
from DatabaseServiceApp.models import Invite, Game

all_methods = ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'COPY', 'HEAD', 'OPTIONS', 'LINK', 'UNLINK', 'PURGE', 'LOCK',
               'UNLOCK', 'PROPFIND', 'VIEW']

__correct_invite_json = {'invite':
    {
        'sender_player_id': '1',
        'receiver_player_id': '2',
        'game_id': '1',
        'accepted': 'false',
    }}


# path: /invites/
@api_view(all_methods)
def invites(request):
    try:
        if request.method == 'GET':
            return __invites_get(request)

        elif request.method == 'POST':
            return __invites_post(request)

        else:
            return __bad_method(request, 'GET, POST')

    except JSONDecodeError:
        return bad_json(request, 'invite', __correct_invite_json)

    except IntegrityError as e:
        print('Error occurred: ' + e.__str__())
        json_data = {
            'url': '[' + request.method + '] ' + request.get_raw_uri(),
            'status': status.HTTP_409_CONFLICT,
            'error': e.__str__(),
        }
        return JsonResponse(data=json_data, safe=False, status=status.HTTP_409_CONFLICT)

    except AttributeError:
        return bad_json(request, 'invite', __correct_invite_json)


# path: /invites/<int:user_id>/
@api_view(all_methods)
def single_invite(request, invite_id):
    try:
        if request.method == 'GET':
            return __single_invite_get(request, invite_id)

        elif request.method == 'PUT':
            return __single_invite_put(request, invite_id)

        elif request.method == 'DELETE':
            return __single_invite_delete(request, invite_id)

        else:
            return __bad_method(request, 'GET, PUT, DELETE')

    except JSONDecodeError:
        return bad_json(request, 'invite', __correct_invite_json)

    except IntegrityError as e:
        json_data = {
            'url': '[' + request.method + '] ' + request.get_raw_uri(),
            'status': status.HTTP_409_CONFLICT,
            'error': e.__str__(),
        }
        return JsonResponse(data=json_data, safe=False, status=status.HTTP_409_CONFLICT)

    except (Invite.DoesNotExist, IndexError):
        json_data = {
            'url': '[' + request.method + '] ' + request.get_raw_uri(),
            'status': status.HTTP_404_NOT_FOUND,
            'error': 'The invite with id:\'' + invite_id + '\' is not in the database',
        }
        return JsonResponse(data=json_data, safe=False, status=status.HTTP_404_NOT_FOUND)

    except AttributeError:
        return bad_json(request, 'invite', __correct_invite_json)


# Bad invite path
@api_view(all_methods)
def invites_bad_path(request):
    print_origin(request, 'Invites - Bad path')

    default_url = 'http://' + request.get_host() + '/invites/'

    json_data = {
        'request-url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_400_BAD_REQUEST,
        'error': 'You have requested a wrong path.',
        'available invite endpoints': default_url + ', ' + default_url + 'invite_id/',
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
    print_origin(request, 'Invites - Bad method')
    json_data = {
        'request-url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_405_METHOD_NOT_ALLOWED,
        'error': 'This method is not allowed here',
        'helper': 'Only the following methods allowed:[' + allowed_methods + ']',
    }
    return JsonResponse(data=json_data, status=status.HTTP_405_METHOD_NOT_ALLOWED, content_type='application/json')


# -----------------------------
# Invites GET
# -----------------------------
def __invites_get(request):
    print_origin(request, 'Invites')

    return_data = InviteDatabase.get_all_return_serialized()

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_200_OK,
        'invites': return_data,
    }
    return JsonResponse(data=json_data, status=status.HTTP_200_OK, content_type='application/json')


# -----------------------------
# Invites POST
# -----------------------------
def __invites_post(request):
    print_origin(request, 'Invites')

    json_dict = json.loads(request.body)

    # Create a database entry
    return_data = InviteDatabase.create_return_serialized(json_dict)

    # if it returns a string, send a missing property json back
    if isinstance(return_data, str):
        return missing_property_in_json(request, return_data, __correct_invite_json)

    # Prepare jsonResponse data
    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_201_CREATED,
        'message': 'You have posted a new invite',
        'invite': return_data
    }
    return JsonResponse(data=json_data, status=status.HTTP_201_CREATED, safe=True, encoder=DjangoJSONEncoder,
                        content_type='application/json')


# -----------------------------
# Single invite GET
# -----------------------------
def __single_invite_get(request, invite_id):
    print_origin(request, 'Single invite')

    return_data = InviteDatabase.get_one_return_serialized(invite_id)

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_200_OK,
        'invite': return_data

    }
    return JsonResponse(data=json_data, status=status.HTTP_200_OK, content_type='application/json')


# -----------------------------
# Single invite PUT
# -----------------------------
def __single_invite_put(request, invite_id):
    print_origin(request, 'Single invite')

    json_body = json.loads(request.body)

    # Update a database entry
    return_data = InviteDatabase.update_return_serialized(json_body, invite_id)

    # if it returns a string, send a missing property json back
    if isinstance(return_data, str):
        return missing_property_in_json(request, return_data, __correct_invite_json)

    # Prepare jsonResponse data
    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_202_ACCEPTED,
        'message': 'You have changed the invite with id: \'' + invite_id + '\'',
        'player': return_data,
    }
    return JsonResponse(data=json_data, status=status.HTTP_202_ACCEPTED, safe=True, encoder=DjangoJSONEncoder,
                        content_type='application/json')


# -----------------------------
# Single invite DELETE
# -----------------------------
def __single_invite_delete(request, invite_id):
    print_origin(request, 'Single invite')

    return_data = InviteDatabase.delete_return_serialized(invite_id)

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_202_ACCEPTED,
        'deleted_invite': return_data
    }
    return JsonResponse(data=json_data, status=status.HTTP_202_ACCEPTED, content_type='application/json')
