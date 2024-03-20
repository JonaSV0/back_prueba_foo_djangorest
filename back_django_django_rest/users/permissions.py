from django.contrib.auth.mixins import LoginRequiredMixin
from django.shortcuts import redirect
from .models import User
from django.http import HttpRequest


class ViewPermissionRequiredMixin:
    role_required = []
    role_by_method = {}

    def dispatch(self, request, *args, **kwargs):
        user = request.user
        role_permited = self.role_required
        role_by_method = self.role_by_method

        if not user.is_authenticated:
            return redirect("login")

        if user.is_superuser:
            return super().dispatch(request, *args, **kwargs)

        if role_permited != []:
            if self.is_not_permited_by_role(user, role_permited):
                return redirect("no-autorizado")

        if role_by_method != {}:
            if self.is_not_permited_by_method(request, role_by_method):
                return redirect("no-autorizado")

        return super(ViewPermissionRequiredMixin, self).dispatch(
            request, *args, **kwargs
        )

    def is_not_permited_by_method(
        self, request: HttpRequest, role_by_method: dict[str, list[str]]
    ):
        user = request.user
        method = request.method.lower()
        role_permited = role_permited.get(method, [])
        if role_permited == []:
            return False
        return not user.groups.filter(name__in=role_permited).exists()

    def is_not_permited_by_role(self, user: User, role_permited: list[str]):
        return not user.groups.filter(name__in=role_permited).exists()
