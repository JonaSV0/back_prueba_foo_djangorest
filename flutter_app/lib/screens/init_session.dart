import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyect_footloose/controllers/login_controller.dart';
import 'package:proyect_footloose/screens/main_principal.dart';
import 'package:proyect_footloose/services/init_session_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:proyect_footloose/apis/firebase_api.dart';

class InitSession extends StatelessWidget {
  const InitSession({super.key});

  @override
  Widget build(BuildContext context) {

    final LoginController loginController = Get.put(LoginController());
    return Scaffold(
      body: cuerpo(context, loginController),
    );
  }
}

Widget cuerpo(BuildContext context, LoginController loginController){
  return Container(
    decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage("https://static.vecteezy.com/system/resources/previews/030/314/096/large_2x/abstract-dark-background-with-purple-luminous-hexagons-technology-neon-vertical-mobile-wallpaper-ai-generated-free-photo.jpg"),
            fit: BoxFit.cover
        )
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: <Widget>[
          nombre(),
          campoUsuario(loginController),
          campoContrasena(loginController),
          buttonInitSession(context, loginController)
        ],
      ),

    ),
  );
}

Widget nombre(){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
    child: Text("Sign In", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
  );
}

Widget campoUsuario(LoginController loginController){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
    child: TextField(
      controller: loginController.usernameController,
      decoration: InputDecoration(
        hintText: "User",
        fillColor: Colors.white.withOpacity(0.85),
        filled: true,
      ),
      cursorColor: Colors.purple,
    ),
  );
}

Widget campoContrasena(LoginController loginController){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    child: TextField(
      controller: loginController.passwordController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Contraseña",
        fillColor: Colors.white.withOpacity(0.85),
        filled: true,
      ),
      cursorColor: Colors.purple,
    ),
  );
}

Widget buttonInitSession(BuildContext context, LoginController loginController){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
    child: ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white.withOpacity(0.90)),
          shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
          )),
          side: MaterialStatePropertyAll(BorderSide.none)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.gpp_good_outlined),
          SizedBox(width: 10.0),
          Text("Iniciar Session 2", style: TextStyle(fontSize: 17.0),)
        ],
      ),
      onPressed: () async {
        if (loginController.username.isEmpty || loginController.password.isEmpty) {

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Por favor, ingresa tu usuario y contraseña.'),
            backgroundColor: Colors.red,
          ));
        } else {

          final result = await login(loginController.username, loginController.password);
          if (result['success']) {
            WidgetsFlutterBinding.ensureInitialized();
            await Firebase.initializeApp(
                options: const FirebaseOptions(
                  apiKey: "AIzaSyBJlWN2R5AtsfbcsLh2j1B8yM44ELQclsg",
                  appId: "1:1018553318562:android:653320b79e479bb4a56bfb",
                  messagingSenderId: "1018553318562",
                  projectId: "flutter-notification-fe2f3",
                  storageBucket: "flutter-notification-fe2f3.appspot.com",
                )
            );
            String? token = await FirebaseApi().initNotifications();
            print(token);

            Map<String, dynamic> result = await update_token(token!);
            print(result);

            bool success = result['success'];
            String message = result['message'];

            if (success){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(message),
                backgroundColor: Colors.green,
              ));
            }else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(message),
                backgroundColor: Colors.red,
              ));
            }

            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainScreen()));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(result['message']),
              backgroundColor: Colors.red,
            ));
          }
        }
      }
    ),
  );
}
