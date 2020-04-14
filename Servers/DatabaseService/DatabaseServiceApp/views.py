from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response


# Welcome message for the path "/"
@api_view(['GET', 'POST', 'PUT', 'PATCH', 'DELETE'])
def welcome(request):
    json_data = {
        'status': status.HTTP_200_OK,
        'message': 'Welcome to this DatabaseService',
        'url': '\'http://' + request.get_host() + '/database/\''
    }
    return Response(data=json_data, status=status.HTTP_200_OK)


# Bad request message for the all other paths than defined
@api_view(['GET', 'POST', 'PUT', 'PATCH', 'DELETE'])
def bad_request(request):
    print('** Bad request: ' + request.get_raw_uri())

    json_data = {
        'request-url': '[' + request.method + ']-' + request.get_raw_uri(),
        'status': status.HTTP_400_BAD_REQUEST,
        'error': 'You have requested a wrong path.',  # TODO mention all available paths
        'url': '\'http://' + request.get_host() + '/database/\''
    }
    return Response(data=json_data, status=status.HTTP_400_BAD_REQUEST)


# path: /users/
@api_view(['GET', 'POST', 'PUT', 'PATCH', 'DELETE'])
def users(request):
    print('** user list request: [' + request.method + '] ' + request.path)

    if request.method == 'GET':
        json_data = {
            'request-url': '[' + request.method + ']-' + request.path,
            'status': status.HTTP_200_OK,
            'message': 'This is a test',
            'url': '\'http://' + request.get_host() + '/database/\''
        }
        return Response(data=json_data, status=status.HTTP_200_OK)

    elif request.method == 'POST':
        json_data = {
            'request-url': '[' + request.method + ']-' + request.path,
            'status': status.HTTP_200_OK,
            'message': 'This is a test',
            'url': '\'http://' + request.get_host() + '/database/\''
        }
        return Response(data=json_data, status=status.HTTP_200_OK)

    else:
        json_data = {
            'request-url': request.get_raw_uri(),
            'status': status.HTTP_405_METHOD_NOT_ALLOWED,
            'error': 'This method is not allowed here',
            'url': '\'http://' + request.get_host() + '/database/\''
        }
        return Response(data=json_data, status=status.HTTP_405_METHOD_NOT_ALLOWED)


# path: /users/<int:user_id>/
@api_view(['GET', 'POST', 'PUT', 'PATCH', 'DELETE'])
def single_user(request, user_id):
    print('** Single user request: [' + request.method + '] ' + request.path)
    print('** with user: ' + user_id)

    if request.method == 'GET':
        json_data = {
            'request-url': '[' + request.method + ']-' + request.path,
            'status': status.HTTP_200_OK,
            'message': 'This is a test',
            'url': '\'http://' + request.get_host() + '/database/\''
        }
        return Response(data=json_data, status=status.HTTP_200_OK)

    else:
        json_data = {
            'request-url': request.get_raw_uri(),
            'status': status.HTTP_405_METHOD_NOT_ALLOWED,
            'error': 'This method is not allowed here',
            'url': '\'http://' + request.get_host() + '/database/\''
        }
        return Response(data=json_data, status=status.HTTP_405_METHOD_NOT_ALLOWED)


# path: /invites/
@api_view(['GET', 'POST', 'PUT', 'PATCH', 'DELETE'])
def invites(request):
    print('** invites request: [' + request.method + '] ' + request.path)

    if request.method == 'GET':
        json_data = {
            'request-url': '[' + request.method + ']-' + request.path,
            'status': status.HTTP_200_OK,
            'message': 'This is a test',
            'url': '\'http://' + request.get_host() + '/database/\''
        }
        return Response(data=json_data, status=status.HTTP_200_OK)

    elif request.method == 'POST':
        json_data = {
            'request-url': '[' + request.method + ']-' + request.path,
            'status': status.HTTP_200_OK,
            'message': 'This is a test',
            'url': '\'http://' + request.get_host() + '/database/\''
        }
        return Response(data=json_data, status=status.HTTP_200_OK)

    else:
        json_data = {
            'request-url': request.get_raw_uri(),
            'status': status.HTTP_405_METHOD_NOT_ALLOWED,
            'error': 'This method is not allowed here',
            'url': '\'http://' + request.get_host() + '/database/\''
        }
        return Response(data=json_data, status=status.HTTP_405_METHOD_NOT_ALLOWED)


# path: /invites/<str:invite_id>/
@api_view(['GET', 'POST', 'PUT', 'PATCH', 'DELETE'])
def single_invite(request, invite_id):
    print('** Single invite request: [' + request.method + '] ' + request.path)
    print('** with invite: ' + invite_id)

    if request.method == 'GET':
        json_data = {
            'request-url': '[' + request.method + ']-' + request.path,
            'status': status.HTTP_200_OK,
            'message': 'This is a test',
            'url': '\'http://' + request.get_host() + '/database/\''
        }
        return Response(data=json_data, status=status.HTTP_200_OK)

    elif request.method == 'PUT':
        json_data = {
            'request-url': '[' + request.method + ']-' + request.path,
            'status': status.HTTP_200_OK,
            'message': 'This is a test',
            'url': '\'http://' + request.get_host() + '/database/\''
        }
        return Response(data=json_data, status=status.HTTP_200_OK)

    else:
        json_data = {
            'request-url': request.get_raw_uri(),
            'status': status.HTTP_405_METHOD_NOT_ALLOWED,
            'error': 'This method is not allowed here',
            'url': '\'http://' + request.get_host() + '/database/\''
        }
        return Response(data=json_data, status=status.HTTP_405_METHOD_NOT_ALLOWED)
