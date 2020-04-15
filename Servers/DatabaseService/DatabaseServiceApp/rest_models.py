from django.db import models

"""
***************************
Models for REST
***************************
"""


# **
# RestPlayer
# ***
class RestPlayer(models.Model):
    username = models.CharField(max_length=7, unique=True)
    email = models.CharField(max_length=50)
    first_name = models.CharField(max_length=40)
    last_name = models.CharField(max_length=40)
    study_programme = models.CharField(max_length=100)
    score = models.IntegerField(default=0)

    def __str__(self):
        return str(self.id) + '(' + \
               str(self.username) + ', ' + \
               str(self.first_name) + ', ' + \
               str(self.last_name[:1]) + '.)'


# ***
# RestAnswer
# ***
class RestAnswer(models.Model):
    answer_text = models.CharField(max_length=100)

    def __str__(self):
        return str(self.id) + '(' + \
               str(self.answer_text) + ')'


# ***
# RestQuestion
# ***
class RestQuestion(models.Model):
    question_text = models.CharField(max_length=100)
    answers_correct = RestAnswer
    answers_1 = RestAnswer
    answers_2 = RestAnswer
    answers_3 = RestAnswer

    def __str__(self):
        return str(self.id) + '(' + \
               str(self.question_text) + ', ' + \
               str(self.answers_correct) + ', ' + \
               str(self.answers_1) + ', ' + \
               str(self.answers_2) + ', ' + \
               str(self.answers_3) + ')'


# ***
# RestGamePlayer
# ***
class RestGamePlayer(models.Model):
    player = RestPlayer
    game_progress = models.IntegerField()
    score = models.IntegerField()

    def __str__(self):
        return str(self.id) + '(' + \
               str(self.player) + ' ,' + \
               str(self.game_progress) + ' - ' + \
               str(self.score) + ')'


# ***
# RestGameRound
# ***
class RestGameRound(models.Model):
    time_spent = models.DecimalField(max_digits=20, decimal_places=1)
    score = models.IntegerField()

    def __str__(self):
        return str(self.id) + '(' + \
               str(self.time_spent) + ', ' + \
               str(self.score) + ')'


# ***
# RestGame
# ***
class RestGame(models.Model):
    match_name = models.CharField(max_length=30)
    question_duration = models.DecimalField(max_digits=5, decimal_places=1)
    questions = []  # Of RestQuestion
    player_status = {RestGamePlayer: RestGameRound}  # Of RestGamePlayer : RestGameRound

    def __str__(self):
        return str(self.id) + '(' + \
               str(self.match_name) + ', ' + \
               str(self.question_duration) + ')'


# ***
# RestInvite
# ***
class RestInvite(models.Model):
    sender_player = RestPlayer
    receiver_player = RestPlayer
    game = RestGame
    accepted = models.BooleanField(default=False)

    def __str__(self):
        return str(self.id) + '(' + \
               str(self.sender_player) + ', ' + \
               str(self.receiver_player) + ', ' + \
               str(self.game) + ', ' + \
               str(self.accepted) + ')'