import 'package:flutter/material.dart';
import 'package:proyectoflutterv1/constantes/Constantes.dart';

showMessageError(BuildContext context, String texto) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red.shade400,
      content: Text(texto,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 17, fontFamily: FONTFAMILY_TEXTO))));
}

showMessageSuccess(BuildContext context, String texto) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red.shade400,
      content: Text(texto,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 17, fontFamily: FONTFAMILY_TEXTO))));
}

showDialogError(String titulo, String mensaje, BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: new Text(titulo, textAlign: TextAlign.center),
            content: new Text(mensaje),
            actions: <Widget>[
              new ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: new Text("Cerrar"))
            ]);
      });
}
