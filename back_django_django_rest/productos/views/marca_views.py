from django.shortcuts import render
from django.views.generic import View
from django.shortcuts import redirect

from productos.forms import MarcaModelForm
from productos.models import Marca
from users.permissions import ViewPermissionRequiredMixin


class MarcaView(ViewPermissionRequiredMixin, View):
    def get_marcas(self):
        return Marca.objects.all().order_by("id")

    def get(self, request):
        context = {
            "marcas": self.get_marcas(),
            "form": MarcaModelForm(),
        }
        return render(request, "marca/marca.html", context)

    def post(self, request):
        marca_form = MarcaModelForm(request.POST)
        if marca_form.is_valid():
            marca_form.save()
            return redirect("marcas-list")
        context = {"form": marca_form, "marcas": self.get_marcas()}
        return render(request, "marca/marca.html", context)


class MarcaEditView(ViewPermissionRequiredMixin, View):
    def get(self, request, id):
        marca = Marca.objects.get(id=id)
        marca_form = MarcaModelForm(instance=marca)
        context = {"form": marca_form}
        return render(request, "marca/marca_edit.html", context)

    def post(self, request, id):
        marca = Marca.objects.get(id=id)
        marca_form = MarcaModelForm(request.POST, instance=marca)
        if marca_form.is_valid():
            marca.save()
            return redirect("marcas-list")
        else:
            context = {"form": marca_form}
            return render(request, "marca/marca_edit.html", context)


def delete_marca(request, id):
    if request.method == "POST":
        marca = Marca.objects.get(id=id)
        marca.delete()
        return redirect("marcas-list")
