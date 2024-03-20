from django.shortcuts import render, redirect
from django.views.generic import View
from django.contrib.auth import login, logout

from .services import AuthService


class AuthenticationView(View):
    def get(self, request):
        if request.user.is_authenticated:
            return redirect("dashboard")
        return render(request, "login.html")

    def post(self, request):
        username = request.POST.get("username")
        password = request.POST.get("password")
        user = AuthService.authenticate(username, password)
        if user is not None:
            login(request, user)
            return redirect("dashboard")
        context = {"error": "Credenciales incorrectas", "username": username}
        return render(request, "login.html", context=context)


def logout_session(request):
    logout(request)
    return redirect("login")
