from django.shortcuts import render
from django.views.generic import View
from django.shortcuts import redirect

from productos.forms import ColorModelForm
from productos.models import Color
from users.permissions import ViewPermissionRequiredMixin


class ColorView(ViewPermissionRequiredMixin, View):
    def get_data(self):
        return Color.objects.all().order_by("id")

    def get(self, request):
        context = {
            "colores": self.get_data(),
            "form": ColorModelForm(),
        }
        return render(request, "color/color.html", context)

    def post(self, request):
        color_form = ColorModelForm(request.POST)
        if color_form.is_valid():
            color_form.save()
            return redirect("colores-list")
        context = {"form": color_form, "colores": self.get_data()}
        return render(request, "color/color.html", context)


class ColorEditView(ViewPermissionRequiredMixin, View):
    def get(self, request, id):
        color = Color.objects.get(id=id)
        color_form = ColorModelForm(instance=color)
        context = {"form": color_form}
        return render(request, "color/color_edit.html", context)

    def post(self, request, id):
        color = Color.objects.get(id=id)
        color_form = ColorModelForm(request.POST, instance=color)
        if color_form.is_valid():
            color.save()
            return redirect("colores-list")
        else:
            context = {"form": color_form}
            return render(request, "color/color_edit.html", context)


def delete_color(request, id):
    if request.method == "POST":
        color = Color.objects.get(id=id)
        color.delete()
        return redirect("colores-list")
