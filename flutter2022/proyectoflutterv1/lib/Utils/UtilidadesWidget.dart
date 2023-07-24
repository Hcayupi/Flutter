import 'package:flutter/material.dart';
import 'package:proyectoflutterv1/constantes/Constantes.dart';
import 'package:proyectoflutterv1/Utils/UtilitadadesFuture.dart';
import 'package:proyectoflutterv1/models/VO/FotosProductoVO.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyectoflutterv1/models/VO/PublicacionProductoVO.dart';
import 'package:proyectoflutterv1/models/VO/UsuarioVO.dart';

Widget getFloatingActionButton(
    FotosProductoVO fotosProducto,
    List<XFile?> listaFotos,
    BuildContext context,
    UsuarioVO usuario,
    bool isPushContext,
    bool actualizacion,
    PublicacionProductoVO publicacion) {
  return isPushContext
      ? FloatingActionButton.extended(
          icon: Icon(Icons.sell_sharp),
          backgroundColor: COLOR_FONDO_BOTON_FLOTANTE,
          label: Text("Publicar"),
          onPressed: () {
            optionDialogBox(
                fotosProducto: fotosProducto,
                context: context,
                usuario: usuario,
                publicacion: publicacion,
                actualizacion: actualizacion);
          },
          splashColor: COLOR_PRESS_FLOAT_BUTTON)
      : FloatingActionButton(
          backgroundColor: COLOR_FONDO_BOTON_FLOTANTE,
          child: const Icon(Icons.add),
          tooltip: 'Cargar otra imagen',
          onPressed: () {
            optionDialogBox(
                fotosProducto: fotosProducto,
                context: context,
                usuario: usuario,
                publicacion: publicacion,
                actualizacion: actualizacion);
          });
}

Widget getTractorLoading() {
  return Center(
      child: Container(
    decoration:
        BoxDecoration(shape: BoxShape.circle, color: Colors.green.shade300),
    width: 150,
    height: 150,
    child: CircleAvatar(
        backgroundColor: Colors.green.shade200,
        backgroundImage: AssetImage(IMAGEN_TIPO_LOADING)),
  ));
}

Widget getLoagingLinea() {
  return LinearProgressIndicator(
      backgroundColor: Colors.white, minHeight: 3, color: Colors.green);
}
