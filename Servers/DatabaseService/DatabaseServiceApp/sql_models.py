import json

from django.db import models

from DatabaseServiceApp.helper_methods import is_key_in_dict

"""
***************************
Models for SQL
***************************
"""


# ***
# Player
# ***
class Player(models.Model):
    username = models.CharField(max_length=7, unique=True)
    email = models.CharField(max_length=50)
    first_name = models.CharField(max_length=40)
    last_name = models.CharField(max_length=40)
    study_programme = models.CharField(max_length=100)
    high_score = models.IntegerField(default=0)

    def __str__(self):
        return str(self.id) + '(' + \
               str(self.username) + ', ' + \
               str(self.first_name) + ', ' + \
               str(self.last_name[:1]) + '.)'

    def from__dict(self, player_dict):
        if is_key_in_dict(player_dict, 'username'):
            self.username = player_dict['username']

        if is_key_in_dict(player_dict, 'email'):
            self.email = player_dict['email']

        if is_key_in_dict(player_dict, 'first_name'):
            self.first_name = player_dict['first_name']

        if is_key_in_dict(player_dict, 'last_name'):
            self.last_name = player_dict['last_name']

        if is_key_in_dict(player_dict, 'study_programme'):
            self.study_programme = player_dict['study_programme']

        if is_key_in_dict(player_dict, 'high_score'):
            self.high_score = player_dict['high_score']

        return self


# ***
# Game
# ***
class Game(models.Model):
    match_name = models.CharField(max_length=30)
    question_duration = models.DecimalField(max_digits=5, decimal_places=1)

    def __str__(self):
        return str(self.id) + '(' + \
               str(self.match_name) + ', ' + \
               str(self.question_duration) + ')'


# ***
# Answer
# ***
class Answer(models.Model):
    answer_text = models.CharField(max_length=100)

    def __str__(self):
        return str(self.id) + '(' + \
               str(self.answer_text) + ')'


# ***
# Question
# ***
class Question(models.Model):
    question_text = models.CharField(max_length=100)
    answers_correct_id = models.ForeignKey(Answer,
                                           on_delete=models.CASCADE,
                                           to_field='id',
                                           related_name='question_answers_correct_id')
    answers_1_id = models.ForeignKey(Answer,
                                     on_delete=models.CASCADE,
                                     to_field='id',
                                     related_name='question_answers_1_id')
    answers_2_id = models.ForeignKey(Answer,
                                     on_delete=models.CASCADE,
                                     to_field='id',
                                     related_name='question_answers_2_id')
    answers_3_id = models.ForeignKey(Answer,
                                     on_delete=models.CASCADE,
                                     to_field='id',
                                     related_name='question_answers_3_id')

    def __str__(self):
        return str(self.id) + '(' + \
               str(self.question_text) + ', ' + \
               str(self.answers_correct_id) + ', ' + \
               str(self.answers_1_id) + ', ' + \
               str(self.answers_2_id) + ', ' + \
               str(self.answers_3_id) + ')'


# ***
# GameQuestion
# ***
class GameQuestion(models.Model):
    game_id = models.ForeignKey(Game, on_delete=models.CASCADE, to_field='id')
    question_id = models.ForeignKey(Question, on_delete=models.CASCADE, to_field='id')

    def __str__(self):
        return str(self.id) + '(' + \
               str(self.game_id) + ', ' + \
               str(self.question_id) + ')'


# ***
# GamePlayer
# ***
class GamePlayer(models.Model):
    player_id = models.ForeignKey(Player,
                                  on_delete=models.CASCADE,
                                  to_field='id')
    game_progress = models.IntegerField()
    score = models.IntegerField()

    def __str__(self):
        return str(self.id) + '(' + \
               str(self.player_id) + ' ,' + \
               str(self.game_progress) + ' - ' + \
               str(self.score) + ')'


# ***
# GameRound
# ***
class GameRound(models.Model):
    time_spent = models.DecimalField(max_digits=20, decimal_places=1)
    score = models.IntegerField()

    def __str__(self):
        return str(self.id) + '(' + \
               str(self.time_spent) + ', ' + \
               str(self.score) + ')'


# ***
# GamePlayerRound
# ***
class GamePlayerRound(models.Model):
    game_id = models.ForeignKey(Game, on_delete=models.CASCADE, to_field='id')
    game_player_id = models.ForeignKey(GamePlayer, on_delete=models.CASCADE, to_field='id')
    game_round_id = models.ForeignKey(GameRound, on_delete=models.CASCADE, to_field='id')

    def __str__(self):
        return str(self.id) + '(' + \
               str(self.game_id) + ', ' + \
               str(self.game_player_id) + ', ' + \
               str(self.game_round_id) + ')'


# ***
# Invite
# ***
class Invite(models.Model):
    sender_player_id = models.ForeignKey(Player,
                                         on_delete=models.CASCADE,
                                         to_field='id',
                                         related_name='invite_sender')
    receiver_player_id = models.ForeignKey(Player,
                                           on_delete=models.CASCADE,
                                           to_field='id',
                                           related_name='invite_receiver')
    game_id = models.ForeignKey(Game, on_delete=models.CASCADE)
    accepted = models.BooleanField(default=False)

    def __str__(self):
        return str(self.id) + '(' + \
               str(self.sender_player_id) + ', ' + \
               str(self.receiver_player_id) + ', ' + \
               str(self.game_id) + ', ' + \
               str(self.accepted) + ')'
