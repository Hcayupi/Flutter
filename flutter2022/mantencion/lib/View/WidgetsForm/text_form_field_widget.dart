import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatefulWidget {
  final String nombreInput;
  final int numLineas;
  final TextEditingController controller;

  const TextFormFieldWidget(this.nombreInput,
      {Key? key, this.numLineas = 1, required this.controller})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => TextFormFieldState();
}

class TextFormFieldState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      maxLines: widget.numLineas,
      decoration: InputDecoration(labelText: widget.nombreInput),
    );
  }
}
