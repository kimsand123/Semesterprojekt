from django.urls import include, path
from . import views

urlpatterns = [
        path('/players/<str:token>', views.get_player), #GET
        path('/players/<str:token>/<str:player_id>', views.get_players), #GET
        path('/players/registeruser', views.register_user), #POST
        path('/invites/<str:token>', views.get_invites), #GET
        path('/invites/<str:token>', views.invite_player), #POST
        path('/invites/<str:token>', views.get_specific_invites), #PUT
    ]