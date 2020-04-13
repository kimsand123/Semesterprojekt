import datetime

from django.db import models

"""
class Question(models.Model):
    question_text = models.CharField(max_length=200)
    pub_date = models.DateTimeField('date published')
    
    def was_published_recently(self):
        now = timezone.now()
        return now - datetime.timedelta(days=1) <= self.pub_date <= now

    was_published_recently.admin_order_field = 'pub_date'
    was_published_recently.boolean = True
    was_published_recently.short_description = 'Published recently?'

    def __str__(self):
        return self.question_text


class Choice(models.Model):
    question = models.ForeignKey(Question, on_delete=models.CASCADE)
    choice_text = models.CharField(max_length=200)
    votes = models.IntegerField(default=0)

    def __str__(self):
        return self.choice_text
"""


class Player(models.Model):
    campus_id = models.CharField(max_length=7, unique=True)
    email = models.CharField(max_length=50)
    first_name = models.CharField(max_length=40)
    last_name = models.CharField(max_length=40)
    study_programme = models.CharField(max_length=100)
    score = models.DecimalField(max_digits=20, decimal_places=1, default=0)

    def __str__(self):
        return self.campus_id + ' - ' + self.first_name + ' ' + self.last_name[:1] + '.'


class GameHistory(models.Model):
    time_spent = models.DecimalField(max_digits=20, decimal_places=1)
    score = models.DecimalField(max_digits=20, decimal_places=1)
    handicap = models.DecimalField(max_digits=20, decimal_places=1)


class GameUserStatus(models.Model):
    game_progress = models.IntegerField()
    score = models.DecimalField(max_digits=1, decimal_places=1)
    game_history_id = models.ForeignKey(GameHistory, on_delete=models.CASCADE, to_field='id')


class GameUserMap(models.Model):
    game_player = models.ForeignKey(Player, on_delete=models.CASCADE, to_field='id')
    game_user_status = models.ForeignKey(GameUserStatus, on_delete=models.CASCADE, to_field='id')


class Answer(models.Model):
    answer_text = models.CharField(max_length=100)


class Question(models.Model):
    question_text = models.CharField(max_length=100)


class QuestionAnswers(models.Model):
    question_id = models.ForeignKey(Question, on_delete=models.CASCADE, to_field='id')
    answer_id = models.ForeignKey(Answer, on_delete=models.CASCADE, to_field='id')


class QuestionSet(models.Model):
    set_id = models.IntegerField()
    question_answers_id = models.ForeignKey(QuestionAnswers, on_delete=models.CASCADE, to_field='id')


class Game(models.Model):
    game_match_name = models.CharField(max_length=30)
    question_duration = models.DecimalField(max_digits=2, decimal_places=1)
    question_set_id = models.ForeignKey(QuestionSet, on_delete=models.CASCADE, to_field='id')
    game_users_id = models.ForeignKey(GameUserMap, on_delete=models.CASCADE, to_field='id')


class InviteGameParam(models.Model):
    question_duration = models.DecimalField(max_digits=2, decimal_places=1)


class Invite(models.Model):
    sender_player_id = models.ForeignKey(Player,
                                         on_delete=models.CASCADE,
                                         to_field='campus_id',
                                         related_name='invite_sender')
    receiver_player_id = models.ForeignKey(Player,
                                           on_delete=models.CASCADE,
                                           to_field='campus_id',
                                           related_name='invite_receiver')
    invite_game_params_id = models.ForeignKey(InviteGameParam, on_delete=models.CASCADE)

