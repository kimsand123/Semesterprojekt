import json

from DatabaseServiceApp.helper_methods import is_key_in_dict
from DatabaseServiceApp.models import Question
from DatabaseServiceApp.serializers import QuestionSerializer


class QuestionDatabase:

    # -----------
    #   Get all
    # -----------
    @staticmethod
    def get_all():
        questions_query = Question.objects.all()
        return questions_query

    @staticmethod
    def get_all_return_serialized():
        questions_query = QuestionDatabase.get_all()
        serializer = QuestionSerializer()
        return_data = json.loads(serializer.serialize(questions_query).__str__())
        return return_data

    # -----------
    #   Get one
    # -----------
    @staticmethod
    def get_one(question_id):
        return Question.objects.get(id=question_id)

    @staticmethod
    def get_one_return_serialized(question_id):
        question_query = QuestionDatabase.get_one(question_id)

        serializer = QuestionSerializer()
        serialize_object = json.loads(serializer.serialize([question_query]).__str__())

        return_data = serialize_object[0]

        return return_data

    # -----------
    #   Create one
    # -----------
    @staticmethod
    def create(json_body):
        # Early exit on missing question in json
        if not is_key_in_dict(json_body, 'question'):
            return 'question'

        json_question = json_body['question']

        # Check for required attributes in the question object
        if not is_key_in_dict(json_question, 'question_text'):
            return 'question_text'
        elif not is_key_in_dict(json_question, 'correct_answer'):
            return 'correct_answer'
        elif not is_key_in_dict(json_question, 'answer_1'):
            return 'answer_1'
        elif not is_key_in_dict(json_question, 'answer_2'):
            return 'answer_2'
        elif not is_key_in_dict(json_question, 'answer_3'):
            return 'answer_3'

        # Save the object in database
        question = Question(
            question_text=json_question['question_text'],
            correct_answer=json_question['correct_answer'],
            answer_1=json_question['answer_1'],
            answer_2=json_question['answer_2'],
            answer_3=json_question['answer_3'])
        question.save()

        return question

    @staticmethod
    def create_return_serialized(json_body):
        question = QuestionDatabase.create(json_body)

        # if it returns a string, return the string
        if isinstance(question, str):
            return question

        # Serialize the object
        serializer = QuestionSerializer()
        serialize_object = json.loads(serializer.serialize([question]).__str__())

        return_data = serialize_object[0]

        return return_data

    # -----------
    #   Update one
    # -----------
    @staticmethod
    def update(json_body, question_id):
        # Early exit on missing question in json
        if not is_key_in_dict(json_body, 'question'):
            return 'question'

        json_question = json_body['question']

        question = QuestionDatabase.get_one(question_id)

        # Change only the provided attributes
        if is_key_in_dict(json_question, 'question_text'):
            question.question_text = json_question['question_text']

        if is_key_in_dict(json_question, 'correct_answer'):
            question.correct_answer = json_question['correct_answer']

        if is_key_in_dict(json_question, 'answer_1'):
            question.answer_1 = json_question['answer_1']

        if is_key_in_dict(json_question, 'answer_2'):
            question.answer_2 = json_question['answer_2']

        if is_key_in_dict(json_question, 'answer_3'):
            question.answer_3 = json_question['answer_3']

        question.save()

        return question

    @staticmethod
    def update_return_serialized(json_body, question_id):
        question = QuestionDatabase.update(json_body, question_id)

        # if it returns a string, return the string
        if isinstance(question, str):
            return question

        # Serialize the object
        serializer = QuestionSerializer()
        serialize_object = json.loads(serializer.serialize([question]).__str__())

        return_data = serialize_object[0]

        return return_data

    # -----------
    #   Delete one
    # -----------
    @staticmethod
    def delete(question_id):
        question = Question.objects.get(id=question_id)
        Question.objects.get(id=question_id).delete()
        return question

    @staticmethod
    def delete_return_serialized(question_id):
        question = QuestionDatabase.delete(question_id)

        # if it returns a string, return the string
        if isinstance(question, str):
            return question

        # Serialize the object
        serializer = QuestionSerializer()
        serialize_object = json.loads(serializer.serialize([question]).__str__())

        return_data = serialize_object[0]

        return return_data
