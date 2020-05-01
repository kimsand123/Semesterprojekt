from django.test import TestCase

# Create your tests here.
from GameServiceApp.active_player_list import add_token, token_status, get_token, refresh_token


def run_token_test():
    add_token("TESTTOKEN", 1000)

    user_token, player_id, time_stamp = get_token("TESTTOKEN")
    if user_token is not None:
        print("add_token worked")
    else:
        print("add_token didn't worked")

    if token_status("TESTTOKEN"):
        print("token_status worked")
    else:
        print("token_status didn't work")

    user_token, player_id, time_stamp = get_token("TESTTOKEN")
    if user_token is None:
        print("Token didn't exist")
    else:
        ts1 = time_stamp
        print("timestamp before refresh: " + str(time_stamp))

    refresh_token("TESTTOKEN")

    user_token, player_id, time_stamp = get_token("TESTTOKEN")
    if user_token is None:
        print("Token didn't exist")
    else:
        ts2 = time_stamp
        print("timestamp before refresh: " + str(time_stamp))

    if ts1 != ts2:
        print("refresh worked. Timestamp 1: " + str(ts1) + " vs Timestamp 2: " + str(ts2))

    print("Test done")