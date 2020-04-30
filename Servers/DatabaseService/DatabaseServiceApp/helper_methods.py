from json import JSONDecodeError


def is_access_key_valid(request):
    try:
        # Early exit on missing game in json
        if 'Authorization' not in request.headers:
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
          ', Agent: ' + request.META['HTTP_USER_AGENT'] +
          ')')
