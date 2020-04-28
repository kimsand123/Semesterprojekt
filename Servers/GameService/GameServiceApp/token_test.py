from GameServiceApp.active_player_list import *
import datetime


def run_token_test():
    test_token = {"user_token": "TESTTOKEN", "player_id": 1000, "time_stamp": datetime.now()}

    add_token("TESTTOKEN", 1000)

    user_token, player_id, time_stamp = get_token("TESTTOKEN")
    if user_token != None:
        print("add_token worked")
    else:
        print("add_token didn't worked")

    if token_status("TESTTOKEN"):
        print("token_status worked")
    else:
        print("token_status didn't work")

    user_token, player_id, time_stamp = get_token("TESTTOKEN")
    if user_token != None:
        print("Token didn't exist")
    else:
        ts1 = time_stamp
        print("timestamp before refresh: " + str(time_stamp))

    refresh_token("TESTTOKEN")

    if user_token != None:
        print("Token didn't exist")
    else:
        ts2 = time_stamp
        print("timestamp before refresh: " + str(time_stamp))

    if ts1 != ts2:
        print("refresh worked. Timestamp 1: " + str(ts1) + " vs Timestamp 2: " + str(ts2))

    print("Test done")
