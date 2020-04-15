from json import JSONDecodeError
from django.core.serializers.json import DjangoJSONEncoder
from django.db import IntegrityError
from rest_framework.decorators import api_view
from rest_framework.utils import json

from DatabaseServiceApp.helper_methods import *
from DatabaseServiceApp.sql_models import Player

all_methods = ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'COPY', 'HEAD', 'OPTIONS', 'LINK', 'UNLINK', 'PURGE', 'LOCK',
               'UNLOCK', 'PROPFIND', 'VIEW']

correct_player_json = '' + \
                      '{' + \
                      ' "player": ' + \
                      '{' + \
                      '"username": "s123456",' + \
                      '"email":"s123456@student.dtu.dk",' + \
                      '"first_name":"Torben",' + \
                      '"last_name":"Test",' + \
                      '"study_programme":"Software technology",' + \
                      '"high_score":2000' + \
                      '}' + \
                      '}'


# path: /players/
@api_view(all_methods)
def players(request):
    if request.method == 'GET':
        return __players_get(request)

    elif request.method == 'POST':
        return __players_post(request)
    else:
        return __bad_method(request, 'GET, POST')


# path: /players/<int:player_id>/
@api_view(all_methods)
def single_player(request, player_id):
    if request.method == 'GET':
        return __single_player_get(request, player_id)
    elif request.method == 'PUT':
        return __single_player_put(request, player_id)
    elif request.method == 'DELETE':
        return __single_player_delete(request, player_id)
    else:
        return __bad_method(request, 'GET, PUT, DELETE')


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

    query_set = Player.objects.all().values()
    object_data = json.dumps(list(query_set), ensure_ascii=False, cls=DjangoJSONEncoder)

    json_data = {
        'url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_200_OK,
        'players': json.loads(object_data)
    }
    return JsonResponse(data=json_data, status=status.HTTP_200_OK, content_type='application/json')


# -----------------------------
# Players POST
# -----------------------------
def __players_post(request):
    print_origin(request, 'Players')

    try:
        json_body = json.loads(request.body)

        # Early exit on missing player in json
        if not is_key_in_dict(json_body, 'player'):
            return bad_json(request, 'player', correct_player_json)

        json_user = json_body['player']

        # Check for required attributes in the player object
        if not is_key_in_dict(json_user, 'username'):
            return missing_property_in_json(request, 'username', correct_player_json)
        elif not is_key_in_dict(json_user, 'email'):
            return missing_property_in_json(request, 'email', correct_player_json)
        elif not is_key_in_dict(json_user, 'first_name'):
            return missing_property_in_json(request, 'first_name', correct_player_json)
        elif not is_key_in_dict(json_user, 'last_name'):
            return missing_property_in_json(request, 'last_name', correct_player_json)
        elif not is_key_in_dict(json_user, 'study_programme'):
            return missing_property_in_json(request, 'study_programme', correct_player_json)

        # Type check before saving to database
        if not isinstance(json_user['username'], str):
            return wrong_property_type(request, 'username', 'string')
        elif not isinstance(json_user['email'], str):
            return wrong_property_type(request, 'email', 'string')
        elif not isinstance(json_user['first_name'], str):
            return wrong_property_type(request, 'first_name', 'string')
        elif not isinstance(json_user['last_name'], str):
            return wrong_property_type(request, 'last_name', 'string')
        elif not isinstance(json_user['study_programme'], str):
            return wrong_property_type(request, 'study_programme', 'string')

        # Check if high_score is in the json_user
        if is_key_in_dict(json_user, 'high_score'):
            # Type check high_score
            if not isinstance(json_user['high_score'], int):
                return wrong_property_type(request, 'high_score', 'int')

            # Save the object in database
            player = Player(username=json_user['username'], email=json_user['email'],
                            first_name=json_user['first_name'], last_name=json_user['last_name'],
                            study_programme=json_user['study_programme'], high_score=json_user['high_score'])
            player.save()

        else:
            # Save the object in database
            player = Player(username=json_user['username'], email=json_user['email'],
                            first_name=json_user['first_name'], last_name=json_user['last_name'],
                            study_programme=json_user['study_programme'])
            player.save()

        # Remove '_state' key/value
        player.__dict__.__delitem__('_state')

        # Prepare jsonResponse data
        json_data = {
            'url': '[' + request.method + '] ' + request.get_raw_uri(),
            'status': status.HTTP_200_OK,
            'message': 'You have posted a new user',
            'player': str(player.__dict__),
        }
        return JsonResponse(data=json_data, status=status.HTTP_201_CREATED, safe=True, encoder=DjangoJSONEncoder,
                            content_type='application/json')

    except JSONDecodeError:
        return bad_json(request, 'player', correct_player_json)
    except IntegrityError as e:
        print(e)
        return JsonResponse(data=e.__str__(), safe=False, status=status.HTTP_409_CONFLICT)


