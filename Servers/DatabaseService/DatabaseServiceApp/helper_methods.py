from django.http import JsonResponse
from rest_framework import status


# -----------------------------
# Check key in dict
# -----------------------------
def is_key_in_dict(dictionary, key):
    if key in dictionary.keys():
        return True
    else:
        return False


# -----------------------------
# Bad json
# -----------------------------
def bad_json(request, json_object, proper_way_dict):
    json_data = {
        'request-url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_400_BAD_REQUEST,
        'error': 'Your json is badly formatted',
        'helper': 'See the key \'correct-form\' to get help',
        'correct-form': proper_way_dict
    }
    return JsonResponse(data=json_data, status=status.HTTP_400_BAD_REQUEST, safe=False, content_type='application/json')


# -----------------------------
# Missing property in json
# -----------------------------
def missing_property_in_json(request, name_missing, proper_way_dict):
    json_data = {
        'request-url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_400_BAD_REQUEST,
        'error': 'The object json is missing a ' + name_missing + ' attribute',
        'helper': 'Here is an example on a correct json: ',
        'correct-form': proper_way_dict
    }
    return JsonResponse(data=json_data, status=status.HTTP_400_BAD_REQUEST, safe=False, content_type='application/json')


# -----------------------------
# Wrong property type in json
# -----------------------------
def wrong_property_type(request, property_name, should_be_type):
    json_data = {
        'request-url': '[' + request.method + '] ' + request.get_raw_uri(),
        'status': status.HTTP_400_BAD_REQUEST,
        'error': 'Type-error, the property \'' + property_name + '\' should be: ' + should_be_type,
    }
    return JsonResponse(data=json_data, status=status.HTTP_400_BAD_REQUEST, safe=True, content_type='application/json')


# -----------------------------
# Print request origin
# -----------------------------
def print_origin(request, name):
    print('** ' + name + ' [' + request.method + ']: ' + request.get_raw_uri())
    print('** Request from ' +
          '(Address: ' + request.META['REMOTE_ADDR'] +
          # Not available on linux #', Name: ' + request.META['COMPUTERNAME'] +
          # Not available on linux #', OS: ' + request.META['OS'] +
          ', Agent: ' + request.META['HTTP_USER_AGENT'] +
          ')')
