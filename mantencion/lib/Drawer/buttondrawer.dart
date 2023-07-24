import 'package:flutter/material.dart';

class ButtonDrawer extends StatelessWidget {
  final Function onChangedCallback;
  final String titulo;
  final Color color;

  const ButtonDrawer(
      {Key? key,
      this.color = const Color(0xFF62b200),
      required this.titulo,
      required this.onChangedCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: color, minimumSize: const Size(200, 50)),
        onPressed: () {
          onChangedCallback();
        },
        child: Text(titulo, style: const TextStyle(fontSize: 20)));
  }
}
