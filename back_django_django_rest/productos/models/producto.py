from django.db import models
from productos.models.marca import Marca
from productos.models.modelo import Modelo
from productos.models.color import Color
from productos.models.talla import Talla


class Producto(models.Model):
    name = models.CharField(max_length=255, unique=True)
    code = models.CharField(blank=True, null=True, max_length=13, unique=True)
    static_img_code = models.CharField(max_length=255, blank=True, null=True)
    static_img = models.CharField(max_length=255, blank=True, null=True)
    price = models.DecimalField(max_digits=10, decimal_places=2)

    id_marca = models.ForeignKey(
        Marca, on_delete=models.SET_NULL, blank=True, null=True
    )
    id_modelo = models.ForeignKey(
        Modelo, on_delete=models.SET_NULL, blank=True, null=True
    )
    id_color = models.ForeignKey(
        Color, on_delete=models.SET_NULL, blank=True, null=True
    )
    id_talla = models.ForeignKey(
        Talla, on_delete=models.SET_NULL, blank=True, null=True
    )

    stock = models.IntegerField(default=0, blank=True, null=True)

    imagen_url = models.CharField(max_length=255, blank=True, null=True)


    def __str__(self) -> str:
        return f"{self.name} - {self.price} - {self.stock}"

    @property
    def marca_name(self):
        name = self.id_marca.name
        return name
    
    @property
    def modelo_name(self):
        name = self.id_modelo.name
        return name
    
    @property
    def color_name(self):
        name = self.id_color.name
        return name

    @property
    def talla_name(self):
        name = self.id_talla.name
        return name

