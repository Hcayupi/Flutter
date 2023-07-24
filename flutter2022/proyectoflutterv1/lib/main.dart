import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyectoflutterv1/views/Inicio_app/ValidaRut.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  /*await FirebaseAppCheck.instance.activate();*/
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  /*static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);*/

  @override
  Widget build(BuildContext context) {
    //Solo muestra barra de botones inferior y oculta la barra superior (señal, estado baterìa...)
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);

    /*PublicacionProductoVO publicacion = new PublicacionProductoVO(
        rut: 166325951,
        titulo: "Venta",
        categoria: "Verduras",
        precio: 4000,
        unidad: "Kilogramos",
        unidadPeso: "Kilogramos",
        peso: 2323,
        condicionVenta: "Previa reservacion",
        detalles: "ASDAD");*/

    return MaterialApp(
        title: 'RuralApp',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        //home: MyHomePage(title: 'Flutter Demo Home Page')

        home: ValidaRut()); //AgroMercado(idUsuario: 16632595)); //Example());
  }
}
