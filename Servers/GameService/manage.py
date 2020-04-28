#!/usr/bin/env python
"""Django's command-line utility for administrative tasks."""
import os
import sys
from GameServiceApp import token_test

def main():
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'GameService.settings')
    try:
        from django.core.management import execute_from_command_line
    except ImportError as exc:
        raise ImportError(
            "Couldn't import Django. Are you sure it's installed and "
            "available on your PYTHONPATH environment variable? Did you "
            "forget to activate a virtual environment?"
        ) from exc
    execute_from_command_line(sys.argv)


if __name__ == '__main__':
    main()


"""
#TODO: Find solution
def check_token_list_for_old_tokens():
    while True:
        print("token_user_list before check: " + str(token_user_list))
        for token in token_user_list:
            now_time = datetime.now()
            token_time = datetime(token['time_stamp'])
            if now_time.minute < token_time.minute + MAX_TOKEN_AGE_MIN:
                token_user_list.remove({"user_token": token})
        print("token_user_list after check and removal: " + str(token_user_list))
        time.sleep(FREQUENCY_OF_TOKEN_LIST_CHECK_SEC)


# def main():
#    print("start token thread")
#    _thread.start_new_thread(check_token_list_for_old_tokens())

# main()
"""