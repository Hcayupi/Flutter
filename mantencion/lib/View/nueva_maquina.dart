import 'package:flutter/material.dart';

import '../constantes/const_img.dart';
import 'WidgetsForm/text_form_field_widget.dart';
import 'tarjetas_maquinas.dart';

class NuevaMaquina extends StatefulWidget {
  const NuevaMaquina({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NuevaMaquinaState();
}

class NuevaMaquinaState extends State<NuevaMaquina> {
  TextEditingController controllerNombreMaquina = TextEditingController();
  TextEditingController controllerAgno = TextEditingController();
  TextEditingController controllerModelo = TextEditingController();
  TextEditingController controllerLectura = TextEditingController();
  TextEditingController controllerUnidad = TextEditingController();
  TextEditingController controllerDescripcion = TextEditingController();

  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text("Nueva máquina")),
        body: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.all(20.0),
              child: Form(
                  key: keyForm,
                  child: Column(
                    children: <Widget>[
                      Center(
                          child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.asset(ConstImagenes.maquina,
                                  scale: 5,
                                  fit: BoxFit.fill,
                                  width: 180,
                                  height: 150)),
                          const Center(child: Text("Nuevo tractor")),
                        ],
                      )),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormFieldWidget("Nombre máquina: ",
                          controller: controllerNombreMaquina),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormFieldWidget("Año: ", controller: controllerAgno),
                      TextFormFieldWidget("Modelo: ",
                          controller: controllerModelo),
                      TextFormFieldWidget("Lectura: ",
                          controller: controllerLectura),
                      TextFormFieldWidget("Unidad:",
                          controller: controllerUnidad),
                      TextFormFieldWidget("Descripción: ",
                          controller: controllerDescripcion, numLineas: 3),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                          width: 150,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                guaradarFormulario();

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const TarjetasMaquinas(),
                                  ),
                                );
                              },
                              child: const Text("Guardar")))
                    ],
                  ))),
        ));
  }

  void guaradarFormulario() async {
    /*Maquina nuevaMaquina = Maquina(
        nombre: controllerNombreMaquina.text,
        modelo: controllerModelo.text,
        unidad: controllerUnidad.text,
        descripcion: controllerDescripcion.text,
        agno: int.tryParse(controllerAgno.text) as int,
        lecturaPanel: int.tryParse(controllerLectura.text) as int);*/

    /*Maquina nuevaMaquina2 = const Maquina(
        nombre: "Test",
        modelo: "modelo",
        unidad: "Modelo2123",
        descripcion: "descripcion...",
        agno: 1232,
        lecturaPanel: 1232);*/

    //DatabaseHandler.instance.nuevaMaquina(nuevaMaquina2);
  }
}
