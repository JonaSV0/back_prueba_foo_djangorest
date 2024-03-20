from django.conf.urls import include
from django.urls import path
from rest_framework import routers
from .views import *

router = routers.DefaultRouter()

router.register('venta_cabecera', VentaCabeceraViewSet, 'venta_cabecera')
router.register('venta_detalle', VentaDetalleViewSet, 'venta_detalle')

urlpatterns = [
    path('', include(router.urls)),
    path("create_venta/", CreateVentaViewSet.as_view(), name="create_venta/")
    #path('token/addparking', AddParkingVehicleViewSet.as_view(), name='addparking'),
]