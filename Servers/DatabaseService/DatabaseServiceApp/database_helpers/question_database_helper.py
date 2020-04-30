import json

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
        if 'question' not in json_body:
            return 'question'

        json_question = json_body['question']

        # Check for required attributes in the question object
        if 'question_text' not in json_question:
            return 'question_text'
        elif 'correct_answer' not in json_question:
            return 'correct_answer'
        elif 'answer_1' not in json_question:
            return 'answer_1'
        elif 'answer_2' not in json_question:
            return 'answer_2'
        elif 'answer_3' not in json_question:
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
        if 'question' not in json_body:
            return 'question'

        json_question = json_body['question']

        question = QuestionDatabase.get_one(question_id)

        # Change only the provided attributes
        if 'question_text' in json_question:
            question.question_text = json_question['question_text']

        if 'correct_answer' in json_question:
            question.correct_answer = json_question['correct_answer']

        if 'answer_1' in json_question:
            question.answer_1 = json_question['answer_1']

        if 'answer_2' in json_question:
            question.answer_2 = json_question['answer_2']

        if 'answer_3' in json_question:
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
