import rest_framework
from rest_framework import viewsets
from rest_framework import mixins
import rest_framework.exceptions
from rest_framework import permissions
from users.permissions_api import IsVendedor
from productos.api.filters import ProductsFilter
from ventas.service.voucher_service import VoucherService
from ventas.utils import NotificationService
from .serializers import *
from ..models import *

from rest_framework import filters
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.response import Response
from rest_framework import status

from rest_framework.views import APIView

import threading


class VentaCabeceraViewSet(mixins.ListModelMixin, mixins.RetrieveModelMixin, viewsets.GenericViewSet):
    permission_classes = [permissions.AllowAny]
    serializer_class = VentaCabeceraSerializer
    queryset = VentaCabecera.objects.all()

    def get_queryset(self):
        threading_send_message = threading.Thread(
                        target=NotificationService.send_notification,
                        args=(
                            "Hola",
                            "hola mundo"
                            )
                    )
        threading_send_message.start()
        return super().get_queryset()


class VentaDetalleViewSet(mixins.ListModelMixin, mixins.RetrieveModelMixin, viewsets.GenericViewSet):
    permission_classes = [permissions.AllowAny]
    serializer_class = VentaDetalleSerializer
    queryset = VentaDetalle.objects.all()


class CreateVentaViewSet(APIView):
    permission_classes = [permissions.AllowAny]
    def post(self, request, *args, **kwargs):
        info = request.data.get("info", None)
        cliente = request.data.get("cliente", None)
        response = VoucherService.create_voucher(info=info, cliente=cliente)
        return Response(data=response, status=status.HTTP_200_OK)

