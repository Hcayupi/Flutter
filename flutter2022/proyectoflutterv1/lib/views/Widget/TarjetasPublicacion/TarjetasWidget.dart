import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyectoflutterv1/Enum/EstadoPublicacion.dart';
import 'package:proyectoflutterv1/Utils/Utilidades.dart';
import 'package:proyectoflutterv1/constantes/Constantes.dart';
import 'package:proyectoflutterv1/models/CargaData/ProfileBD.dart';
import 'package:proyectoflutterv1/models/CargaData/PublicacionBD.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proyectoflutterv1/models/VO/FotosProductoVO.dart';
import 'package:proyectoflutterv1/models/VO/PublicacionProductoVO.dart';
import 'package:proyectoflutterv1/models/VO/UsuarioVO.dart';
import 'package:proyectoflutterv1/views/ModuloTienda/InformacionPublicacionView.dart';
import 'package:proyectoflutterv1/views/Publicacion/MisPublicaciones/ActualizarFotosPublicacion.dart';

/// Contruye un Widget Card que contiene la información de una publicación Abierta
/// dentro de un FutureBuilder que carga la imagen de la publicación
///
Widget tarjetaPublicacion(
    {required PublicacionProductoVO publicacionVO,
    required UsuarioVO usuarioPerfilVO,
    required BuildContext context}) {
  return FutureBuilder(
      future:
          ProfileBD.instance.cargarDatosUsuario(publicacionVO.rut.toString()),
      builder: (BuildContext context, AsyncSnapshot<UsuarioVO> datosUsuario) {
        return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (BuildContext context) =>
                          InformacionPublicacionView(
                              publicacion: publicacionVO,
                              usuarioPublicacion:
                                  datosUsuario.data as UsuarioVO,
                              usuarioPerfil: usuarioPerfilVO)));
            },
            child: Card(
                margin: EdgeInsets.all(5),
                elevation: 10,
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: 120,
                            height: 130,
                            child: _cuadroImagenPublicacion(publicacionVO)),
                        Expanded(
                            child: Container(
                                height: 130,
                                margin: EdgeInsets.only(left: 5, right: 1),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      _tituloPublicacion(
                                          publicacionVO, context),
                                      SizedBox(height: 3),
                                      _precioPublicacion(
                                          publicacionVO, context),
                                      datosUsuario.data != null
                                          ? Text(
                                              _getUbicacion(datosUsuario.data
                                                  as UsuarioVO),
                                              overflow: TextOverflow.ellipsis)
                                          : Text(""),
                                      SizedBox(height: 3),
                                      _pieDeTarjeta(publicacionVO, context)
                                    ])))
                      ],
                    ),
                  )
                ])));
      });
}

Widget _pieDeTarjeta(PublicacionProductoVO publicacion, BuildContext context) {
  return Container(
      //  width: 280,
      child: Row(
    children: <Widget>[
      Text(
        formatearFecha(publicacion.fechaInicio),
        style: TextStyle(color: Colors.green.shade800),
      ),
      Spacer(),
      Text(
        publicacion.condicionVenta,
        style: TextStyle(color: Colors.orange.shade800),
      ),
    ],
  ));
}

Widget _precioPublicacion(
    PublicacionProductoVO publicacion, BuildContext context) {
  return Container(
      child: Text.rich(
    TextSpan(
        text: "\$" + formatearCifra(publicacion.precio.toString()),
        style: TextStyle(
            color: Colors.red,
            fontFamily: FONTFAMILY_TEXTO_PUBL,
            fontSize: SIZE_TEXT_TITULO_PUBL + 7,
            fontWeight: FontWeight.bold),
        children: [
          TextSpan(
              text: " / ",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: FONTFAMILY_TEXTO_PUBL,
                  fontSize: SIZE_TEXT_TITULO_PUBL - 5,
                  fontWeight: FontWeight.bold)),
          TextSpan(
              text: publicacion.unidad,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: FONTFAMILY_TEXTO_PUBL,
                  fontSize: SIZE_TEXT_TITULO_PUBL - 5,
                  fontWeight: FontWeight.bold))
        ]),
    textAlign: TextAlign.left,
  ));
}

Widget _tituloPublicacion(
    PublicacionProductoVO publicacion, BuildContext context) {
  return Container(
      height: 55,
      color: COLOR_FONDO_TITULO_TARJETA,
      alignment: Alignment.center,
      child: Text(publicacion.titulo,
          style: TextStyle(
              fontFamily: FONTFAMILY_TEXTO_PUBL,
              fontSize: SIZE_TEXT_TITULO_PUBL,
              fontWeight: FontWeight.bold),
          maxLines: 2,
          softWrap: false,
          overflow: TextOverflow.ellipsis));
}

