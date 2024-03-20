from django.db import models

class VentaCabecera(models.Model):
    datetime_created = models.DateTimeField(auto_now_add=True, blank=True, null=True)
    cliente = models.CharField(max_length=255)
    importe_total = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)

    def __str__(self) -> str:
        return f"clieente: {self.cliente} - {self.importe_total}"