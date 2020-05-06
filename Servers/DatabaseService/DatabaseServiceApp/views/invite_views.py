from django.core.serializers.json import DjangoJSONEncoder
from django.db import IntegrityError, OperationalError
from django.http import JsonResponse
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.utils import json

from DatabaseServiceApp.views.correct_jsons import CORRECT_INVITE_JSON
from DatabaseServiceApp.database_helpers.invite_database_helper import InviteDatabase
from DatabaseServiceApp.views.helper_methods import *
from DatabaseServiceApp.models import Invite
from DatabaseServiceApp.views.default_views import bad_json, missing_property_in_json, wrong_property_type, \
    bad_or_missing_access_key, all_methods, bad_method


# -------------
# [GET / POST] /invites/
# -------------
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
        return bad_json(request, CORRECT_INVITE_JSON)

    except (AttributeError, KeyError) as e:
        print('AttributeError or KeyError occurred: ' + e.__str__())
        return bad_json(request, CORRECT_INVITE_JSON)

    except (ValueError, TypeError) as e:
        print('ValueError or TypeError occurred: ' + e.__str__())
        return wrong_property_type(request, CORRECT_INVITE_JSON)

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
# [GET / PUT / DELETE] /invites/invite_id
# -------------
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
            return bad_method(request, 'GET, PUT, DELETE')

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
        return bad_json(request, CORRECT_INVITE_JSON)

    except (AttributeError, KeyError) as e:
        print('AttributeError or KeyError occurred: ' + e.__str__())
        return bad_json(request, CORRECT_INVITE_JSON)

    except (ValueError, TypeError) as e:
        print('ValueError or TypeError occurred: ' + e.__str__())
        return wrong_property_type(request, CORRECT_INVITE_JSON)

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
# [ALL] Bad invites path
# -------------
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


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# INDIVIDUAL METHODS BENEATH
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


# -------------
# [GET] /invites/
# -------------
def __invites_get(request):
    print_origin(request, 'Invites')

    return_data = InviteDatabase.get_all_return_serialized(request.GET)

    if 'invites_as_sender' in return_data and 'invites_as_receiver' in return_data:
        json_data = {
            'requested-url': '[' + request.method + '] ' + request.get_full_path(),
            'invites_as_sender': return_data['invites_as_sender'],
            'invites_as_receiver': return_data['invites_as_receiver'],
        }
        return JsonResponse(data=json_data, status=status.HTTP_200_OK, safe=False, encoder=DjangoJSONEncoder)
    else:
        json_data = {
            'requested-url': '[' + request.method + '] ' + request.get_full_path(),
            'invites': return_data,
        }
        return JsonResponse(data=json_data, status=status.HTTP_200_OK, safe=False, encoder=DjangoJSONEncoder)


# -------------
# [POST] /invites/
# -------------
def __invites_post(request):
    print_origin(request, 'Invites')

    json_dict = json.loads(request.body)

    # Create a database entry
    return_data = InviteDatabase.create_return_serialized(json_dict)

    # if it returns a string, send a missing property json back
    if isinstance(return_data, str):
        return missing_property_in_json(request, return_data, CORRECT_INVITE_JSON)

    # Prepare jsonResponse data
    json_data = {
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'message': 'You have posted a new invite',
        'invite': return_data
    }
    return JsonResponse(data=json_data, status=status.HTTP_201_CREATED, safe=False, encoder=DjangoJSONEncoder)


# -------------
# [GET] /invites/invite_id/
# -------------
def __single_invite_get(request, invite_id):
    print_origin(request, 'Single invite')

    return_data = InviteDatabase.get_one_return_serialized(invite_id)

    json_data = {
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'invite': return_data
    }
    return JsonResponse(data=json_data, status=status.HTTP_200_OK, safe=False, encoder=DjangoJSONEncoder)


# -------------
# [PUT] /invites/invite_id/
# -------------
def __single_invite_put(request, invite_id):
    print_origin(request, 'Single invite')

    json_body = json.loads(request.body)

    # Update a database entry
    return_data = InviteDatabase.update_return_serialized(json_body, invite_id)

    # if it returns a string, send a missing property json back
    if isinstance(return_data, str):
        return missing_property_in_json(request, return_data, CORRECT_INVITE_JSON)

    # Prepare jsonResponse data
    json_data = {
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'message': 'You have changed the invite with id: \'' + invite_id + '\'',
        'invite': return_data,
    }
    return JsonResponse(data=json_data, status=status.HTTP_202_ACCEPTED, safe=False, encoder=DjangoJSONEncoder)


# -------------
# [DELETE] /invites/invite_id/
# -------------
def __single_invite_delete(request, invite_id):
    print_origin(request, 'Single invite')

    return_data = InviteDatabase.delete_return_serialized(invite_id)

    json_data = {
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'deleted_invite': return_data
    }
    return JsonResponse(data=json_data, status=status.HTTP_202_ACCEPTED, safe=False, encoder=DjangoJSONEncoder)
