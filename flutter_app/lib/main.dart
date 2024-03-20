import 'package:flutter/material.dart';
import 'package:proyect_footloose/screens/init.dart';
//import 'package:proyect_footloose/screens/init.dart';
//import 'package:proyect_footloose/screens/init_session.dart';
//import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:proyect_footloose/utils/cart_notification.dart';
void main() => runApp(
    MiApp());

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    //debugPaintSizeEnabled = true;
    return GetMaterialApp(
      title: "App Prueba",
      home: const Init(),
      initialBinding: BindingsBuilder(() {
        Get.put(CartController());
      }),
    );
  }
}
