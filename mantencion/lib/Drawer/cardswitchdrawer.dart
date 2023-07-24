import 'package:flutter/material.dart';
import 'package:mantencion/constantes/colorgenerico.dart';

class CardSwitchDrawer extends StatelessWidget {
  final ValueChanged onSetState;
  final String titulo;
  final String subtitulo;
  final bool switchBool;

  const CardSwitchDrawer(
      {Key? key,
      required this.titulo,
      required this.subtitulo,
      required this.switchBool,
      required this.onSetState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        child: SwitchListTile(
          title: Text(
            titulo,
            style: const TextStyle(
                color: Colors.blue, fontWeight: FontWeight.w800, fontSize: 20),
          ),
          value: switchBool,
          activeColor: ColorGenerico.colorActivo,
          inactiveTrackColor: ColorGenerico.colorInactivo,
          onChanged: onSetState,
          secondary: const Icon(Icons.star),
          controlAffinity: ListTileControlAffinity.trailing,
        ));
  }
}
