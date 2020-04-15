from django.core.serializers.json import DjangoJSONEncoder
from rest_framework.decorators import api_view
from rest_framework.utils import json

from DatabaseServiceApp.helper_methods import *
from DatabaseServiceApp.sql_models import Invite

all_methods = ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'COPY', 'HEAD', 'OPTIONS', 'LINK', 'UNLINK', 'PURGE', 'LOCK',
               'UNLOCK', 'PROPFIND', 'VIEW']


# path: /invites/
@api_view(all_methods)
def invites(request):
    if request.method == 'GET':
        return __invites_get(request)

    elif request.method == 'POST':
        return __invites_post(request)

    else:
        return __bad_method(request, 'GET, POST')


# path: /invites/<int:user_id>/
@api_view(all_methods)
def single_invite(request, id):
    if request.method == 'GET':
        return __single_invite_get(request, id)

    elif request.method == 'PUT':
        return __single_invite_put(request, id)

    elif request.method == 'DELETE':
        return __single_invite_delete(request, id)

    else:
        return __bad_method(request, 'GET, PUT, DELETE')


# Bad invite path
@api_view(all_methods)
def invites_bad_path(request):
    print_origin(request, 'Invites - Bad path')

    default_url = 'http://' + request.get_host() + '/invites/'

    json_data = {
        'request-url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_400_BAD_REQUEST,
        'error': 'You have requested a wrong path.',
        'available invite endpoints': default_url + ', ' + default_url + 'id/',
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

    query_set = Invite.objects.all().values()
    object_data = json.dumps(list(query_set), ensure_ascii=False, cls=DjangoJSONEncoder)

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_501_NOT_IMPLEMENTED,
        'message': 'This is not implemented yet',
        'invites': json.loads(object_data)

    }
    return JsonResponse(data=json_data, status=status.HTTP_501_NOT_IMPLEMENTED, content_type='application/json')


# -----------------------------
# Invites POST
# -----------------------------
def __invites_post(request):
    print_origin(request, 'Invites')

    json_dict = dict(json.loads(request.body))

    # TODO: Not working yet
    invite = Invite(sender_player_id=json_dict['sender_player_id'], receiver_player_id=json_dict['receiver_player_id'],
                    game_id=json_dict['game_id'], accepted=json_dict['accepted'])
    invite.save()

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_501_NOT_IMPLEMENTED,
        'message': 'This is not implemented yet',
    }
    return JsonResponse(data=json_data, status=status.HTTP_501_NOT_IMPLEMENTED, content_type='application/json')


# -----------------------------
# Single invite GET
# -----------------------------
def __single_invite_get(request, id):
    print_origin(request, 'Single invite')

    query_set = Invite.objects.all().filter(id=id).values()
    single_object = list(query_set)[0]
    object_data = json.dumps(single_object, ensure_ascii=False, cls=DjangoJSONEncoder)

    # TODO: exception handling

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_501_NOT_IMPLEMENTED,
        'message': 'This is not implemented yet',
    }
    return JsonResponse(data=json_data, status=status.HTTP_501_NOT_IMPLEMENTED, content_type='application/json')


# -----------------------------
# Single invite PUT
# -----------------------------
def __single_invite_put(request, id):
    print_origin(request, 'Single invite')

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_501_NOT_IMPLEMENTED,
        'message': 'This is not implemented yet',
    }
    return JsonResponse(data=json_data, status=status.HTTP_501_NOT_IMPLEMENTED, content_type='application/json')


# -----------------------------
# Single invite DELETE
# -----------------------------
def __single_invite_delete(request, id):
    print_origin(request, 'Single invite')

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_501_NOT_IMPLEMENTED,
        'message': 'This is not implemented yet',
    }
    return JsonResponse(data=json_data, status=status.HTTP_501_NOT_IMPLEMENTED, content_type='application/json')
