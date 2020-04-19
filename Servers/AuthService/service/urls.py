from django.urls import path

from . import views

urlpatterns = [
    path('', views.nothing),
    path('login', views.login),
]
