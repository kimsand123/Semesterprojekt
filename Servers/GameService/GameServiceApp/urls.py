from django.urls import path
from . import views

urlpatterns = [
        path('', views.nothing),
        path('players/registeruser', views.register_user),  # POST register a user from AUTH
        path('players/<str:token>', views.get_player), #GET a specific player
        path('players/<str:token><str:player_id>/', views.get_players), #GET all players
        path('invites/<str:token>', views.get_invites), #GET all invites
        path('invites/<str:token>', views.invite_player), #POST invite a specific player
        path('invites/<str:token>', views.get_specific_invites), #PUT accept an invite
    ]