from django.urls import path, re_path

from .views import default_views, game_views, invite_views, player_views, question_views

urlpatterns = [
    # Players
    path('players/', player_views.players),
    path('players/<str:player_id>/', player_views.single_player),

    # Invites
    path('invites/', invite_views.invites),
    path('invites/<str:invite_id>/', invite_views.single_invite),

    # Games
    path('games/', game_views.games),
    path('games/<str:game_id>/player-status/game-round/', game_views.single_game_player_status_game_round),
    path('games/<str:game_id>/', game_views.single_game),

    # Questions
    path('questions/', question_views.questions),
    path('questions/<str:question_id>/', question_views.single_question),

    # Other paths
    path('', default_views.welcome),
    re_path(r'players/?/', player_views.players_bad_path),
    re_path(r'games/?/', game_views.games_bad_path),
    re_path(r'invites/?/', invite_views.invites_bad_path),
    re_path(r'questions/?/', question_views.questions_bad_path),
    re_path(r'$', default_views.bad_path),
]


