from django.shortcuts import render
from django.views import View

from users.permissions import ViewPermissionRequiredMixin
from users.enums import Roles
from master.service import DashboardService


class DashboardView(ViewPermissionRequiredMixin, View):
    role_required = [Roles.ADMIN.value]

    def get(self, request):
        # cantidad de productos vendidos del día, # total de ventas del día
        cantidad_de_productos_vendidos, total_de_ventas = (
            DashboardService.get_products_sold_that_day()
        )
        top_productos = DashboardService.get_most_selled_products()

        context = {
            "cantidad_productos": cantidad_de_productos_vendidos,
            "total_ventas": total_de_ventas,
            "top_productos": top_productos,
        }

        return render(request, "home.html", context)
