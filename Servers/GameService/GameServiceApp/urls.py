from django.urls import path
from . import views

urlpatterns = [
        path('', views.nothing),
        path('players/registeruser', views.register_user),  # POST register a user from AUTH
        path('players/<str:token>', views.get_player), #GET a specific player
        path('players/<str:token>/<str:player_id>/', views.get_players), #GET all players
        path('invites/<str:token>', views.get_invites), #GET all invites
        path('invites/<str:token>', views.invite_player), #POST invite a specific player
        path('invites/<str:token>', views.accept_invite), #PUT accept an invite

        path('games/', views.get_games), #GET get all games
        path('games/<int:game_id>/', views.get_game), #GET get single game
        path('games/<int:game_id>/player_status', views.get_all_player_status), #GET get all player status
        path('games/<int:game_id>/player_status/<int:player_id>/status', views.set_player_status), #POST player status
    ]