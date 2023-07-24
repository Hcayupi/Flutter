import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Model/maquina.dart';
import '../constantes/colorgenerico.dart';
import '../constantes/const_img.dart';
import 'nueva_mantencion.dart';

class DetalleMaquina extends StatefulWidget {
  final Maquina maquina;

  const DetalleMaquina({Key? key, required this.maquina}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DetalleMaquinaState();
}

class DetalleMaquinaState extends State<DetalleMaquina> {
  DetalleMaquinaState();
  @override
  Widget build(BuildContext context) {
    //final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: ColorGenerico.fondopagina,
        body: Column(children: <Widget>[
          // const Padding(padding: EdgeInsets.only(top: 30)),
          Stack(
            children: [
              Center(
                  child: Hero(
                      tag: widget.maquina.id.toString(),
                      child: Image.asset(ConstImagenes.maquina,
                          scale: 3, fit: BoxFit.cover))),
              Container(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  margin: const EdgeInsets.only(top: 164),
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black.withOpacity(0.4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Nombre: ${widget.maquina.nombre.toString()}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16)),
                      Text("Modelo: ${widget.maquina.modelo.toString()}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16)),
                      Text(
                          "Descripción: ${widget.maquina.descripcion.toString()}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16)),
                      Text(
                          "Lectura del panel: ${widget.maquina.lecturaPanel.toString()}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16)),
                    ],
                  )),
            ],
          ),

          Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        child: ListTile(
                      title: Text("Exemplo:${index.toString()}"),
                      subtitle: const Text("Subtitulo de ejemplo"),
                    ));
                  })),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF62b200),
                          minimumSize: const Size(200, 50)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute<void>(
                            builder: (BuildContext context) =>
                                NuevaMantencion(maquina: widget.maquina),
                          ),
                        );
                      },
                      child: const Text("Nueva mantención",
                          style: TextStyle(fontSize: 20)))))
        ]));
  }
}
