import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:proyect_footloose/screens/init_session.dart';
import 'package:proyect_footloose/screens/main_principal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Init extends StatefulWidget {
  const Init({Key? key}) : super(key: key);

  @override
  _InitState createState() => _InitState();
}

class _InitState extends State<Init> with TickerProviderStateMixin{
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      // Controlador de la animación de escala
      _scaleController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 1),
      );

      // Animación de escala
      _scaleAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: _scaleController,
          curve: Curves.easeInOut,
        ),
      );

      //Iniciar animación
      _scaleController.forward().then((_) {
        verificarUsuario();
      });
    });
    }

    void verificarUsuario() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool? usuario = prefs.getBool('auto_init');

      if (usuario != null && usuario) {
        await Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            transitionDuration: Duration(seconds: 1),
            pageBuilder: (_, __, ___) => FadeTransition(
              opacity: _scaleAnimation,
              child: MainScreen(),
            ),
          ),
        );
      } else {
        // Animación de desvanecimiento
        await Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            transitionDuration: Duration(seconds: 1),
            pageBuilder: (_, __, ___) => FadeTransition(
              opacity: _scaleAnimation,
              child: InitSession(),
            ),
          ),
        );
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cuerpo(context),
    );
  }
}

Widget cuerpo(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: NetworkImage("https://static.vecteezy.com/system/resources/previews/030/314/096/large_2x/abstract-dark-background-with-purple-luminous-hexagons-technology-neon-vertical-mobile-wallpaper-ai-generated-free-photo.jpg"),
        fit: BoxFit.cover,
      ),
    ),
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/5/57/X_logo_2023_%28white%29.png"),
            width: 100.0, // Ajusta el tamaño del logotipo según tus necesidades
          ),
        ],
      ),
    ),
  );
}

