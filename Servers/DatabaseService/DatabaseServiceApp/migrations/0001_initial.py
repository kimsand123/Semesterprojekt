# Generated by Django 3.0.5 on 2020-04-14 21:10

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Answer',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('answer_text', models.CharField(max_length=100)),
            ],
        ),
        migrations.CreateModel(
            name='Game',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('match_name', models.CharField(max_length=30)),
                ('question_duration', models.DecimalField(decimal_places=1, max_digits=5)),
            ],
        ),
        migrations.CreateModel(
            name='GamePlayer',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('game_progress', models.IntegerField()),
                ('score', models.IntegerField()),
            ],
        ),
        migrations.CreateModel(
            name='GameRound',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('time_spent', models.DecimalField(decimal_places=1, max_digits=20)),
                ('score', models.IntegerField()),
            ],
        ),
        migrations.CreateModel(
            name='Player',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('username', models.CharField(max_length=7, unique=True)),
                ('email', models.CharField(max_length=50)),
                ('first_name', models.CharField(max_length=40)),
                ('last_name', models.CharField(max_length=40)),
                ('study_programme', models.CharField(max_length=100)),
                ('score', models.IntegerField()),
            ],
        ),
        migrations.CreateModel(
            name='Question',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('question_text', models.CharField(max_length=100)),
            ],
        ),
        migrations.CreateModel(
            name='QuestionSet',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('answers_1_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='question_set_1', to='DatabaseServiceApp.Answer')),
                ('answers_2_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='question_set_2', to='DatabaseServiceApp.Answer')),
                ('answers_3_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='question_set_3', to='DatabaseServiceApp.Answer')),
                ('answers_correct_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='question_set_correct', to='DatabaseServiceApp.Answer')),
                ('question_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='question_set_id', to='DatabaseServiceApp.Question')),
            ],
        ),
        migrations.CreateModel(
            name='QuestionSetGame',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('game_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='DatabaseServiceApp.Game')),
                ('question_set_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='DatabaseServiceApp.QuestionSet')),
            ],
        ),
        migrations.CreateModel(
            name='Invite',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('accepted', models.BooleanField(default=False)),
                ('game_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='DatabaseServiceApp.Game')),
                ('receiver_player_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='invite_receiver', to='DatabaseServiceApp.Player')),
                ('sender_player_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='invite_sender', to='DatabaseServiceApp.Player')),
            ],
        ),
        migrations.CreateModel(
            name='GamePlayerGame',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('game_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='DatabaseServiceApp.Game')),
                ('game_player_status_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='DatabaseServiceApp.GamePlayer')),
                ('game_round_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='DatabaseServiceApp.GameRound')),
            ],
        ),
        migrations.AddField(
            model_name='gameplayer',
            name='game_player_id',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='DatabaseServiceApp.Player'),
        ),
    ]
