import rest_framework
from rest_framework import viewsets
from rest_framework import mixins
import rest_framework.exceptions
from rest_framework import permissions
from users.permissions_api import IsVendedor
from productos.api.filters import ProductsFilter
from .serializers import *
from ..models import *

from rest_framework import filters
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.response import Response
from rest_framework import status

class ProductsViewSet(mixins.ListModelMixin, mixins.RetrieveModelMixin, viewsets.GenericViewSet,):
    permission_classes = [permissions.AllowAny]
    serializer_class = ProductoSerializer
    filter_backends = [DjangoFilterBackend, filters.OrderingFilter]
    filterset_class = ProductsFilter
    queryset = Producto.objects.all()


class ColorViewSet(mixins.ListModelMixin, mixins.RetrieveModelMixin, viewsets.GenericViewSet):
    permission_classes = [permissions.AllowAny]
    serializer_class = ColorSerializer
    queryset = Color.objects.all()

class MarcaViewSet(mixins.ListModelMixin, mixins.RetrieveModelMixin, viewsets.GenericViewSet):
    permission_classes = [permissions.AllowAny]
    serializer_class = MarcaSerializer
    queryset = Marca.objects.all()

class ModeloViewSet(mixins.ListModelMixin, mixins.RetrieveModelMixin, viewsets.GenericViewSet):
    permission_classes = [permissions.AllowAny]
    serializer_class = ModeloSerializer
    queryset = Modelo.objects.all()

class TallaViewSet(mixins.ListModelMixin, mixins.RetrieveModelMixin, viewsets.GenericViewSet):
    permission_classes = [permissions.AllowAny]
    serializer_class = TallaSerializer
    queryset = Talla.objects.all()