import 'package:flutter/material.dart';
import 'package:proyectoflutterv1/constantes/Constantes.dart';

InputDecoration decoracionInputTextFormField(String label) {
  return InputDecoration(
      label: Text(
        label,
        style: TextStyle(fontFamily: FONTFAMILY_LABEL_INPUT),
      ),
      errorStyle: TextStyle(
          fontSize: 14,
          fontFamily: FONTFAMILY_LABEL_INPUT,
          color: Colors.orange.shade100),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: COLOR_BORDE_INPUT_FOCUSED),
          borderRadius:
              BorderRadius.all(Radius.circular(RADIUS_CONTENEDOR + 5))),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: COLOR_BORDE_INPUT_FOCUSED),
          borderRadius:
              BorderRadius.all(Radius.circular(RADIUS_CONTENEDOR + 5))),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: EdgeInsets.symmetric(
          vertical: EDGEINSETS_INPUT_VERTICAL,
          horizontal: EDGEINSETS_INPUT_HORIZONTAL),
      filled: true,
      fillColor: Colors.green.shade50,
      counterText: "",
      errorText: "",
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
          borderRadius:
              BorderRadius.all(Radius.circular(RADIUS_CONTENEDOR + 5))));
}

InputDecoration decoracionInputDropDown(String label) {
  return InputDecoration(
    label: Text(
      label,
      style: TextStyle(fontFamily: FONTFAMILY_LABEL_INPUT),
    ),
    errorStyle: TextStyle(
        fontSize: 14,
        fontFamily: FONTFAMILY_LABEL_INPUT,
        color: Colors.orange.shade100),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: COLOR_BORDE_INPUT_FOCUSED),
        borderRadius: BorderRadius.all(Radius.circular(RADIUS_CONTENEDOR + 5))),
    focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: COLOR_BORDE_INPUT_FOCUSED),
        borderRadius: BorderRadius.all(Radius.circular(RADIUS_CONTENEDOR + 5))),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    contentPadding: EdgeInsets.symmetric(
        vertical: EDGEINSETS_INPUT_VERTICAL,
        horizontal: EDGEINSETS_INPUT_HORIZONTAL),
    border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green),
        borderRadius: BorderRadius.all(Radius.circular(RADIUS_CONTENEDOR + 5))),
    filled: true,
    fillColor: Colors.green.shade50,
    errorText: "",
  );
}
