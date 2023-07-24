import 'package:flutter/material.dart';

import 'View/nueva_maquina.dart';
import 'View/tarjetas_maquinas.dart';
import 'constantes/colorgenerico.dart';
import 'constantes/const_ruta.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: ColorGenerico.colorFlutter,
      ),
      initialRoute: ConstRuta.raiz,
      routes: {
        ConstRuta.raiz: (context) => const TarjetasMaquinas(),
        ConstRuta.nuevamaquina: (context) => const NuevaMaquina(),
      },
    );
  }
}
