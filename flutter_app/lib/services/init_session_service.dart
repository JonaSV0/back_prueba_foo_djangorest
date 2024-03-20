import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyect_footloose/constantes.dart';
import 'package:proyect_footloose/models/token_access.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>> login(String username, String password) async {
  final url = URL_SERVER + 'users/api/login'; // Reemplaza con la URL de tu API
  print(username + " | " + password);
  final response = await http.post(
    Uri.parse(url),
    body: {'username': username, 'password': password},
  );

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);

    final accessToken = AccessToken.fromJson(responseData);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', accessToken.token);
    prefs.setString('username', username);
    prefs.setString('password', password);
    prefs.setBool('auto_init', true);

    return {'success': true, 'message': 'Login successful'};
  } else {
    return {'success': false, 'message': response.body };
  }
}

Future<Map<String, dynamic>> update_token(String token) async {
  final url = URL_SERVER + 'users/api/update_token'; // Reemplaza con la URL de tu API
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token_user = prefs.getString('token') ?? '';

  final response = await http.post(
    Uri.parse(url),
    headers: {'Authorization': 'Bearer $token_user'},
    body: {'token': token},

  );

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token_notification', token);


    return {'success': true, 'message': 'Token Actualizado'};
  } else {
    return {'success': false, 'message': response.body };
  }
}