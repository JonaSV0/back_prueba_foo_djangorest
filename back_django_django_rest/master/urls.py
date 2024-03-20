from django.urls import path

from . import views


urlpatterns = [
    path('home', views.DashboardView.as_view(), name="dashboard"),
]
