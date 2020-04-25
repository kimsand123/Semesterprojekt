from django.urls import path
from . import views
from .Views import player_views, invite_views, games_views

urlpatterns = [
        path('', views.nothing),


        #Players
        path('players/registeruser/', views.register_user),  # POST register a user from AUTH
        path('players/<str:player_id>/', views.get_player),  # GET a specific player
        path('players/', views.get_players),  # GET all players

        #Invites
        path('invites/', views.invites), #GET all invites, #POST invite a specific player
        path('invites/<str:invite_id>/', views.accept_invite), #PUT accept an invite

        #Game
        path('games/', games_views.get_games), #GET get all games
        path('games/<int:game_id>/', games_views.get_game), #GET get single game
        path('games/<int:game_id>/player_status', games_views.get_all_player_status), #GET get all player status
        path('games/<int:game_id>/player_status/<int:player_id>/status', games_views.set_player_status), #POST player status

    ]