from django.shortcuts import render
from django.views.generic import View
from django.shortcuts import redirect

from productos.forms import TallaModelForm
from productos.models import Talla
from users.permissions import ViewPermissionRequiredMixin


class TallaView(ViewPermissionRequiredMixin, View):
    def get_data(self):
        return Talla.objects.all().order_by("id")

    def get(self, request):
        context = {
            "tallas": self.get_data(),
            "form": TallaModelForm(),
        }
        return render(request, "talla/talla.html", context)

    def post(self, request):
        talla_form = TallaModelForm(request.POST)
        if talla_form.is_valid():
            talla_form.save()
            return redirect("tallas-list")
        context = {"form": talla_form, "tallas": self.get_data()}
        return render(request, "talla/talla.html", context)


class TallaEditView(ViewPermissionRequiredMixin, View):
    def get(self, request, id):
        talla = Talla.objects.get(id=id)
        talla_form = TallaModelForm(instance=talla)
        context = {"form": talla_form}
        return render(request, "talla/talla_edit.html", context)

    def post(self, request, id):
        talla = Talla.objects.get(id=id)
        talla_form = TallaModelForm(request.POST, instance=talla)
        if talla_form.is_valid():
            talla.save()
            return redirect("tallas-list")
        else:
            context = {"form": talla_form}
            return render(request, "talla/talla_edit.html", context)


def delete_talla(request, id):
    if request.method == "POST":
        talla = Talla.objects.get(id=id)
        talla.delete()
        return redirect("tallas-list")
