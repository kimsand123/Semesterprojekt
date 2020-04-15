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

    default_url = 'http://' + request.get_host() + '/'

    json_data = {
        'status': status.HTTP_200_OK,
        'message': 'Welcome to this DatabaseService',
        'players endpoint': default_url + 'players/',
        'games endpoint': default_url + 'games/',
        'invites endpoint': default_url + 'invites/'
    }

    return JsonResponse(data=json_data, status=status.HTTP_200_OK, content_type='application/json')


# -----------------------------
# Bad path
# -----------------------------
@api_view(all_methods)
def bad_path(request):
    print_origin(request, 'Default bad path')
    default_url = 'http://' + request.get_host() + '/'

    json_data = {
        'request-url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_400_BAD_REQUEST,
        'error': 'You have requested a wrong path.',
        'available endpoints': default_url + 'players/, ' + default_url + 'games/, ' + default_url + 'invites/'
    }
    return JsonResponse(data=json_data, status=status.HTTP_400_BAD_REQUEST, content_type='application/json')
