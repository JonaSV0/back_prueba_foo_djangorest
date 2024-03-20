from django.contrib.auth.models import Group
from users.enums import Roles


class CreateDefaultGroups:
    def execute() -> None:
        try:
            for role in Roles:
                _, created = Group.objects.get_or_create(name=role.value)
                if created:
                    print(f"Grupo creado '{role.value}'.")
                else:
                    print(f"Grupo ya existe '{role.value}'")
        except Exception as e:
            print("Error crear grupos pro defecto: ", e)
