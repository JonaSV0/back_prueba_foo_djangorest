from django.urls import path
from django.shortcuts import redirect
from django.views.generic import TemplateView

from users.api.api import LoginView, UpdateTokenView
from . import api as views


urlpatterns = [
    path("login", LoginView.as_view(), name="login-api"),
    path("update_token", UpdateTokenView.as_view(), name="update_token")
]
