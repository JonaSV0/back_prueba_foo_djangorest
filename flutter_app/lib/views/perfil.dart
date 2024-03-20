import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class PerfilView extends StatefulWidget {
  const PerfilView({super.key});

  @override
  State<PerfilView> createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            color: Colors.purple,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 10.0),
                  child: Text("Perfil", style: TextStyle(fontSize: 30.0, color: Colors.white), textAlign: TextAlign.center),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 10.0),
                  child: Icon(Icons.person, color: Colors.white, size: 30.0,),
                )
              ],
            ),
          ),

          usuario(context),
          correo(context),
          nombres(context),
          apellidos(context)
        ],
      ),
    );
  }
}


Widget usuario(BuildContext context){
  return Column(
    children: [
      Container(
        margin: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 0.0),
        alignment: Alignment.centerLeft,
        child: Text("Usuario", style: TextStyle(color: Colors.purple),),
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(5.0),
        ),
        margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.centerLeft,

        child: Text(""),
      )
    ],
  );
}

Widget correo(BuildContext context){
  return Column(
    children: [
      Container(
        margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
        alignment: Alignment.centerLeft,
        child: Text("Correo", style: TextStyle(color: Colors.purple),),
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(5.0),
        ),
        margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.centerLeft,

        child: Text(""),
      )
    ],
  );
}

Widget nombres(BuildContext context){
  return Column(
    children: [
      Container(
        margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
        alignment: Alignment.centerLeft,
        child: Text("Nombres", style: TextStyle(color: Colors.purple),),
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(5.0),
        ),
        margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.centerLeft,

        child: Text(""),
      )
    ],
  );
}

Widget apellidos(BuildContext context){
  return Column(
    children: [
      Container(
        margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
        alignment: Alignment.centerLeft,
        child: Text("Apellidos", style: TextStyle(color: Colors.purple),),
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(5.0),
        ),
        margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.centerLeft,

        child: Text(""),
      )
    ],
  );
}
