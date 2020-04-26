from json import JSONDecodeError

from django.core.serializers.json import DjangoJSONEncoder
from django.db import IntegrityError
from rest_framework.decorators import api_view
from rest_framework.utils import json

from DatabaseServiceApp.database_helpers.invite_database_helper import InviteDatabase
from DatabaseServiceApp.helper_methods import *
from DatabaseServiceApp.models import Invite
from DatabaseServiceApp.views.default_views import bad_json, missing_property_in_json, wrong_property_type, \
    bad_or_missing_access_key

all_methods = ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'COPY', 'HEAD', 'OPTIONS', 'LINK', 'UNLINK', 'PURGE', 'LOCK',
               'UNLOCK', 'PROPFIND', 'VIEW']

__correct_invite_json = {
    "invite":
        {
            "sender_player_id": 1,
            "receiver_player_id": 1,
            "match_name": "Example match",
            "question_duration": 15,
            "accepted": False
        }
}


# path: /invites/
@api_view(all_methods)
def invites(request):
    try:
        if not is_access_key_valid(request):
            return bad_or_missing_access_key(request)

        if request.method == 'GET':
            return __invites_get(request)

        elif request.method == 'POST':
            return __invites_post(request)

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
        return bad_json(request, __correct_invite_json)

    except (AttributeError, KeyError) as e:
        print('AttributeError or KeyError occurred: ' + e.__str__())
        return bad_json(request, __correct_invite_json)

    except (ValueError, TypeError) as e:
        print('ValueError or TypeError occurred: ' + e.__str__())
        return wrong_property_type(request, __correct_invite_json)


# path: /invites/<int:invite_id>/
@api_view(all_methods)
def single_invite(request, invite_id):
    try:
        if not is_access_key_valid(request):
            return bad_or_missing_access_key(request)

        if request.method == 'GET':
            return __single_invite_get(request, invite_id)

        elif request.method == 'PUT':
            return __single_invite_put(request, invite_id)

        elif request.method == 'DELETE':
            return __single_invite_delete(request, invite_id)

        else:
            return __bad_method(request, 'GET, PUT, DELETE')

    except IntegrityError as e:
        print('IntegrityError occurred: ' + e.__str__())
        json_data = {
            'requested-url': '[' + request.method + '] ' + request.get_full_path(),
            'error': e.__str__(),
        }
        return JsonResponse(data=json_data, status=status.HTTP_409_CONFLICT, safe=False, encoder=DjangoJSONEncoder)

    except (Invite.DoesNotExist, IndexError) as e:
        print('Invite.DoesNotExist or IndexError occurred: ' + e.__str__())
        json_data = {
            'requested-url': '[' + request.method + '] ' + request.get_full_path(),
            'error': 'The invite with id:\'' + invite_id + '\' is not in the database',
        }
        return JsonResponse(data=json_data, status=status.HTTP_404_NOT_FOUND, safe=False, encoder=DjangoJSONEncoder)

    except JSONDecodeError as e:
        print('JSONDecodeError occurred: ' + e.__str__())
        return bad_json(request, __correct_invite_json)

    except (AttributeError, KeyError) as e:
        print('AttributeError or KeyError occurred: ' + e.__str__())
        return bad_json(request, __correct_invite_json)

    except (ValueError, TypeError) as e:
        print('ValueError or TypeError occurred: ' + e.__str__())
        return wrong_property_type(request, __correct_invite_json)


# Bad invite path
@api_view(all_methods)
def invites_bad_path(request):
    print_origin(request, 'Invites - Bad path')

    default_url = '/invites/'

    json_data = {
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'error': 'You have requested a wrong path.',
        'helper': 'Maybe you have forgotten a slash?',
        'invites endpoint': default_url,
        'single invite endpoint': default_url + '1/',
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
    print_origin(request, 'Invites - Bad method')
    json_data = {
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'error': 'This method is not allowed here',
        'helper': 'Only the following methods allowed:[' + allowed_methods + ']',
    }
    return JsonResponse(data=json_data, status=status.HTTP_405_METHOD_NOT_ALLOWED, safe=False,
                        encoder=DjangoJSONEncoder)


# -----------------------------
# Invites GET
# -----------------------------
def __invites_get(request):
    print_origin(request, 'Invites')

    try:
        json_dict = json.loads(request.body)

        return_data = InviteDatabase.get_all_return_serialized(json_dict)



        json_data = {
            'requested-url': '[' + request.method + '] ' + request.get_full_path(),
            'invites_as_sender': return_data['invites_as_sender'],
            'invites_as_receiver': return_data['invites_as_receiver'],
        }
        return JsonResponse(data=json_data, status=status.HTTP_200_OK, safe=False, encoder=DjangoJSONEncoder)

    except JSONDecodeError:
        return_data = InviteDatabase.get_all_return_serialized({})

        json_data = {
            'requested-url': '[' + request.method + '] ' + request.get_full_path(),
            'invites': return_data,
        }
        return JsonResponse(data=json_data, status=status.HTTP_200_OK, safe=False, encoder=DjangoJSONEncoder)


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
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'message': 'You have posted a new invite',
        'invite': return_data
    }
    return JsonResponse(data=json_data, status=status.HTTP_201_CREATED, safe=False, encoder=DjangoJSONEncoder)


# -----------------------------
# Single invite GET
# -----------------------------
def __single_invite_get(request, invite_id):
    print_origin(request, 'Single invite')

    return_data = InviteDatabase.get_one_return_serialized(invite_id)

    json_data = {
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'invite': return_data
    }
    return JsonResponse(data=json_data, status=status.HTTP_200_OK, safe=False, encoder=DjangoJSONEncoder)


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
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'message': 'You have changed the invite with id: \'' + invite_id + '\'',
        'invite': return_data,
    }
    return JsonResponse(data=json_data, status=status.HTTP_202_ACCEPTED, safe=False, encoder=DjangoJSONEncoder)


# -----------------------------
# Single invite DELETE
# -----------------------------
def __single_invite_delete(request, invite_id):
    print_origin(request, 'Single invite')

    return_data = InviteDatabase.delete_return_serialized(invite_id)

    json_data = {
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'deleted_invite': return_data
    }
    return JsonResponse(data=json_data, status=status.HTTP_202_ACCEPTED, safe=False, encoder=DjangoJSONEncoder)
