import json

import requests
from pip._vendor.distlib.compat import raw_input


def main():
    print("* Welcome to this simple AuthTester")
    username = raw_input("* Enter username\n")
    password = raw_input("* Enter password\n")

    user = {"username": username, "password": password}

    resp = requests.post(url='http://87.61.85.141:9800/login/', json=user)
    if resp.status_code == 200:
        user_json = json.loads(resp.content)

        print("* You have logged in with the following user:")
        for player_info in user_json:
            print("* " + player_info + ": " + user_json[player_info].__str__())

    elif resp.status_code == 401:
        print("**** Wrong username or password")
        exit(0)
    else:
        print("**** Something went wrong, please try again")
        exit(0)


if __name__ == "__main__":
    main()
