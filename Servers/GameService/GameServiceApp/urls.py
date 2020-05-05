from django.urls import path

from GameServiceApp.Views import default_views, game_views, player_views, invite_views, register_user_views

urlpatterns = [
    path('', default_views.nothing),

    # Players
    path('players/<str:player_id>/', player_views.single_player),  # GET a specific player
    path('players/', player_views.players),  # GET all players

    # Invites
    path('invites/', invite_views.invites),  # GET all invites, #POST invite a specific player
    path('invites/<str:invite_id>/', invite_views.single_invite),  # PUT accept an invite

    # Game
    path('games/', game_views.games),  # GET get all games POST add game
    path('games/<str:game_id>/player-status/', game_views.single_game_player_status),
    path('games/<int:game_id>/', game_views.single_game),  # GET single game PUT edit game DELETE game

    # Register user
    path('register_user/', register_user_views.register_user),  # POST register a user from AUTH
]
