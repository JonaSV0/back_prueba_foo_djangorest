from django.urls import path

from . import views


urlpatterns = [
    path("producto/crear", views.ProductView.as_view(), name="product"),
    path("producto/detalle/<int:id>", views.ProductDetailView.as_view(), name="product-detail"),
    path("producto/editar/<int:id>", views.ProductEditView.as_view(), name="product-edit"),
    path("producto/eliminar/<int:id>", views.delte_product, name="product-delete"),
    path("productos", views.ProductListView.as_view(), name="products-list"),

    path("marcas", views.MarcaView.as_view(), name="marcas-list"),
    path("marcas/editar/<int:id>", views.MarcaEditView.as_view(), name="marcas-edit"),
    path("marcas/borrar/<int:id>", views.delete_marca, name="marcas-delete"),

    path("modelos", views.ModeloView.as_view(), name="modelos-list"),
    path("modelos/editar/<int:id>", views.ModeloEditView.as_view(), name="modelos-edit"),
    path("modelos/borrar/<int:id>", views.delete_modelo, name="modelos-delete"),

    path("colores", views.ColorView.as_view(), name="colores-list"),
    path("colores/editar/<int:id>", views.ColorEditView.as_view(), name="colores-edit"),
    path("colores/borrar/<int:id>", views.delete_color, name="colores-delete"),

    path("tallas", views.TallaView.as_view(), name="tallas-list"),
    path("tallas/editar/<int:id>", views.TallaEditView.as_view(), name="tallas-edit"),
    path("tallas/borrar/<int:id>", views.delete_talla, name="tallas-delete"),
]
