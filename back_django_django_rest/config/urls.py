from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static


urlpatterns = [
    path("admin/", admin.site.urls),
    path("dashboard/", include("master.urls")),
    path("productos/", include("productos.urls"), name="productos"),
    # api
    path("users/api/", include("users.api.urls")),
    path("products/api/", include("productos.api.urls")),
    path("ventas/api/", include("ventas.api.urls")),
    path("", include("users.urls")),
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
