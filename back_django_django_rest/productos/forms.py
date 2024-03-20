from django import forms
from .models import Marca, Modelo, Color, Talla


class ProductForm(forms.Form):
    imagen = forms.ImageField(
        required=True, widget=forms.FileInput(attrs={"class": "form-control"})
    )
    name = forms.CharField(
        required=True,
        widget=forms.TextInput(
            attrs={"class": "form-control", "placeholder": "Nombre de producto"}
        ),
    )
    code = forms.CharField(
        required=False,
        widget=forms.TextInput(
            attrs={"class": "form-control", "placeholder": "Código de producto"}
        ),
    )
    price = forms.DecimalField(
        max_digits=10,
        decimal_places=2,
        required=True,
        widget=forms.NumberInput(
            attrs={"class": "form-control", "placeholder": "Precio"}
        ),
    )
    id_marca = forms.ModelChoiceField(
        queryset=Marca.objects.all(),
        empty_label="Seleccione una marca",
        required=True,
        widget=forms.Select(attrs={"class": "form-select"}),
    )
    id_modelo = forms.ModelChoiceField(
        queryset=Modelo.objects.all(),
        empty_label="Seleccione un modelo",
        required=True,
        widget=forms.Select(attrs={"class": "form-select"}),
    )
    id_color = forms.ModelChoiceField(
        queryset=Color.objects.all(),
        empty_label="Seleccione un color",
        required=True,
        widget=forms.Select(attrs={"class": "form-select"}),
    )
    id_talla = forms.ModelChoiceField(
        queryset=Talla.objects.all(),
        empty_label="Seleccione una talla",
        required=True,
        widget=forms.Select(attrs={"class": "form-select"}),
    )
    stock = forms.IntegerField(
        required=True,
        widget=forms.NumberInput(
            attrs={"class": "form-control", "placeholder": "Stock"}
        ),
    )


class ProductEditForm(ProductForm):
    imagen = forms.ImageField(
        required=False, widget=forms.FileInput(attrs={"class": "form-control"})
    )


class MarcaModelForm(forms.ModelForm):
    class Meta:
        model = Marca
        fields = "__all__"
        widgets = {
            "name": forms.TextInput(attrs={"class": "form-control", 'placeholder': 'Nombre de la marca'})
        }


class ModeloModelForm(forms.ModelForm):
    class Meta:
        model = Modelo
        fields = "__all__"
        widgets = {
            "name": forms.TextInput(attrs={"class": "form-control", 'placeholder': 'Nombre del modelo'})
        }

class ColorModelForm(forms.ModelForm):
    class Meta:
        model = Color
        fields = "__all__"
        widgets = {
            "name": forms.TextInput(attrs={"class": "form-control", 'placeholder': 'Nombre del color'})
        }

class TallaModelForm(forms.ModelForm):
    class Meta:
        model = Talla
        fields = "__all__"
        widgets = {
            "name": forms.TextInput(attrs={"class": "form-control", 'placeholder': 'Nombre de la talla'})
        }
