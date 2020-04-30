from django.db import models

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
    email = models.CharField(max_length=50, unique=True)
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
        if 'username' in player_dict:
            self.username = player_dict['username']

        if 'email' in player_dict:
            self.email = player_dict['email']

        if 'first_name' in player_dict:
            self.first_name = player_dict['first_name']

        if 'last_name' in player_dict:
            self.last_name = player_dict['last_name']

        if 'study_programme' in player_dict:
            self.study_programme = player_dict['study_programme']

        if 'high_score' in player_dict:
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
# Question
# ***
class Question(models.Model):
    question_text = models.CharField(max_length=100, unique=True)
    correct_answer = models.IntegerField()
    answer_1 = models.CharField(max_length=100)
    answer_2 = models.CharField(max_length=100)
    answer_3 = models.CharField(max_length=100)

    def __str__(self):
        return str(self.id) + '(' + \
               str(self.question_text) + ', ' + \
               str(self.correct_answer) + ', ' + \
               str(self.answer_1) + ', ' + \
               str(self.answer_2) + ', ' + \
               str(self.answer_3) + ')'


# ***
# GameQuestion
# ***
class GameQuestion(models.Model):
    game = models.ForeignKey(Game, on_delete=models.CASCADE, to_field='id')
    question = models.ForeignKey(Question, on_delete=models.CASCADE, to_field='id')

    def __str__(self):
        return str(self.id) + '(' + \
               str(self.game) + ', ' + \
               str(self.question) + ')'


# ***
# GamePlayer
# ***
class GamePlayer(models.Model):
    game = models.ForeignKey(Game, on_delete=models.CASCADE, to_field='id')
    player = models.ForeignKey(Player,
                               on_delete=models.CASCADE,
                               to_field='id')
    game_progress = models.IntegerField()
    score = models.IntegerField()

    def __str__(self):
        return str(self.id) + '(' + \
               str(self.game) + ' ,' + \
               str(self.player) + ' ,' + \
               str(self.game_progress) + ' - ' + \
               str(self.score) + ')'


# ***
# GameRound
# ***
class GameRound(models.Model):
    game_player = models.ForeignKey(GamePlayer, on_delete=models.CASCADE, to_field='id')
    time_spent = models.DecimalField(max_digits=20, decimal_places=1)
    score = models.IntegerField()

    def __str__(self):
        return str(self.id) + '(' + \
               str(self.game_player) + ', ' + \
               str(self.time_spent) + ', ' + \
               str(self.score) + ')'


# ***
# Invite
# ***
class Invite(models.Model):
    sender_player = models.ForeignKey(Player,
                                      on_delete=models.CASCADE,
                                      to_field='id',
                                      related_name='invite_sender')
    receiver_player = models.ForeignKey(Player,
                                        on_delete=models.CASCADE,
                                        to_field='id',
                                        related_name='invite_receiver')
    game = models.ForeignKey(Game, on_delete=models.CASCADE)
    accepted = models.BooleanField(default=False)

    def __str__(self):
        return str(self.id) + '(' + \
               str(self.sender_player) + ', ' + \
               str(self.receiver_player) + ', ' + \
               str(self.game) + ', ' + \
               str(self.accepted) + ')'
