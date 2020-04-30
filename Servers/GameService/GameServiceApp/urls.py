from django.urls import path

from GameServiceApp.Views import default_views, game_views, player_views, invite_views

urlpatterns = [
    path('', default_views.nothing),

    # Players
    path('players/register_user/', player_views.register_user),  # POST register a user from AUTH
    path('players/<str:player_id>/', player_views.get_player),  # GET a specific player
    path('players/', player_views.players),  # GET all players

    # Invites
    path('invites/', invite_views.invites),  # GET all invites, #POST invite a specific player
    path('invites/<str:invite_id>/', invite_views.accept_invite),  # PUT accept an invite

    # Game
    path('games/', game_views.games),  # GET get all games POST add game
    path('games/<int:game_id>/', game_views.single_game),  # GET single game PUT edit game DELETE game
]