# -----------------------------
# Single player GET
# -----------------------------
def __single_player_get(request, player_id):
    print_origin(request, 'Single player')

    try:
        if str(player_id).isdigit():
            player = Player.objects.get(id=player_id)
            player.__dict__.__delitem__('_state')
        else:
            player = Player.objects.get(username=player_id)
            player.__dict__.__delitem__('_state')

        json_data = {
            'url': '[' + request.method + '] ' + request.get_raw_uri(),
            'status': status.HTTP_200_OK,
            'player': str(player.__dict__)
        }
        return JsonResponse(data=json_data, status=status.HTTP_200_OK, content_type='application/json')

    except Player.DoesNotExist:
        json_data = {
            'url': '[' + request.method + '] ' + request.get_raw_uri(),
            'status': status.HTTP_404_NOT_FOUND,
            'error': 'The player with id:\'' + player_id + '\' is not in the database',
        }
        return JsonResponse(data=json_data, safe=False, status=status.HTTP_404_NOT_FOUND)


# -----------------------------
# Single player PUT
# -----------------------------
def __single_player_put(request, player_id):
    print_origin(request, 'Single player')
    try:
        try:
            if str(player_id).isdigit():
                player = Player.objects.get(id=player_id)
            else:
                player = Player.objects.get(username=player_id)

            json_body = json.loads(request.body)

            # Early exit on missing player in json
            if not is_key_in_dict(json_body, 'player'):
                return bad_json(request, 'player', correct_player_json)

            json_user = json_body['player']

            # Check for required attributes in the player object
            # Type check before saving to object
            if is_key_in_dict(json_user, 'username'):
                if not isinstance(json_user['username'], str):
                    return wrong_property_type(request, 'username', 'string')
                else:
                    player.username = json_user['username']

            if is_key_in_dict(json_user, 'email'):
                if not isinstance(json_user['email'], str):
                    return wrong_property_type(request, 'email', 'string')
                else:
                    player.email = json_user['email']

            if is_key_in_dict(json_user, 'first_name'):
                if not isinstance(json_user['first_name'], str):
                    return wrong_property_type(request, 'first_name', 'string')
                else:
                    player.first_name = json_user['first_name']

            if is_key_in_dict(json_user, 'last_name'):
                if not isinstance(json_user['last_name'], str):
                    return wrong_property_type(request, 'last_name', 'string')
                else:
                    player.last_name = json_user['last_name']

            if is_key_in_dict(json_user, 'study_programme'):
                if not isinstance(json_user['study_programme'], str):
                    return wrong_property_type(request, 'study_programme', 'string')
                else:
                    player.study_programme = json_user['study_programme']

            if is_key_in_dict(json_user, 'high_score'):
                if not isinstance(json_user['high_score'], int):
                    return wrong_property_type(request, 'high_score', 'int')
                else:
                    player.high_score = json_user['high_score']

            # Save changed object to database
            player.save()

            # Remove '_state' key/value
            player.__dict__.__delitem__('_state')

            # Prepare jsonResponse data
            json_data = {
                'url': '[' + request.method + '] ' + request.get_raw_uri(),
                'status': status.HTTP_200_OK,
                'message': 'You have changed user with id: \'' + player_id + '\'',
                'player': str(player.__dict__),
            }
            return JsonResponse(data=json_data, status=status.HTTP_201_CREATED, safe=True, encoder=DjangoJSONEncoder,
                                content_type='application/json')
        except JSONDecodeError:
            return bad_json(request, 'player', correct_player_json)
        except IntegrityError as e:
            print(e)
            return JsonResponse(data=e.__str__(), safe=False, status=status.HTTP_409_CONFLICT)

    except Player.DoesNotExist:
        json_data = {
            'url': '[' + request.method + '] ' + request.get_raw_uri(),
            'status': status.HTTP_404_NOT_FOUND,
            'error': 'The player with id:\'' + player_id + '\' is not in the database',
        }
        return JsonResponse(data=json_data, safe=False, status=status.HTTP_404_NOT_FOUND)


# -----------------------------
# Single player DELETE
# -----------------------------
def __single_player_delete(request, player_id):
    print_origin(request, 'Single player')

    try:
        if str(player_id).isdigit():
            Player.objects.filter(id=player_id).delete()
        else:
            Player.objects.filter(username=player_id).delete()

        json_data = {
            'url': '[' + request.method + '] ' + request.get_raw_uri(),
            'message': 'Player with id:\'' + player_id + '\' was deleted',
            'status': status.HTTP_202_ACCEPTED,
        }
        return JsonResponse(data=json_data, status=status.HTTP_202_ACCEPTED, content_type='application/json')

    except IndexError:
        json_data = {
            'url': '[' + request.method + '] ' + request.get_raw_uri(),
            'status': status.HTTP_404_NOT_FOUND,
            'error': 'The player with id:\'' + player_id + '\' is not in the database',
        }
        return JsonResponse(data=json_data, safe=False, status=status.HTTP_404_NOT_FOUND)
