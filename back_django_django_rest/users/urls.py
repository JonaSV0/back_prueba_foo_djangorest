from django.urls import path
from django.shortcuts import redirect
from django.views.generic import TemplateView

from . import views


urlpatterns = [
    path('', lambda request: redirect('login')),
    path('login', views.AuthenticationView.as_view(), name='login'),
    path('logout', views.logout_session, name='logout'),
    path('no-autorizado', TemplateView.as_view(template_name='no_autorizado.html'), name='no-autorizado')
]
