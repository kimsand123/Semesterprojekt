from django.urls import path, re_path

from .views import default_views, game_views, invite_views, player_views

urlpatterns = [
    # Players
    path('players/', player_views.players),
    path('players/<str:id>/', player_views.single_player),

    # Invites
    path('invites/', invite_views.invites),
    path('invites/<str:id>/', invite_views.single_invite),

    # Game
    path('games/', game_views.games),
    path('games/<str:id>/', game_views.single_game),

    # Other paths
    path('', default_views.welcome),
    re_path(r'$', default_views.bad_request),
]
