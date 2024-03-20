import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyect_footloose/constantes.dart';
import 'package:proyect_footloose/models/token_access.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/shoping_cart.dart';
class VentaService{

  Future<Map<String, dynamic>> generarVentaCart(String cliente) async {
    final url = URL_SERVER + 'ventas/api/create_venta/'; // Reemplaza con la URL de tu API
    String _cartJson = await CartService.getCartJson();
    print(_cartJson);

    final response = await http.post(
      Uri.parse(url),
      body: {'info': _cartJson, 'cliente': cliente},
    );

    if (response.statusCode == 200) {
      //final responseData = json.decode(response.body);
      print("Eliminadooooooo");
      //await CartService.clearCart();
      return {'success': true, 'message': 'Venta generada'};
    } else {
      return {'success': false, 'message': response.body };
    }
  }
}
