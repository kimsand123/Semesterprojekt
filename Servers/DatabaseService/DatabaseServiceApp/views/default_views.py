from django.http import HttpResponse, JsonResponse
from rest_framework import status
from rest_framework.decorators import api_view

all_methods = ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'COPY', 'HEAD', 'OPTIONS', 'LINK', 'UNLINK', 'PURGE', 'LOCK',
               'UNLOCK', 'PROPFIND', 'VIEW']


# Welcome message for the path "/"
@api_view(all_methods)
def welcome(request):
    default_url = 'http://' + request.get_host() + '/'

    json_data = {
        'status': status.HTTP_200_OK,
        'message': 'Welcome to this DatabaseService',
        'available endpoints': default_url + 'players/, ' + default_url + 'games/, ' + default_url + 'invites/'
    }

    return JsonResponse(data=json_data, status=status.HTTP_200_OK, content_type='application/json')


# Bad request message for the all other paths than defined
@api_view(all_methods)
def bad_request(request):
    print('** Bad request: ' + request.get_raw_uri())
    default_url = 'http://' + request.get_host() + '/'

    json_data = {
        'request-url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_400_BAD_REQUEST,
        'error': 'You have requested a wrong path.',  # TODO mention all available paths
        'available endpoints': default_url + 'players/, ' + default_url + 'games/, ' + default_url + 'invites/'
    }
    return JsonResponse(data=json_data, status=status.HTTP_400_BAD_REQUEST)
