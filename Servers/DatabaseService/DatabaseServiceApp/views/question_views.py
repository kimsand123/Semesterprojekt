from django.core.serializers.json import DjangoJSONEncoder
from django.db import IntegrityError
from django.http import JsonResponse
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.utils import json

from DatabaseServiceApp.database_helpers.question_database_helper import QuestionDatabase
from DatabaseServiceApp.helper_methods import *
from DatabaseServiceApp.models import Question
from DatabaseServiceApp.views.default_views import bad_json, missing_property_in_json, wrong_property_type, \
    bad_or_missing_access_key

all_methods = ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'COPY', 'HEAD', 'OPTIONS', 'LINK', 'UNLINK', 'PURGE', 'LOCK',
               'UNLOCK', 'PROPFIND', 'VIEW']

__correct_question_json = {
    'question':
        {
            'question_text': 'What is the best programming language?',
            'correct_answer': 1,
            'answer_1': 'Python',
            'answer_2': 'Java',
            'answer_3': 'C#',
        }
}


# path: /questions/
@api_view(all_methods)
def questions(request):
    try:
        if not is_access_key_valid(request):
            return bad_or_missing_access_key(request)

        if request.method == 'GET':
            return __questions_get(request)

        elif request.method == 'POST':
            return __questions_post(request)
        else:
            return __bad_method(request, 'GET, POST')

    except IntegrityError as e:
        print('IntegrityError occurred: ' + e.__str__())
        json_data = {
            'requested-url': '[' + request.method + '] ' + request.get_full_path(),
            'error': e.__str__(),
        }
        return JsonResponse(data=json_data, status=status.HTTP_409_CONFLICT, safe=False, encoder=DjangoJSONEncoder)

    except JSONDecodeError as e:
        print('JSONDecodeError occurred: ' + e.__str__())
        return bad_json(request, __correct_question_json)

    except (AttributeError, KeyError) as e:
        print('AttributeError or KeyError occurred: ' + e.__str__())
        return bad_json(request, __correct_question_json)

    except (ValueError, TypeError) as e:
        print('ValueError or TypeError occurred: ' + e.__str__())
        return wrong_property_type(request, __correct_question_json)


# path: /questions/<int:question_id>/
@api_view(all_methods)
def single_question(request, question_id):
    try:
        if not is_access_key_valid(request):
            return bad_or_missing_access_key(request)

        if request.method == 'GET':
            return __single_question_get(request, question_id)

        elif request.method == 'PUT':
            return __single_question_put(request, question_id)

        elif request.method == 'DELETE':
            return __single_question_delete(request, question_id)
        else:
            return __bad_method(request, 'GET, PUT, DELETE')

    except JSONDecodeError as e:
        print('JSONDecodeError occurred: ' + e.__str__())
        return bad_json(request, __correct_question_json)

    except IntegrityError as e:
        print('IntegrityError occurred: ' + e.__str__())
        json_data = {
            'requested-url': '[' + request.method + '] ' + request.get_full_path(),
            'error': e.__str__(),
        }
        return JsonResponse(data=json_data, status=status.HTTP_409_CONFLICT, safe=False, encoder=DjangoJSONEncoder)

    except (Question.DoesNotExist, IndexError) as e:
        print('Question.DoesNotExist or IndexError occurred: ' + e.__str__())
        json_data = {
            'requested-url': '[' + request.method + '] ' + request.get_full_path(),
            'error': 'The question with id:\'' + question_id + '\' is not in the database',
        }
        return JsonResponse(data=json_data, status=status.HTTP_404_NOT_FOUND, safe=False, encoder=DjangoJSONEncoder)

    except (AttributeError, KeyError) as e:
        print('AttributeError or KeyError occurred: ' + e.__str__())
        return bad_json(request, __correct_question_json)

    except (ValueError, TypeError) as e:
        print('ValueError or TypeError occurred: ' + e.__str__())
        return wrong_property_type(request, __correct_question_json)


# Bad question path
@api_view(all_methods)
def questions_bad_path(request):
    print_origin(request, 'Questions - bad path')
    default_url = '/questions/'

    json_data = {
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'error': 'You have requested a wrong path.',
        'helper': 'Maybe you have forgotten a slash?',
        'questions endpoint': default_url,
        'single question endpoint': default_url + 's123456/'
    }
    return JsonResponse(data=json_data, status=status.HTTP_400_BAD_REQUEST, safe=False, encoder=DjangoJSONEncoder)


"""
-----------------------------
METHOD IMPLEMENTATIONS
-----------------------------
"""


# -----------------------------
# Bad method
# -----------------------------
def __bad_method(request, allowed_methods):
    print_origin(request, 'Questions - bad method')
    json_data = {
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'error': 'This method is not allowed here',
        'helper': 'Only the following methods allowed:[' + allowed_methods + ']',
    }
    return JsonResponse(data=json_data, status=status.HTTP_405_METHOD_NOT_ALLOWED, safe=False,
                        encoder=DjangoJSONEncoder)


# -----------------------------
# Questions GET
# -----------------------------
def __questions_get(request):
    print_origin(request, 'Questions')

    return_data = QuestionDatabase.get_all_return_serialized()

    json_data = {
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'questions': return_data,
    }
    return JsonResponse(data=json_data, status=status.HTTP_200_OK, safe=False, encoder=DjangoJSONEncoder)


# -----------------------------
# Questions POST
# -----------------------------
def __questions_post(request):
    print_origin(request, 'Questions')

    json_body = json.loads(request.body)

    # Create a database entry
    return_data = QuestionDatabase.create_return_serialized(json_body)

    # if it returns a string, send a missing property json back
    if isinstance(return_data, str):
        return missing_property_in_json(request, return_data, __correct_question_json)

    # Prepare jsonResponse data
    json_data = {
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'message': 'You have posted a new question',
        'question': return_data
    }
    return JsonResponse(data=json_data, status=status.HTTP_201_CREATED, safe=False, encoder=DjangoJSONEncoder)


# -----------------------------
# Single question GET
# -----------------------------
def __single_question_get(request, question_id):
    print_origin(request, 'Single question')

    return_data = QuestionDatabase.get_one_return_serialized(question_id)

    json_data = {
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'question': return_data
    }
    return JsonResponse(data=json_data, status=status.HTTP_200_OK, safe=False, encoder=DjangoJSONEncoder)


# -----------------------------
# Single question PUT
# -----------------------------
def __single_question_put(request, question_id):
    print_origin(request, 'Single question')

    json_body = json.loads(request.body)

    # Update a database entry
    return_data = QuestionDatabase.update_return_serialized(json_body, question_id)

    # if it returns a string, send a missing property json back
    if isinstance(return_data, str):
        return missing_property_in_json(request, return_data, __correct_question_json)

    # Prepare jsonResponse data
    json_data = {
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'message': 'You have changed question with id: \'' + question_id + '\'',
        'question': return_data,
    }
    return JsonResponse(data=json_data, status=status.HTTP_202_ACCEPTED, safe=False, encoder=DjangoJSONEncoder)


# -----------------------------
# Single question DELETE
# -----------------------------
def __single_question_delete(request, question_id):
    print_origin(request, 'Single question')

    return_data = QuestionDatabase.delete_return_serialized(question_id)

    json_data = {
        'requested-url': '[' + request.method + '] ' + request.get_full_path(),
        'deleted_question': return_data
    }
    return JsonResponse(data=json_data, status=status.HTTP_202_ACCEPTED, safe=False, encoder=DjangoJSONEncoder)
