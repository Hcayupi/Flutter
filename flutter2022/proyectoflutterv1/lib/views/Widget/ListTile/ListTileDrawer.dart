import 'package:flutter/material.dart';
import 'package:proyectoflutterv1/constantes/Constantes.dart';

class ListTileDrawer extends StatelessWidget {
  final Function onTapCallBack;
  final String label;
  final IconData icono;
  final Color colorIcono;

  ListTileDrawer(
      {required this.onTapCallBack,
      required this.label,
      required this.icono,
      required this.colorIcono});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        // tileColor: Colors.green.shade100,
        leading: Icon(this.icono, size: 20, color: this.colorIcono),
        title: Text(this.label,
            style: TextStyle(
                color: Colors.white,
                fontSize: SIZE_OPCIONES_MENU,
                fontFamily: FONTFAMILY_TITULO_PAGINA)),
        onTap: () => this.onTapCallBack());
  }
}
