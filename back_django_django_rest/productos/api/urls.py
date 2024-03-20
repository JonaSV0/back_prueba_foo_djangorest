from django.conf.urls import include
from django.urls import path
from rest_framework import routers
from .views import *

router = routers.DefaultRouter()

router.register('product', ProductsViewSet, 'product')
router.register('color', ColorViewSet, 'color')
router.register('marca', MarcaViewSet, 'marca')
router.register('modelo', ModeloViewSet, 'modelo')
router.register('talla', TallaViewSet, 'talla')

urlpatterns = [
    path('', include(router.urls)),
    #path("printer-voucher/<int:id_voucher>/", PrinterVoucherViewSet.as_view(), name="printer-voucher")
    #path('token/addparking', AddParkingVehicleViewSet.as_view(), name='addparking'),
]