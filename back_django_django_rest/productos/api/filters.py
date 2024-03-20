import django_filters
from rest_framework import filters
from ..models import *

class ProductsFilter(django_filters.rest_framework.FilterSet):
    class Meta:
        model = Producto
        fields = ('code', 'id_marca', 'id_modelo', 'id_color', 'id_talla')
