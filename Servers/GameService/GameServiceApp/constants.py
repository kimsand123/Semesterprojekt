import os

from GameService import settings

AUTH_SERVICE_ACCESS_KEY = "HBdjm4VDLxn8mU2Eh7EzwNdhAEYp7bm9HvgwEJVGeM6NaBFvFFS48qbSHUYKLkuZPRWKxvGJsu4RewuuR6SVEEbH5aUqjD7H8wMeEPBd5d4G8UfB7QxhuTPPF8KKZg53zvUdv63ravcBAzdgPRbxcVu7pb6NPRfVLf3fFznvCX5ey2by6kGe3HrZX6kBTsJxTS6cL4KwkQDaN5YTq5jzQrQ4wLaXBYzx9y4w5sXdfkhLWuCL5wdFMtgbd8cNTemR"
MAX_TOKEN_AGE_MIN = 30
FREQUENCY_OF_TOKEN_LIST_CHECK_SEC = 60


def database_service_url():
    compose_env_url = os.getenv('DC_DS')

    db_prod_url = "https://api.dinodev.dk"
    db_prod_full_url = db_prod_url

    db_test_url = "http://0.0.0.0"
    db_test_port = "9600"
    db_test_full_url = db_test_url + ":" + db_test_port

    db_compose_port = "9600"
    db_compose_full_url = "http://" + str(compose_env_url) + ":"  + db_compose_port

    if compose_env_url is not None:
        print("Using database: " + db_compose_full_url)
        return db_compose_full_url
    elif settings.DEBUG or settings.FORCE_PRODUCTION_SERVER:
        print("Using database: " + db_test_full_url)
        return db_test_full_url
    else:
        print("Using database: " + db_prod_full_url)
        return db_prod_full_url
