import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyectoflutterv1/constantes/Constantes.dart';
import 'package:proyectoflutterv1/models/VO/FotosProductoVO.dart';
import 'package:proyectoflutterv1/models/VO/PublicacionProductoVO.dart';
import 'package:proyectoflutterv1/models/VO/UsuarioVO.dart';
import 'package:proyectoflutterv1/views/Publicacion/MisPublicaciones/ActualizarFotosPublicacion.dart';
import 'package:proyectoflutterv1/views/Publicacion/NuevaPublicacion/FotoProducto.dart';
import 'package:page_transition/page_transition.dart';

//Abre un cuadro de diálogo para que el usuario selección una de las opciones: galería o cámara
Future<void> optionDialogBox(
    {required FotosProductoVO fotosProducto,
    required BuildContext context,
    required UsuarioVO usuario,
    required PublicacionProductoVO publicacion,
    bool actualizacion = false}) {
  return showModalBottomSheet(
      barrierColor: Colors.transparent,
      backgroundColor: COLOR_BACKGROUND_DIALOG,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0))),
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 20.0)),
            ListTile(
              leading: new Icon(Icons.photo_camera,
                  color: COLOR_TEXTO_DIALOG, size: 30),
              title: new Text('Tomar una foto',
                  style: TextStyle(
                      color: COLOR_TEXTO_DIALOG,
                      fontSize: 20,
                      fontFamily: FONTFAMILY_TEXTO)),
              onTap: () {
                openCamera(
                    fotosProducto: fotosProducto,
                    context: context,
                    usuario: usuario,
                    publicacion: publicacion,
                    actualizacion: actualizacion);
              },
            ),
            ListTile(
              leading: new Icon(Icons.photo_album_sharp,
                  color: COLOR_TEXTO_DIALOG, size: 30),
              title: new Text('Cargar imagen desde galería',
                  style: TextStyle(
                      color: COLOR_TEXTO_DIALOG,
                      fontSize: 20,
                      fontFamily: FONTFAMILY_TEXTO)),
              onTap: () {
                openGallery(
                    fotosProducto: fotosProducto,
                    context: context,
                    usuario: usuario,
                    actualizacion: actualizacion,
                    publicacion: publicacion);
              },
            ),
            SizedBox(height: 30)
          ],
        );
      });
}

//Abre la app de la camara
Future<void> openCamera(
    {required FotosProductoVO? fotosProducto,
    required BuildContext context,
    required UsuarioVO usuario,
    required PublicacionProductoVO publicacion,
    bool isPushContext = true,
    bool actualizacion = false}) async {
  final ImagePicker _picker = ImagePicker();
  final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 350,
      maxHeight: 350,
      imageQuality: 50);
  if (fotosProducto!.listaFotos == null) {
    fotosProducto.listaFotos = [];
  }

  if (photo != null) {
    fotosProducto.listaFotos!.add(photo);

    fotosProducto = FotosProductoVO(listaFotos: fotosProducto.listaFotos);
    derivaAPagina(
        isPushContext: isPushContext,
        context: context,
        fotosProducto: fotosProducto,
        usuario: usuario,
        publicacion: publicacion,
        actualizacion: actualizacion);
  }
}

//Abre la galería de imágenes del smartphone
Future<void> openGallery(
    {required FotosProductoVO fotosProducto,
    required BuildContext context,
    required UsuarioVO usuario,
    required PublicacionProductoVO publicacion,
    bool isPushContext = true,
    bool actualizacion = false}) async {
  final ImagePicker _picker = ImagePicker();
  final XFile? photo = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 350,
      maxHeight: 350,
      imageQuality: 50);
  if (fotosProducto.listaFotos == null) {
    fotosProducto.listaFotos = [];
  }
  if (photo != null) {
    fotosProducto.listaFotos!.add(photo);
    fotosProducto = FotosProductoVO(listaFotos: fotosProducto.listaFotos);
    derivaAPagina(
        isPushContext: isPushContext,
        context: context,
        fotosProducto: fotosProducto,
        usuario: usuario,
        publicacion: publicacion,
        actualizacion: actualizacion);
  }
}

//Si la llamada corresponde a una actualización derivará a la página ActualizarFotosPublicacion, de
//lo contrario a FotoProducto
void derivaAPagina(
    {required bool isPushContext,
    required BuildContext context,
    required FotosProductoVO fotosProducto,
    required UsuarioVO usuario,
    required PublicacionProductoVO publicacion,
    bool actualizacion = false}) {
  actualizacion
      ? isPushContext
          ? Navigator.push(
              context,
              PageTransition(
                  ctx: context,
                  type: PageTransitionType.fade,
                  alignment: Alignment.center,
                  child: ActualizarFotosPublicacion(
                      fotosProducto: fotosProducto,
                      usuario: usuario,
                      publicacion: publicacion)))
          : Navigator.pop(context)
      : isPushContext
          ? Navigator.push(
              context,
              PageTransition(
                  ctx: context,
                  type: PageTransitionType.fade,
                  alignment: Alignment.center,
                  child: FotoProducto(
                      fotosProducto: fotosProducto,
                      usuario: usuario,
                      publicacion: publicacion)))
          : Navigator.pop(context);
}
