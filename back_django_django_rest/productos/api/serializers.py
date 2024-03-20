from rest_framework import serializers
from productos.models import *

class ColorSerializer(serializers.ModelSerializer):
    class Meta:
        model = Color
        fields = '__all__'

class MarcaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Marca
        fields = '__all__'

class ModeloSerializer(serializers.ModelSerializer):
    class Meta:
        model = Modelo
        fields = '__all__'

class TallaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Talla
        fields = '__all__'

class ProductoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Producto
        fields = ['id', 'name', 'code', 'static_img_code', 'static_img', 'price', 'id_marca', 'id_modelo', 
                  'id_color', 'id_talla', 'stock', 'imagen_url', 'marca_name', 'modelo_name', 'color_name', 'talla_name']
        