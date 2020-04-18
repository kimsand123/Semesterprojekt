import json

from django.core.serializers.json import Serializer


class PlayerSerializer(Serializer):
    def get_dump_object(self, obj):
        mapped_object = {
            'id': obj.id,
            'username': obj.username,
            'email': obj.email,
            'first_name': obj.first_name,
            'last_name': obj.last_name,
            'study_programme': obj.study_programme,
            'high_score': obj.high_score
        }

        return mapped_object


class InviteSerializer(Serializer):
    def get_dump_object(self, obj):
        player_serializer = PlayerSerializer()
        game_serializer = GameSerializer()

        sender_player = json.loads(player_serializer.serialize([obj.sender_player]))[0]
        receiver_player = json.loads(player_serializer.serialize([obj.receiver_player]))[0]
        game = json.loads(game_serializer.serialize([obj.game]))[0]

        mapped_object = {
            'id': obj.id,
            'sender_player': sender_player,
            'receiver_player': receiver_player,
            'game': game,
            'accepted': obj.accepted,
        }

        return mapped_object


class GameSerializer(Serializer):
    def get_dump_object(self, obj):
        mapped_object = {
            'id': obj.id,
            'match_name': obj.match_name,
            'question_duration': obj.question_duration,
        }

        return mapped_object


class GamePlayerSerializer(Serializer):
    def get_dump_object(self, obj):
        player_serializer = PlayerSerializer()
        player = json.loads(player_serializer.serialize([obj.player]))[0]

        mapped_object = {
            'player': player,
            'game_progress': obj.game_progress,
            'score': obj.score,
        }

        return mapped_object


class GameRoundSerializer(Serializer):
    def get_dump_object(self, obj):
        mapped_object = {
            'id': obj.id,
            'time_spent': obj.time_spent,
            'score': obj.score,
        }

        return mapped_object


class GamePlayerRoundSerializer(Serializer):
    def get_dump_object(self, obj):

        game_player_serializer = GamePlayerSerializer()
        game_player = json.loads(game_player_serializer.serialize([obj.game_player]))[0]

        game_round_serializer = GameRoundSerializer()
        game_round = json.loads(game_round_serializer.serialize([obj.game_round]))[0]

        mapped_object = {
            'id':obj.id,
            'game_player': game_player,
            'game_round': game_round,

        }

        return mapped_object


class GameQuestionSerializer(Serializer):
    def get_dump_object(self, obj):
        question_serializer = QuestionSerializer()
        question = json.loads(question_serializer.serialize([obj.question]))[0]

        mapped_object = {
            obj.question_id: question,
        }

        return mapped_object


class QuestionSerializer(Serializer):
    def get_dump_object(self, obj):
        answer_serializer = AnswerSerializer()
        answers_correct = json.loads(answer_serializer.serialize([obj.answers_correct]))[0]
        answers_1 = json.loads(answer_serializer.serialize([obj.answers_1]))[0]
        answers_2 = json.loads(answer_serializer.serialize([obj.answers_2]))[0]
        answers_3 = json.loads(answer_serializer.serialize([obj.answers_3]))[0]

        mapped_object = {
            'question_text': obj.question_text,
            'answers_correct': answers_correct,
            'answers_1': answers_1,
            'answers_2': answers_2,
            'answers_3': answers_3,
        }

        return mapped_object


class AnswerSerializer(Serializer):
    def get_dump_object(self, obj):
        mapped_object = {
            'id': obj.id,
            'answer_text': obj.answer_text,
        }

        return mapped_object
