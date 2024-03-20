from barcode import EAN13
from barcode.writer import ImageWriter
from django.conf import settings
from django.core.files.storage import default_storage


class BarcodeUtil:
    @staticmethod
    def generate_barcode(product_id: int) -> tuple[str, str]:
        """Generates a barcode for a product and saves it to the filesystem."""
        """returns the filename and the number code"""
        number_code = str(product_id).zfill(12)
        ean = EAN13(number_code, writer=ImageWriter())
        file_name = f"{ean}"
        path_file = f"{settings.MEDIA_ROOT}/barcodes/{file_name}"
        public_file_name = f"media/barcodes/{file_name}.png"
        ean.save(path_file)
        return public_file_name, ean


class ProductImageUtil:
    @staticmethod
    def save_image(*, file_name: str, image):
        """Saves an image to the filesystem."""
        image_file_name = f"{file_name}_product.png"
        default_storage.save(f"products/{image_file_name}", image) #default save in MEDIA_ROOT
        public_imagen_url = f"media/products/{image_file_name}"
        return public_imagen_url

    @staticmethod
    def delete_image(*, image_url: str):
        """Deletes an image from the filesystem."""
        image_file_name = image_url.split("/")[-1]
        path_img_product = f"products/{image_file_name}"
        if default_storage.exists(path_img_product):
            default_storage.delete(path_img_product)
    