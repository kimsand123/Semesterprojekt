from django.core.serializers.json import DjangoJSONEncoder
from django.http import HttpResponse
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
        'invites endpoint': '/invites/'
    }

    return JsonResponse(data=json_data, status=status.HTTP_200_OK, encoder=DjangoJSONEncoder)


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
        'invites endpoint': '/invites/'
    }
    return JsonResponse(data=json_data, status=status.HTTP_400_BAD_REQUEST, encoder=DjangoJSONEncoder)
