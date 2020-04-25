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
