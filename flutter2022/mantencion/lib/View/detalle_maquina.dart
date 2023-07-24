import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mantencion/Model/maquina.dart';
import 'package:mantencion/View/nueva_mantencion.dart';

class DetalleMaquina extends StatefulWidget {
  final Maquina maquina;

  const DetalleMaquina({Key? key, required this.maquina}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DetalleMaquinaState();
}

class DetalleMaquinaState extends State<DetalleMaquina> {
  Color colorFondo = const Color(0xFF0063b2);
  DetalleMaquinaState();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: colorFondo,
        body: Column(children: <Widget>[
          const Padding(padding: EdgeInsets.only(top: 30)),
          Stack(children: <Widget>[
            Center(
                child: Hero(
                    tag: widget.maquina.id.toString(),
                    child: Image.network(
                        "https://i.pinimg.com/564x/5f/ff/81/5fff81701c3271afdfd843d4e80f50d5.jpg")
                    //child: const FlutterLogo(size: 200.0),
                    )),
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 100,
                    width: size.width - 10,
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Nombre: " + widget.maquina.nombre.toString()),
                        Text("Modelo: " + widget.maquina.modelo.toString()),
                        Text("Descripción: " +
                            widget.maquina.descripcion.toString()),
                        Text("Lectura del panel: " +
                            widget.maquina.lecturaPanel.toString()),
                      ],
                    )))
          ]),
          Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        child: ListTile(
                      title: Text("Exemplo: " + index.toString()),
                      subtitle: const Text("Subtitulo de ejemplo"),
                    ));
                  })),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF62b200),
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
          /* Expanded(child: DraggableScrollableSheet(builder:
              (BuildContext context, ScrollController scrollController) {
            return Container(
                color: Colors.transparent,
                child: ListView.builder(
                    controller: scrollController,
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          child: ListTile(
                        title: Text("Exemplo: " + index.toString()),
                        subtitle: const Text("Subtitulo de ejemplo"),
                      ));
                    }));
          }))*/
        ]));
  }
}
