from django.shortcuts import render
from django.views.generic import View
from productos.models.producto import Producto
from django.views.generic import ListView
from django.shortcuts import redirect
from django.views.generic import DetailView
from django.forms.models import model_to_dict
from django.core.files.storage import default_storage

from productos.forms import ProductForm, ProductEditForm
from productos.services import ProductService
from productos.utils import ProductImageUtil
from users.permissions import ViewPermissionRequiredMixin

import threading
from ventas.utils import NotificationService

class ProductListView(ViewPermissionRequiredMixin, ListView):
    model = Producto
    queryset = Producto.objects.all()
    template_name = "products.html"
    context_object_name = "productos"


class ProductDetailView(ViewPermissionRequiredMixin, DetailView):
    template_name = "product_detail.html"
    model = Producto
    context_object_name = "producto"
    pk_url_kwarg = "id"


class ProductView(ViewPermissionRequiredMixin, View):
    def get(self, request):
        product_form = ProductForm()
        context = {"form": product_form}
        return render(request, "products_create.html", context)

    def post(self, request):
        product_form = ProductForm(request.POST, request.FILES)
        if product_form.is_valid():
            productAlt = product_form
            data = product_form.cleaned_data
            ProductService.create_product(data)

            title = "Producto Agregado"
            message = f"{productAlt.data['name']} con codigo {productAlt.data['code']} precio: {productAlt.data['price']}"
            threading_send_message = threading.Thread(
                    target=NotificationService.send_notification,
                    args=(
                        title, message
                        )
                )
            threading_send_message.start()
            return redirect("products-list")
        else:
            context = {"form": product_form}
            return render(request, "products_create.html", context)


class ProductEditView(ViewPermissionRequiredMixin, View):
    def get(self, request, id):
        product = Producto.objects.get(id=id)
        product_form = ProductEditForm(initial=model_to_dict(product))
        context = {
            "form": product_form,
            "product": product,
        }
        return render(request, "products_edit.html", context)

    def post(self, request, id):
        product = Producto.objects.get(id=id)
        product_form = ProductEditForm(request.POST, request.FILES)
        price1 = float(product_form.data['price'])
        price2 = float(product.price)
        if product_form.is_valid():
            data = product_form.cleaned_data
            ProductService.update_product(data, product)

            if price1 != price2:
                
                title = "¡Alerta de cambio de precio!"
                message = f"{product.name} con codigo {product.code} a modificado su precio de: {price2} a {price1}"
                threading_send_message = threading.Thread(
                        target=NotificationService.send_notification,
                        args=(
                            title, message
                            )
                    )
                threading_send_message.start()

            return redirect("products-list")
        else:

            context = {"form": product_form, "product": product}
            return render(request, "products_edit.html", context)


def delte_product(request, id):
    if request.method == "POST":
        product = Producto.objects.get(id=id)
        product.delete()
        file_name = product.static_img.split("/")[-1]
        path_img_barcode = f"barcodes/{file_name}"
        # automatic using MEDIA_ROOT
        if default_storage.exists(path_img_barcode):
            default_storage.delete(path_img_barcode)

        # delete image
        ProductImageUtil.delete_image(image_url=product.imagen_url)
        return redirect("products-list")
