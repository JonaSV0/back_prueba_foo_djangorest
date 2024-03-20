from productos.models import Producto
from productos.utils import BarcodeUtil
from django.core.files.storage import default_storage
from django.db import transaction
from productos.utils import ProductImageUtil


class ProductService:
    @staticmethod
    def create_product(data) -> Producto:
        product = Producto.objects.create(
            name=data["name"],
            # code=data["code"],
            price=data["price"],
            id_marca=data["id_marca"],
            id_modelo=data["id_modelo"],
            id_color=data["id_color"],
            id_talla=data["id_talla"],
            stock=data["stock"],
        )
        filename, number_code = BarcodeUtil.generate_barcode(product.id)
        product.static_img = filename
        product.static_img_code = number_code
        product.code = number_code

        # imagen de producto
        imagen_url = ProductImageUtil.save_image(
            file_name=number_code, image=data["imagen"]
        )
        product.imagen_url = imagen_url

        product.save()

        return product

    @staticmethod
    def update_product(data, product: Producto) -> Producto:
        product.name = data["name"]
        product.price = data["price"]
        product.id_marca = data["id_marca"]
        product.id_modelo = data["id_modelo"]
        product.id_color = data["id_color"]
        product.id_talla = data["id_talla"]
        product.stock = data["stock"]
        product.save()

        # actualizar imagen
        if data["imagen"] is not None:
            # delete previous image
            ProductImageUtil.delete_image(image_url=product.imagen_url)
            # add new image
            imagen_url = ProductImageUtil.save_image(
                file_name=product.code, image=data["imagen"]
            )
            product.imagen_url = imagen_url
            product.save()

        return product
