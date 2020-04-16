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


class Game(Serializer):
    def get_dump_object(self, obj):
        mapped_object = {
            'id': obj.id,
            'match_name': obj.match_name,
            'question_duration': obj.question_duration,
        }

        return mapped_object


class GamePlayer(Serializer):
    def get_dump_object(self, obj):
        mapped_object = {
            'id': obj.id,
            'player_id': obj.player_id,
            'game_progress': obj.game_progress,
            'score': obj.score,
        }

        return mapped_object


class GameRound(Serializer):
    def get_dump_object(self, obj):
        mapped_object = {
            'id': obj.id,
            'time_spent': obj.time_spent,
            'score': obj.score,
        }

        return mapped_object

class GamePlayerRound(Serializer):
    def get_dump_object(self, obj):
        mapped_object = {
            'id': obj.id,
            'game_id': obj.game_id,
            'game_player_id': obj.game_player_id,
            'game_round_id': obj.game_round_id,
        }

        return mapped_object


class GameQuestion(Serializer):
    def get_dump_object(self, obj):
        mapped_object = {
            'id': obj.id,
            'game_id': obj.game_id,
            'question_id': obj.question_id,
        }

        return mapped_object

class RestGame(Serializer):
    def get_dump_object(self, obj):
        mapped_object = {
            'match_name': obj.match_name,
            'question_duration': obj.question_duration,
            'questions': obj.questions,
            'player_status': obj.player_status,
        }

        return mapped_object