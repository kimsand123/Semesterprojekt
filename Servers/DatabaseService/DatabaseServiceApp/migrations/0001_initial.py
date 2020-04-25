# Generated by Django 3.0.5 on 2020-04-25 14:34

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
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
                ('email', models.CharField(max_length=50, unique=True)),
                ('first_name', models.CharField(max_length=40)),
                ('last_name', models.CharField(max_length=40)),
                ('study_programme', models.CharField(max_length=100)),
                ('high_score', models.IntegerField(default=0)),
            ],
        ),
        migrations.CreateModel(
            name='Question',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('question_text', models.CharField(max_length=100, unique=True)),
                ('correct_answer', models.IntegerField()),
                ('answer_1', models.CharField(max_length=100)),
                ('answer_2', models.CharField(max_length=100)),
                ('answer_3', models.CharField(max_length=100)),
            ],
        ),
        migrations.CreateModel(
            name='Invite',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('accepted', models.BooleanField(default=False)),
                ('game', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='DatabaseServiceApp.Game')),
                ('receiver_player', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='invite_receiver', to='DatabaseServiceApp.Player')),
                ('sender_player', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='invite_sender', to='DatabaseServiceApp.Player')),
            ],
        ),
        migrations.CreateModel(
            name='GameQuestion',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('game', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='DatabaseServiceApp.Game')),
                ('question', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='DatabaseServiceApp.Question')),
            ],
        ),
        migrations.CreateModel(
            name='GamePlayerRound',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('game', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='DatabaseServiceApp.Game')),
                ('game_player', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='DatabaseServiceApp.GamePlayer')),
                ('game_round', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='DatabaseServiceApp.GameRound')),
            ],
        ),
        migrations.AddField(
            model_name='gameplayer',
            name='player',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='DatabaseServiceApp.Player'),
        ),
    ]
