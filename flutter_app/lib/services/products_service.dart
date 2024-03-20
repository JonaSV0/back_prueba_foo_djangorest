import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyect_footloose/constantes.dart';
import 'package:proyect_footloose/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductService {
  static const String URL = URL_SERVER;

  static Future<List<Product>> fetchProducts() async {
    String url = URL + "products/api/product/";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String idModelo = prefs.getString('idModelo') ?? '';
    String idMarca = prefs.getString('idMarca') ?? '';
    String idColor = prefs.getString('idColor') ?? '';
    String idTalla = prefs.getString('idTalla') ?? '';
    bool isFilter = prefs.getBool('is_filter') ?? false;
    bool isQR = prefs.getBool('is_qr') ?? false;
    String qr = prefs.getString('qr') ?? '';

    prefs.remove('idModelo');
    prefs.remove('idMarca');
    prefs.remove('idColor');
    prefs.remove('idTalla');
    prefs.remove('is_filter');
    prefs.remove('is_qr');
    prefs.remove('qr');

    print(isFilter);
    print(idColor);

    String queryParams = '';

    if (isFilter) {
      if (idModelo.isNotEmpty) queryParams += '&id_modelo=$idModelo';
      if (idMarca.isNotEmpty) queryParams += '&id_marca=$idMarca';
      if (idColor.isNotEmpty) queryParams += '&id_color=$idColor';
      if (idTalla.isNotEmpty) queryParams += '&id_talla=$idTalla';
    }

    if (isQR && qr.isNotEmpty) {
      queryParams += '&code=$qr';
    }

    if (queryParams.isNotEmpty) {
      url += '?' + queryParams.substring(1); // Remover el primer '&'
    }
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Product> products = data.map((item) => Product.fromJson(item)).toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }


  static Future<Product> fetchProduct(String id) async {
    String url = URL + "products/api/product/" + id + "/";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200){
       final Map<String, dynamic> data = json.decode(response.body);
       return Product.fromJson(data);
    } else {
      throw Exception('Failed to load products');
    }
  }
}