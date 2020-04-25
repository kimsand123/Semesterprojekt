import json
from json import JSONDecodeError

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


def is_access_key_valid(request):
    try:
        # Early exit on missing game in json
        if not is_key_in_dict(request.headers, 'Authorization'):
            return False

        access_key_to_check = request.headers['Authorization']
        access_key_to_check = str(access_key_to_check).split(" ")[1]

        key_file = open("access_key.txt", "r")

        contents = key_file.read()

        return contents == access_key_to_check

    except JSONDecodeError:
        return False


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
