from rest_framework.permissions import BasePermission
from users.models import User
from rest_framework.exceptions import ValidationError


class IsAdmin(BasePermission):
    def has_permission(self, request, view):
        return request.user.is_admin


class IsVendedor(BasePermission):
    def has_permission(self, request, view):
        return request.user.is_vendedor


class RestrictPermission(BasePermission):
    def has_permission(self, request, view):
        restrict = view.restrict
        action = view.action
        restrict_permissions = restrict.get(action, [])
        if len(restrict_permissions) > 0:
            is_permited = check_permissions(request.user, restrict_permissions)
            if not is_permited:
                raise ValidationError("No tienes permisos para realizar esta acción")
        return True


class RestrictPermissionApiView(BasePermission):
    def has_permission(self, request, view):
        restrict = view.restrict
        action = request.method.lower()
        restrict_permissions = restrict.get(action, [])
        if len(restrict_permissions) > 0:
            is_permited = check_permissions(request.user, restrict_permissions)
            if not is_permited:
                raise ValidationError("No tienes permisos para realizar esta acción")
        return True


def check_permissions(user: User, list_restrict_permissions: list[str]):
    any_role_permited = []
    for restrict_permission in list_restrict_permissions:
        is_permited = restrict_permission(user)
        any_role_permited.append(is_permited)
    return any(any_role_permited)
