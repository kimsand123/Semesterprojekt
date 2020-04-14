from django.urls import path, re_path

from . import views

urlpatterns = [
    path('players/', views.users),
    path('players/<str:user_id>/', views.single_user),
    path('invites/', views.invites),
    path('invites/<str:invite_id>/', views.single_invite),
    path('', views.welcome),
    re_path(r'$', views.bad_request),
    # path('<str:pk>/', views.DetailView.as_view(), name='detail'),
    # path('', views.IndexView.as_view(), name='index'),
    # path('<int:pk>/', views.DetailView.as_view(), name='detail'),
    # path('<int:pk>/results/', views.ResultsView.as_view(), name='results'),
    # path('<int:question_id>/vote/', views.vote, name='vote'),

]
