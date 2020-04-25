from django.core.serializers.json import DjangoJSONEncoder
from rest_framework.decorators import api_view

from DatabaseServiceApp.helper_methods import *

all_methods = ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'COPY', 'HEAD', 'OPTIONS', 'LINK', 'UNLINK', 'PURGE', 'LOCK',
               'UNLOCK', 'PROPFIND', 'VIEW']


# -----------------------------
# Welcome
# -----------------------------
@api_view(all_methods)
def welcome(request):
    print_origin(request, 'Welcome')

    json_data = {
        'message': 'Welcome to this DatabaseService',
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'players endpoint': '/players/',
        'games endpoint': '/games/',
        'invites endpoint': '/invites/',
        'questions endpoint': '/questions/'
    }

    return JsonResponse(data=json_data, status=status.HTTP_200_OK, safe=False, encoder=DjangoJSONEncoder)


# -----------------------------
# Bad path
# -----------------------------
@api_view(all_methods)
def bad_path(request):
    print_origin(request, 'Default bad path')

    json_data = {
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'error': 'You have requested a wrong path.',
        'players endpoint': '/players/',
        'games endpoint': '/games/',
        'invites endpoint': '/invites/',
        'questions endpoint': '/questions/'
    }
    return JsonResponse(data=json_data, status=status.HTTP_400_BAD_REQUEST, safe=False, encoder=DjangoJSONEncoder)


# -----------------------------
# Bad json
# -----------------------------
def bad_json(request, proper_way_dict):
    json_data = {
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'error': 'Your json is badly formatted',
        'helper': 'See the key \'correct-form\' to get help',
        'correct-form': proper_way_dict
    }
    return JsonResponse(data=json_data, status=status.HTTP_400_BAD_REQUEST, safe=False, encoder=DjangoJSONEncoder)


# -----------------------------
# Missing property in json
# -----------------------------
def missing_property_in_json(request, name_missing, proper_way_dict):
    json_data = {
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'error': 'The object json is missing a ' + name_missing + ' attribute',
        'helper': 'See the key \'correct-form\' to get help',
        'correct-form': proper_way_dict
    }
    return JsonResponse(data=json_data, status=status.HTTP_400_BAD_REQUEST, safe=False, encoder=DjangoJSONEncoder)


# -----------------------------
# Wrong property type in json
# -----------------------------
def wrong_property_type(request, proper_way_dict):
    json_data = {
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'error': 'One of the attributes is not the correct type',
        'helper': 'See the key \'correct-form\' to get help',
        'correct-form': proper_way_dict
    }
    return JsonResponse(data=json_data, status=status.HTTP_400_BAD_REQUEST, safe=False, encoder=DjangoJSONEncoder)