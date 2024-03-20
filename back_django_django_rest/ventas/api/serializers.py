from ..models import *
from rest_framework import serializers


class VentaCabeceraSerializer(serializers.ModelSerializer):
    class Meta:
        model = VentaCabecera
        fields = '__all__'

class VentaDetalleSerializer(serializers.ModelSerializer):
    class Meta:
        model = VentaDetalle
        fields = '__all__'