from typing import Any
from django.core.management.base import BaseCommand
from users.scripts_default_data import CreateDefaultGroups


SCRIPS_DEFAULT_DATA = [
    CreateDefaultGroups,
]


class Command(BaseCommand):
    help = "Comando para ejecutar scripts de data por defecto: 'python manage.py default_data'"

    def handle(self, *args: Any, **options: Any) -> None:
        for script in SCRIPS_DEFAULT_DATA:
            script.execute()
