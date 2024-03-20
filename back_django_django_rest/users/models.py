from django.contrib.auth.models import AbstractUser
from django.db import models
from .enums import Roles


class User(AbstractUser):
    hash_notification = models.CharField(max_length=255, null=True, blank=True)

    @property
    def is_admin(self):
        return self.groups.filter(name=Roles.VENDEDOR.value).exists()

    @property
    def is_vendedor(self):
        return self.groups.filter(name=Roles.VENDEDOR.value).exists()
