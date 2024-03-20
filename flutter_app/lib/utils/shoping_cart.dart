import 'dart:convert';
import 'package:get/get.dart';
import 'package:proyect_footloose/utils/cart_notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  static CartController cartController = Get.find<CartController>();
  static const String _cartKey = 'cart';

  static Future<List<Map<String, dynamic>>> getCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cartString = prefs.getString(_cartKey);
    if (cartString != null) {
      List<dynamic> cartJson = json.decode(cartString);
      return cartJson.map((item) => Map<String, dynamic>.from(item)).toList();
    } else {
      return [];
    }
  }

  static Future<void> addProductToCart(String productId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_cartKey)) {
      await _createCart();
    }
    List<Map<String, dynamic>> cart = await getCart();
    int existingIndex = cart.indexWhere((item) => item['id'] == productId);
    if (existingIndex != -1) {
      cart[existingIndex]['quantity'] += 1;
    } else {
      cart.add({'id': productId, 'quantity': 1});
    }
    cartController.update_count(await getTotalQuantityInCart(cart));
    await _saveCart(cart);
  }

  static Future<String> getCartJson() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cartString = prefs.getString(_cartKey);
    if (cartString != null) {
      return cartString;
    } else {
      return '[]'; // Retorna un JSON vacío si no hay datos en el carrito
    }
  }

  static Future<void> removeProductFromCart(String productId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_cartKey)) {
      return;
    }

    List<Map<String, dynamic>> cart = await getCart();
    int existingIndex = cart.indexWhere((item) => item['id'] == productId);
    if (existingIndex != -1) {
      cart[existingIndex]['quantity'] -= 1;
      if (cart[existingIndex]['quantity'] <= 0) {
        cart.removeAt(existingIndex);
      }
      cartController.update_count(await getTotalQuantityInCart(cart));
      await _saveCart(cart);
    }
  }

  static Future<void> _createCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cartKey, json.encode([]));
  }

  static Future<void> _saveCart(List<Map<String, dynamic>> cart) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cartKey, json.encode(cart));
  }

  static Future<int> getTotalQuantityInCart(List<Map<String, dynamic>> cart) async {
    print(cart);
    num totalQuantity = 0;
    for (var item in cart) {
      totalQuantity += item['quantity'];
    }
    int res = totalQuantity.toInt();
    return res;
  }

  static Future<void> clearCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
    cartController.update_count(0); // Actualizar el contador a cero
  }

}
