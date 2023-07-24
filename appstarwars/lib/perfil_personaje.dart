import 'package:flutter/material.dart';

class PerfilPersonaje extends StatefulWidget {
  const PerfilPersonaje({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PerfilPersonajeState();
}

class PerfilPersonajeState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/fondo.jpeg'), fit: BoxFit.cover)),
      ),
      Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 500,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 249, 246, 246),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            margin: const EdgeInsets.only(left: 5, right: 5),
          ))
    ]));
  }
}
