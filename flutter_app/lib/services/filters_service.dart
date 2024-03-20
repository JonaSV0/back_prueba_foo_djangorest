import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyect_footloose/constantes.dart';
import 'package:proyect_footloose/models/filters.dart';

class FilterService {
  static const String URL = URL_SERVER;

  static Future<List<Modelo>> fetchModelo() async {
    String url = URL + "products/api/modelo/" ;
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Modelo> modelos = data.map((item) => Modelo.fromJson(item)).toList();
      return modelos;
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<List<Marca>> fetchMarca() async {
    String url = URL + "products/api/marca/" ;
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Marca> marcas = data.map((item) => Marca.fromJson(item)).toList();
      return marcas;
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<List<Color>> fetchColor() async {
    String url = URL + "products/api/color/" ;
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Color> colors = data.map((item) => Color.fromJson(item)).toList();
      return colors;
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<List<Talla>> fetchTalla() async {
    String url = URL + "products/api/talla/" ;
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Talla> tallas = data.map((item) => Talla.fromJson(item)).toList();
      return tallas;
    } else {
      throw Exception('Failed to load products');
    }
  }

}