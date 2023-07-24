import 'package:flutter/material.dart';
import 'package:proyectoflutterv1/Utils/Validadores.dart';
import 'package:proyectoflutterv1/constantes/Constantes.dart';
import 'package:proyectoflutterv1/views/estilos/StyleFroms.dart';

Widget inputTextFormField(TextEditingController txtController, String label,
    {required bool tecladoNumber, int? maxLines, bool readOnly = false}) {
  if (maxLines != null) {
    return new TextFormField(
        controller: txtController,
        maxLines: maxLines,
        maxLength: 200,
        readOnly: readOnly,
        style: TextStyle(
            fontFamily: FONTFAMILY_LABEL_INPUT,
            fontWeight: FontWeight.w400,
            fontSize: SIZE_LABEL_INPUT,
            color: COLOR_LABEL_INPUT),
        decoration: decoracionInputTextFormField(label),
        validator: (value) =>
            validarIngresoFormulario(value, label.toString()));
  } else
    return new TextFormField(
        keyboardType:
            tecladoNumber ? TextInputType.phone : TextInputType.streetAddress,
        controller: txtController,
        maxLength: caracteresMaximos(label),
        readOnly: readOnly,
        style: TextStyle(
            fontFamily: FONTFAMILY_LABEL_INPUT,
            fontWeight: FontWeight.w400,
            fontSize: SIZE_LABEL_INPUT,
            color: COLOR_LABEL_INPUT),
        decoration: decoracionInputTextFormField(label),
        validator: (value) =>
            validarIngresoFormulario(value, label.toString()));
}

Widget inputTextFormFieldPass(TextEditingController txtController, String label,
    {required bool tecladoNumber, int? maxLines, bool readOnly = false}) {
  return new TextFormField(
      obscureText: true,
      keyboardType:
          tecladoNumber ? TextInputType.phone : TextInputType.streetAddress,
      controller: txtController,
      maxLength: caracteresMaximos(label),
      readOnly: readOnly,
      style: TextStyle(
          fontFamily: FONTFAMILY_LABEL_INPUT,
          fontWeight: FontWeight.w400,
          fontSize: SIZE_LABEL_INPUT,
          color: COLOR_LABEL_INPUT),
      decoration: decoracionInputTextFormField(label),
      validator: (value) => validarIngresoFormulario(value, label.toString()));
}

TextStyle estiloInputTextFormField() {
  return TextStyle(
      fontFamily: FONTFAMILY_LABEL_INPUT,
      color: COLOR_LABEL_INPUT,
      fontSize: SIZE_LABEL_INPUT);
}

Widget agregarEtiquetaInput(String label) {
  return Container(
      margin: EdgeInsets.only(left: 10),
      alignment: Alignment.centerLeft,
      child: Text(label,
          style: TextStyle(color: Colors.green.shade100, fontSize: 18)));
}

Widget iconoLista() {
  return Icon(Icons.arrow_downward_outlined, color: COLOR_FLECHA_HACIA_ABAJO);
}
