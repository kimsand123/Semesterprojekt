from GameServiceApp.active_player_list import *
from datetime import *


def run_token_test():

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
    if user_token == None:
        print("Token didn't exist")
    else:
        ts1 = time_stamp
        print("timestamp before refresh: " + str(time_stamp))

        token_status("TESTTOKEN")

        user_token, player_id, time_stamp = get_token("TESTTOKEN")
        ts2 = time_stamp
        print("timestamp before refresh: " + str(time_stamp))

        if ts1 != ts2:
            print("refresh worked. Timestamp 1: " + str(ts1) + " vs Timestamp 2: " + str(ts2))

    token_player_list.append({"user_token": "TEST2", "time_stamp": str(datetime.now()- timedelta(minutes=40)), "player_id": 2000})
    user_token, player_id, time_stamp = get_token("TEST2")
    if user_token != None:
        print("old token appended")
    token_status("TEST2")
    user_token, player_id, time_stamp = get_token("TEST2")
    if user_token == None:
        print("delete old token worked")

    print("Test done")
