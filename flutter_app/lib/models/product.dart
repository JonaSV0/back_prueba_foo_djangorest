import 'dart:ffi';

class Product {
  final int id;
  final String name;
  final String code;
  final String url_img_code;
  final String url_img;
  final String price;
  final int stock;

  final int id_marca;
  final int id_modelo;
  final int id_color;
  final int id_talla;

  final String marca_name;
  final String modelo_name;
  final String color_name;
  final String talla_name;

  Product({required this.id, required this.name,
  required this.code, required this.url_img_code, required this.url_img,
    required this.price, required this.stock, required this.id_marca, required this.id_modelo,
    required this.id_color, required this.id_talla, required this.marca_name, required this.modelo_name,
    required this.color_name, required this.talla_name
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'], name: json['name'], code: json['code'],
        url_img_code: json['static_img'], url_img: json['imagen_url'],
        price: json['price'], stock: json['stock'], id_marca: json['id_marca'],
        id_modelo: json['id_modelo'], id_color: json['id_color'], id_talla: json['id_talla'],
        marca_name: json['marca_name'], modelo_name: json['modelo_name'], color_name: json['color_name'],
        talla_name: json['talla_name']
    );
  }

}