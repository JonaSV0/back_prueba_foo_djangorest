from django.shortcuts import render
from django.views.generic import View
from django.shortcuts import redirect

from productos.forms import ModeloModelForm
from productos.models import Modelo
from users.permissions import ViewPermissionRequiredMixin


class ModeloView(ViewPermissionRequiredMixin, View):
    def get_data(self):
        return Modelo.objects.all().order_by("id")

    def get(self, request):
        context = {
            "modelos": self.get_data(),
            "form": ModeloModelForm(),
        }
        return render(request, "modelo/modelo.html", context)

    def post(self, request):
        modelo_form = ModeloModelForm(request.POST)
        if modelo_form.is_valid():
            modelo_form.save()
            return redirect("modelos-list")
        context = {"form": modelo_form, "modelos": self.get_data()}
        return render(request, "modelo/modelo.html", context)


class ModeloEditView(ViewPermissionRequiredMixin, View):
    def get(self, request, id):
        modelo = Modelo.objects.get(id=id)
        modelo_form = ModeloModelForm(instance=modelo)
        context = {"form": modelo_form}
        return render(request, "modelo/modelo_edit.html", context)

    def post(self, request, id):
        modelo = Modelo.objects.get(id=id)
        modelo_form = ModeloModelForm(request.POST, instance=modelo)
        if modelo_form.is_valid():
            modelo.save()
            return redirect("modelos-list")
        else:
            context = {"form": modelo_form}
            return render(request, "modelo/modelo_edit.html", context)


def delete_modelo(request, id):
    if request.method == "POST":
        modelo = Modelo.objects.get(id=id)
        modelo.delete()
        return redirect("modelos-list")
