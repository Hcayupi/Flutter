import 'package:flutter/material.dart';
import 'package:proyectoflutterv1/Utils/Validadores.dart';
import 'package:proyectoflutterv1/constantes/Constantes.dart';
import 'package:proyectoflutterv1/views/Widget/FormulariosView/propiedades/InputsFormularioWidget.dart';
import 'package:proyectoflutterv1/views/estilos/StyleFroms.dart';

class MaterialDropDownView extends StatelessWidget {
  final Function onChangedCallback;
  final String value;
  final String label;
  final Iterable<String> values;

  const MaterialDropDownView(
      {Key? key,
      required this.onChangedCallback,
      required this.value,
      required this.label,
      required this.values})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
        isExpanded: true,
        dropdownColor: Colors.green.shade50,
        decoration: decoracionInputDropDown(this.label),
        value: value,
        icon: iconoLista(),
        iconSize: SIZE_ICON,
        elevation: ELEVATION.toInt(),
        style: estiloInputTextFormField(),
        onChanged: (String? newValue) {
          this.onChangedCallback(newValue);
        },
        items: this.values.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value,
                style: TextStyle(
                    color: Colors.black, fontFamily: FONTFAMILY_LABEL_INPUT)),
          );
        }).toList(),
        validator: (value) => validarIngresoFormulario(value, this.label));
  }
}
