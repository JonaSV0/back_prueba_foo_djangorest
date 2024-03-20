from django.db import models
from ventas.models.venta_cabecera import VentaCabecera
from productos.models.producto import Producto


class VentaDetalle(models.Model):

    id_venta_cabecera = models.ForeignKey(VentaCabecera, on_delete=models.CASCADE)
    id_producto = models.ForeignKey(Producto, on_delete=models.SET_NULL, blank=True, null=True)

    detail_product = models.JSONField(null=True, blank=True)

    price_u = models.DecimalField(max_digits=10, decimal_places=2)
    amount = models.IntegerField()
    price_t = models.DecimalField(max_digits=10, decimal_places=2)

    def __str__(self) -> str:
        return f"venta: {self.id_venta_cabecera} - producto: {self.id_producto} - {self.price_t}"
