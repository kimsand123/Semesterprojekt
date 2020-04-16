from json import JSONDecodeError
from sqlite3 import IntegrityError

from django.core.serializers.json import DjangoJSONEncoder
from rest_framework.decorators import api_view
from rest_framework.utils import json

from DatabaseServiceApp.database_helpers.invite_database_helper import invite_database_get_all
from DatabaseServiceApp.helper_methods import *
from DatabaseServiceApp.serializers import InviteSerializer
from DatabaseServiceApp.sql_models import Invite, Game

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
            'status': status.HTTP_404_NOT_FOUND,
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

    invites_query = invite_database_get_all()
    serializer = InviteSerializer()
    return_data = json.loads(serializer.serialize(invites_query).__str__())

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_200_OK,
        'invites': return_data,
    }
    return JsonResponse(data=json_data, status=status.HTTP_200_OK, content_type='application/json')

    """
    query_set = Invite.objects.all().values()
    list_of_objects = list(query_set)

    for invite in list_of_objects:
        # Get sender_player
        sender_player = Player.objects.get(id=invite['sender_player_id_id']).__dict__
        sender_player.__delitem__('_state')
        json_sender_player = json.dumps(sender_player, ensure_ascii=False, cls=DjangoJSONEncoder)

        # Insert replacement for sender_player
        invite.__delitem__('sender_player_id_id')
        invite['sender_player'] = json.loads(json_sender_player)

        # Get sender_player
        receiver_player = Player.objects.get(id=invite['receiver_player_id_id']).__dict__
        receiver_player.__delitem__('_state')
        json_receiver_player = json.dumps(receiver_player, ensure_ascii=False, cls=DjangoJSONEncoder)

        # Insert replacement for receiver_player
        invite.__delitem__('receiver_player_id_id')
        invite['receiver_player'] = json.loads(json_receiver_player)

        # Get game
        game = Game.objects.get(id=invite['game_id_id']).__dict__
        game.__delitem__('_state')
        game['todo'] = 'More of the object to come..'
        json_game = json.dumps(game, ensure_ascii=False, cls=DjangoJSONEncoder)

        # Insert replacement for game
        invite.__delitem__('game_id_id')
        invite['game'] = json.loads(json_game)
        # TODO: Add the whole item
    


    object_data = json.dumps(list_of_objects, ensure_ascii=False, cls=DjangoJSONEncoder)

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_200_OK,
        'invites': json.loads(object_data)

    }
    return JsonResponse(data=json_data, status=status.HTTP_200_OK, content_type='application/json')
    """


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
    invite = list(query_set)[0]

    # Get sender_player
    sender_player = Invite.objects.get(id=invite['sender_player_id_id']).__dict__
    sender_player.__delitem__('_state')
    json_sender_player = json.dumps(sender_player, ensure_ascii=False, cls=DjangoJSONEncoder)

    # Insert replacement for sender_player
    invite.__delitem__('sender_player_id_id')
    invite['sender_player'] = json.loads(json_sender_player)

    # Get sender_player
    receiver_player = Invite.objects.get(id=invite['receiver_player_id_id']).__dict__
    receiver_player.__delitem__('_state')
    json_receiver_player = json.dumps(receiver_player, ensure_ascii=False, cls=DjangoJSONEncoder)

    # Insert replacement for receiver_player
    invite.__delitem__('receiver_player_id_id')
    invite['receiver_player'] = json.loads(json_receiver_player)

    # Get game
    game = Game.objects.get(id=invite['game_id_id']).__dict__
    game.__delitem__('_state')
    game['todo'] = 'More of the object to come..'
    json_game = json.dumps(game, ensure_ascii=False, cls=DjangoJSONEncoder)

    # Insert replacement for game
    invite.__delitem__('game_id_id')
    invite['game'] = json.loads(json_game)
    # TODO: Add the whole item

    object_data = json.dumps(invite, ensure_ascii=False, cls=DjangoJSONEncoder)

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_200_OK,
        'invite': json.loads(object_data)

    }
    return JsonResponse(data=json_data, status=status.HTTP_200_OK, content_type='application/json')


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
