import 'package:flutter/material.dart';
import 'package:proyectoflutterv1/constantes/Constantes.dart';

class MaterialButtonGlobalView extends StatelessWidget {
  final Function onChangedCallback;

  final String label;

  const MaterialButtonGlobalView(
      {Key? key, required this.onChangedCallback, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: COLOR_BUTTON_TIPO,
          minimumSize: Size(SIZE_BUTTON_WIDTH, SIZE_BUTTON_HIGHT),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(RADIUS_BOTON),
          ),
        ),
        onPressed: () {
          this.onChangedCallback();
        },
        child: Text(label,
            style: TextStyle(
              color: COLOR_TEXT_BUTTON_TIPO,
              fontFamily: FONTFAMILY_TEXTO_BUTTON,
              fontSize: SIZE_LABEL_BUTTON,
              fontWeight: FontWeight.w400,
            )));
  }
}
