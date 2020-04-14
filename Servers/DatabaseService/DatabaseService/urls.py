from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path('database/', include('DatabaseServiceApp.urls')),
    path('admin/', admin.site.urls),
]
