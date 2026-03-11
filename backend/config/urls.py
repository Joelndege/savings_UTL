from django.contrib import admin
from django.urls import path, include
from api.views_health import health_check

urlpatterns = [
    path('', health_check, name='root_health'),
    path('health/', health_check, name='health_check'),
    path('admin/', admin.site.urls),
    path('api/', include('api.urls')),
]