String _getUbicacion(UsuarioVO? usuarioVO) {
  if (usuarioVO != null) {
    return usuarioVO.region + ", " + usuarioVO.comuna;
  }
  return "";
}

Widget tarjetaPublicacionUsuario(
    {required PublicacionProductoVO publicacion,
    required UsuarioVO usuarioPublicacion,
    required EstadoPublicacion estadoPublicacion,
    required BuildContext context}) {
  return Card(
      margin: EdgeInsets.all(5),
      elevation: 10,
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Flexible(
            child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: 100,
                  height: 100,
                  child: _cuadroImagenPublicacion(publicacion)),
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _tituloPublicacion(publicacion, context),
                            SizedBox(height: 10),
                            Text("Publicada el: " +
                                formatearFecha(publicacion.fechaInicio)),
                            SizedBox(height: 2),
                            Text("Última edición: " +
                                formatearFecha(publicacion.fechaModificacion)),
                          ]))),
            ],
          ),
        )),
        Container(
            margin: EdgeInsets.only(top: 5),
            color: Color(0xfffef2da),
            height: 32,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  estadoPublicacion == EstadoPublicacion.ABIERTA
                      ? _opcionesTarjetasTabPubAbiertas(
                          publicacion, usuarioPublicacion, context)
                      : estadoPublicacion == EstadoPublicacion.CERRADA
                          ? _opcionesTarjetasTabPubCerradas(publicacion)
                          : SizedBox(height: 0)
                ]))
      ]));
}

Widget _cuadroImagenPublicacion(PublicacionProductoVO publicacion) {
  if (publicacion.imagenprevia != "null" && publicacion.imagenprevia != "") {
    return Image.network(
      publicacion.imagenprevia.toString(),
      width: SIZE_WITH_IMG_PUBLIC,
      // height: SIZE_HEIGHT_IMG_PUBLIC,
      fit: BoxFit.fill,
    );
  }
  return _imagenDefault();
}

/*Future<Widget> _cuadroImagenPublicacion(
    PublicacionProductoVO publicacion) async {
  if (publicacion.imagenprevia != "null" && publicacion.imagenprevia != "") {
    http.Response response =
        await http.get(Uri.parse(publicacion.imagenprevia.toString()));
    if (response.statusCode == 200)
      return FadeInImage.assetNetwork(
          placeholder: IMAGEN_LOADING,
          image: publicacion.imagenprevia.toString(),
          width: SIZE_WITH_IMG_PUBLIC,
          height: SIZE_HEIGHT_IMG_PUBLIC,
          fit: BoxFit.fill);
  }
  return _imagenDefault();
}*/

Widget _opcionesTarjetasTabPubAbiertas(PublicacionProductoVO publicacion,
    UsuarioVO usuario, BuildContext context) {
  return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
    TextButton.icon(
      style: TextButton.styleFrom(primary: Colors.green.shade400),
      icon: Icon(Icons.edit),
      label: Text('Editar'),
      onPressed: () {
        Navigator.push(
            context,
            PageTransition(
                duration: const Duration(milliseconds: 400),
                ctx: context,
                type: PageTransitionType.rightToLeft,
                child: ActualizarFotosPublicacion(
                    fotosProducto: new FotosProductoVO(),
                    usuario: usuario,
                    publicacion: publicacion)));
      },
    ),
    TextButton.icon(
      style: TextButton.styleFrom(primary: Colors.orange.shade400),
      icon: Icon(Icons.close),
      label: Text('Cerrar'),
      onPressed: () {
        PublicacionBD.instance.cerrarPublicacionBD(publicacion);
      },
    ),
    TextButton.icon(
      style: TextButton.styleFrom(primary: Colors.redAccent),
      icon: Icon(Icons.delete),
      label: Text('Eliminar'),
      onPressed: () {
        PublicacionBD.instance.eliminacionLogicaPublicacionBD(publicacion);
      },
    ),
    const SizedBox(width: SIZEBOX_PUBL),
  ]);
}

Widget _opcionesTarjetasTabPubCerradas(PublicacionProductoVO publicacion) {
  return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
    TextButton.icon(
      style: TextButton.styleFrom(primary: Colors.green),
      icon: Icon(Icons.check_circle),
      label: Text('Publicar nuevamente'),
      onPressed: () {
        PublicacionBD.instance.reabrirPublicacionBD(publicacion);
      },
    ),
    const SizedBox(width: SIZEBOX_PUBL),
  ]);
}

Widget _imagenDefault() {
  return Image.asset(
    IMAGEN_TIPO_PUBLICACION,
    width: SIZE_WITH_IMG_PUBLIC,
    height: SIZE_HEIGHT_IMG_PUBLIC,
    fit: BoxFit.fill,
  );
}
