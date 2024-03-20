from django.utils import timezone
from ventas.models import VentaCabecera, VentaDetalle
from productos.models import Producto

import pytz


class DashboardService:
    @staticmethod
    def get_products_sold_that_day() -> tuple:
        """ "cantidad de productos vendidos del día y el importe total de las ventas del día."""
        # fecha en zona horaria America/lima
        actual_date_peru = timezone.now().astimezone(pytz.timezone("America/Lima"))
        actual_date_utc = actual_date_peru.astimezone(pytz.utc).date()
        venta_cabeceras_today = VentaCabecera.objects.filter(
            datetime_created__date=actual_date_utc
        )
        total_products_sold_amount = 0
        total_products_sold = 0
        for venta_cabecera in venta_cabeceras_today:
            total_products_sold += venta_cabecera.importe_total
            venta_detalle = VentaDetalle.objects.filter(id_venta_cabecera=venta_cabecera)
            total_products_sold_amount += sum([detalle.amount for detalle in venta_detalle])
        return total_products_sold_amount, total_products_sold

    @staticmethod
    def get_most_selled_products() -> list[tuple[Producto, int]]:
        """top 3 productos más vendidos."""
        products = {}
        venta_detalles = VentaDetalle.objects.all()
        for venta_detalle in venta_detalles:
            if venta_detalle.id_producto in products:
                products[venta_detalle.id_producto] += venta_detalle.amount
            else:
                products[venta_detalle.id_producto] = venta_detalle.amount
        return sorted(products.items(), key=lambda x: x[1], reverse=True)[:3]
