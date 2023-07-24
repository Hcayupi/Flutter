import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String titulo;
  const Home({required this.titulo, super.key});

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titulo),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Menú'),
            ),
            ListTile(
              title: const Text('Opción 1'),
              onTap: () {
                // Agrega aquí la lógica de la opción 1
              },
            ),
            ListTile(
              title: const Text('Opción 2'),
              onTap: () {
                // Agrega aquí la lógica de la opción 2
              },
            ),
          ],
        ),
      ),
    );
  }
}
