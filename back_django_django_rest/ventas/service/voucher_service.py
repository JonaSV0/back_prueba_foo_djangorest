import json
from django.utils import timezone
from datetime import datetime

from rest_framework.exceptions import ValidationError
from ventas.models.venta_cabecera import VentaCabecera
from django.db import transaction
from ventas.models.venta_detalle import VentaDetalle
from productos.models.producto import Producto
class VoucherService:

    @staticmethod
    def create_voucher(info, cliente):
        cart_items = json.loads(info)
        
        # Crear la cabecera de la venta
        with transaction.atomic():
            venta_cabecera = VentaCabecera.objects.create(cliente="Cliente X", importe_total=0)
            
            # Iterar sobre los elementos del carrito
            total_importe = 0
            for item in cart_items:
                producto_id = item["id"]
                cantidad = item["quantity"]
                
                # Obtener el producto de la base de datos
                producto = Producto.objects.get(pk=producto_id)
                
                # Calcular el precio total para este item
                precio_total = producto.price * cantidad
                total_importe += precio_total
                
                # Crear el detalle de la venta
                VentaDetalle.objects.create(
                    id_venta_cabecera=venta_cabecera,
                    id_producto=producto,
                    price_u=producto.price,
                    amount=cantidad,
                    price_t=precio_total
                )
            
            # Actualizar el importe total en la cabecera de la venta
            venta_cabecera.importe_total = total_importe
            venta_cabecera.save()

            return {"message": "sucess"}