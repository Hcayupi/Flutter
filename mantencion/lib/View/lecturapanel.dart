import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mantencion/Drawer/buttondrawer.dart';
import 'package:mantencion/Model/maquina.dart';
import 'package:mantencion/View/detalle_maquina.dart';
import 'package:mantencion/constantes/colorgenerico.dart';
import 'package:mantencion/constantes/constantes.dart';

class LecturaPanel extends StatefulWidget {
  final Maquina maquina;

  const LecturaPanel({Key? key, required this.maquina}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LecturaPanelState();
}

class LecturaPanelState extends State<LecturaPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(20),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
              const Text(
                "Lectura de panel",
                style:
                    TextStyle(color: ColorGenerico.titulopagina, fontSize: 30),
              ),
              const SizedBox(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                const Flexible(
                    child: Text(
                  "Lectura inicial: ",
                  style: TextStyle(
                      color: ColorGenerico.titulopagina, fontSize: 27),
                )),
                Flexible(
                    child: TextFormField(
                        textAlign: TextAlign.end,
                        decoration: const InputDecoration(counterText: ''),
                        maxLength: 6,
                        initialValue: "0",
                        style: const TextStyle(fontSize: 27)))
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                const Flexible(
                    child: Text(
                  "Sumar: ",
                  style: TextStyle(
                      color: ColorGenerico.titulopagina, fontSize: 25),
                )),
                Flexible(
                    child: TextFormField(
                        textAlign: TextAlign.end,
                        decoration: const InputDecoration(counterText: ''),
                        maxLength: 6,
                        initialValue: "0",
                        style: const TextStyle(fontSize: 27)))
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                const Flexible(
                    child: Text(
                  "Próxima mantención: ",
                  style: TextStyle(
                      color: ColorGenerico.titulopagina, fontSize: 25),
                )),
                Flexible(
                    child: TextFormField(
                        textAlign: TextAlign.end,
                        decoration: const InputDecoration(counterText: ''),
                        maxLength: 6,
                        initialValue: "0",
                        style: const TextStyle(fontSize: 27)))
              ]),
              const SizedBox(height: 40),
              Row(children: <Widget>[
                Flexible(
                    child: ButtonDrawer(
                  color: Colors.red,
                  titulo: etiquetaBotonCancelar,
                  onChangedCallback: () {
                    Navigator.pop(
                      context,
                      CupertinoPageRoute<void>(
                          builder: (BuildContext context) =>
                              DetalleMaquina(maquina: widget.maquina)),
                    );
                  },
                )),
                const SizedBox(width: 4),
                Flexible(
                    child: ButtonDrawer(
                  titulo: etiquetaBotonSiguiente,
                  onChangedCallback: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute<void>(
                          builder: (BuildContext context) =>
                              LecturaPanel(maquina: widget.maquina)),
                    );
                  },
                ))
              ])
            ])));
  }
}
