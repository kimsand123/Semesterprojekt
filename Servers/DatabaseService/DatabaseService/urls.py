from django.contrib import admin
from django.urls import include, path, re_path

from DatabaseServiceApp.views import default_views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('DatabaseServiceApp.urls')),
]
