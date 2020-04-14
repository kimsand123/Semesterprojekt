from django.db import models


class Player(models.Model):
    username = models.CharField(max_length=7, unique=True)
    email = models.CharField(max_length=50)
    first_name = models.CharField(max_length=40)
    last_name = models.CharField(max_length=40)
    study_programme = models.CharField(max_length=100)
    score = models.IntegerField()

    def __str__(self):
        return str(self.id) + ' - ' + \
               str(self.username) + ' - ' + \
               str(self.first_name) + ' - ' + \
               str(self.last_name[:1]) + '.'


class GamePlayer(models.Model):
    game_player_id = models.ForeignKey(Player,
                                       on_delete=models.CASCADE,
                                       to_field='id')
    game_progress = models.IntegerField()
    score = models.IntegerField()

    def __str__(self):
        return str(self.id) + ' - ' + \
               str(self.game_player_id) + ' - ' + \
               str(self.game_progress) + ' - ' + \
               str(self.score)


class GameRound(models.Model):
    time_spent = models.DecimalField(max_digits=20, decimal_places=1)
    score = models.IntegerField()

    def __str__(self):
        return str(self.id) + ' - ' + \
               str(self.time_spent) + ' - ' + \
               str(self.score)


class Game(models.Model):
    match_name = models.CharField(max_length=30)
    question_duration = models.DecimalField(max_digits=5, decimal_places=1)

    def __str__(self):
        return str(self.id) + ' - ' + \
               str(self.match_name) + ' - ' + \
               str(self.question_duration)


class Answer(models.Model):
    answer_text = models.CharField(max_length=100)

    def __str__(self):
        return str(self.id) + ' - ' + \
               str(self.answer_text)


class Question(models.Model):
    question_text = models.CharField(max_length=100)

    def __str__(self):
        return str(self.id) + ' - ' + \
               str(self.question_text)


class QuestionSet(models.Model):
    question_id = models.ForeignKey(Question,
                                    on_delete=models.CASCADE,
                                    to_field='id',
                                    related_name='question_set_id')
    answers_correct_id = models.ForeignKey(Answer,
                                           on_delete=models.CASCADE,
                                           to_field='id',
                                           related_name='question_set_correct')
    answers_1_id = models.ForeignKey(Answer,
                                     on_delete=models.CASCADE,
                                     to_field='id',
                                     related_name='question_set_1')
    answers_2_id = models.ForeignKey(Answer,
                                     on_delete=models.CASCADE,
                                     to_field='id',
                                     related_name='question_set_2')
    answers_3_id = models.ForeignKey(Answer,
                                     on_delete=models.CASCADE,
                                     to_field='id',
                                     related_name='question_set_3')

    def __str__(self):
        return str(self.id) + ' - ' + \
               str(self.question_id) + ' - ' + \
               str(self.answers_correct_id) + ' - ' + \
               str(self.answers_1_id) + ' - ' + \
               str(self.answers_2_id) + ' - ' + \
               str(self.answers_3_id)


class QuestionSetGame(models.Model):
    game_id = models.ForeignKey(Game, on_delete=models.CASCADE, to_field='id')
    question_set_id = models.ForeignKey(QuestionSet, on_delete=models.CASCADE, to_field='id')

    def __str__(self):
        return str(self.id) + ' - ' + \
               str(self.game_id) + ' - ' + \
               str(self.question_set_id)


class GamePlayerGame(models.Model):
    game_id = models.ForeignKey(Game, on_delete=models.CASCADE, to_field='id')
    game_player_status_id = models.ForeignKey(GamePlayer, on_delete=models.CASCADE, to_field='id')
    game_round_id = models.ForeignKey(GameRound, on_delete=models.CASCADE, to_field='id')

    def __str__(self):
        return str(self.id) + ' - ' + \
               str(self.game_id) + ' - ' + \
               str(self.game_player_status_id) + ' - ' + \
               str(self.game_round_id)


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
        return str(self.id) + ' - ' + \
               str(self.sender_player_id) + ' - ' + \
               str(self.receiver_player_id) + ' - ' + \
               str(self.game_id) + ' - ' + \
               str(self.accepted)

