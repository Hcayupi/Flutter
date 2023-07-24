import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proyectoflutterv1/Utils/Mensajes.dart';
import 'package:proyectoflutterv1/Utils/Validadores.dart';
import 'package:proyectoflutterv1/constantes/Constantes.dart';
import 'package:proyectoflutterv1/models/CargaData/PublicacionBD.dart';
import 'package:proyectoflutterv1/models/VO/FotosProductoVO.dart';
import 'package:proyectoflutterv1/models/VO/PublicacionProductoVO.dart';
import 'package:proyectoflutterv1/models/VO/UsuarioVO.dart';
import 'package:proyectoflutterv1/views/ModuloTienda/AgroMercado.dart';
import 'package:proyectoflutterv1/views/Publicacion/MisPublicaciones/EditarPublicacion.dart';
import 'package:proyectoflutterv1/views/Widget/AppBar/AppBarWidget.dart';
import 'package:proyectoflutterv1/views/Widget/Drawer/Drawer.dart';
import 'package:proyectoflutterv1/views/Widget/FotoView/GestureDetectorView.dart';

class ActualizarFotosPublicacion extends StatefulWidget {
  final UsuarioVO usuario;
  final PublicacionProductoVO publicacion;
  final FotosProductoVO fotosProducto;

  ActualizarFotosPublicacion(
      {required this.fotosProducto,
      required this.usuario,
      required this.publicacion,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      ActualizarFotos(this.fotosProducto, this.publicacion, this.usuario);
}

class ActualizarFotos extends State<ActualizarFotosPublicacion> {
  late List<XFile?> _listaImagenes = [];
  PublicacionProductoVO _publicacion;
  FotosProductoVO _fotosProducto;
  UsuarioVO _usuario;
  String _cadenaEspera = "Cargando fotos...";

  ActualizarFotos(this._fotosProducto, this._publicacion, this._usuario);

  @override
  void initState() {
    super.initState();

    if (_fotosProducto.listaFotos == null) {
      _fotosProducto = new FotosProductoVO();
      _fotosProducto.listaFotos = _listaImagenes;

      cargarImagenes();
    }
  }

  void cargarImagenes() async {
    await Future.wait(
            [PublicacionBD.instance.cargarFotosPublicacion(_publicacion)])
        .then((value) {
      if (mounted) {
        print("Montado");
        setState(() {
          _fotosProducto = value[0];
          if (_fotosProducto.listaFotos?.length == 0) {
            _cadenaEspera = "No se han cargado fotos";
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //Solo muestra barra de botones inferior y oculta la barra superior (señal, estado baterìa...)
    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    return Scaffold(
      backgroundColor: COLOR_FONDO_BODY_PAG,
      appBar: getAppBarTituloFoto(
          titulo: "Fotos",
          usuario: _usuario,
          context: context,
          publicacion: _publicacion,
          actualizacion: true,
          fotosProducto: _fotosProducto),
      resizeToAvoidBottomInset: false,
      body: new Stack(
        children: <Widget>[
          _fotosProducto.listaFotos!.length == 0
              ? Center(
                  child: Text(_cadenaEspera,
                      style: TextStyle(
                          color: COLOR_TEXTO_HAY_REGISTROS, fontSize: 20)))
              : GridView.builder(
                  padding: EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: _fotosProducto.listaFotos == null
                      ? 0
                      : _fotosProducto.listaFotos!.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Stack(alignment: Alignment(0.1, 1), children: <
                        Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: existeEnCadena(
                                    _fotosProducto.listaFotos![index]!.path,
                                    "https") >=
                                0
                            ? FadeInImage.assetNetwork(
                                placeholder: IMAGEN_LOADING,
                                image: _fotosProducto.listaFotos![index]!.path,
                                fit: BoxFit.cover,
                                height: 250,
                                alignment: Alignment.centerLeft)
                            : Image.file(
                                File(_fotosProducto.listaFotos![index]!.path),
                                fit: BoxFit.cover,
                                height: 250,
                                alignment: Alignment.centerLeft),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(
                              width: 1,
                              color: Colors.white,
                            )),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFFFF3C00).withOpacity(0.3),
                              minimumSize: Size(180, 40)),
                          child: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              _fotosProducto = PublicacionBD.instance
                                  .eliminarImagenLista(
                                      fotosProducto: _fotosProducto,
                                      index: index);
                              if (_fotosProducto.listaFotos?.length == 0) {
                                _cadenaEspera = "No se han cargado fotos.";
                              }
                            });
                          })
                    ]);
                  }),
        ],
      ),
      drawer: getDrawer(
          fotosProductoVO: _fotosProducto,
          listaFotos: _listaImagenes,
          context: context,
          usuario: _usuario),
      /*floatingActionButton: getFloatingActionButton(_fotosProducto,
          _listaImagenes, context, _usuario, false, true, _publicacion),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,*/
      bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: COLOR_FONDO_APPBAR,
          child: SizedBox(
            height: SIZENAVBAR,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: SIZEBOX_WIDTH + 10),
                Spacer(),
                GestureDetectorView(
                  onTapCall: () => continuarDetallePublicacion(),
                  label: ADELANTE,
                  fontSize: SIZE_TEXT_NAVBAR,
                  direction: TextDirection.rtl,
                  left: false,
                ),
                SizedBox(width: SIZEBOX_WIDTH),
              ],
            ),
          )),
    );
  }

  void regresarAgroMercado() {
    Navigator.push(
        context,
        PageTransition(
            duration: const Duration(milliseconds: 500),
            ctx: context,
            type: PageTransitionType.bottomToTop,
            child: AgroMercado(usuario: this._usuario)));
  }

  void continuarDetallePublicacion() {
    if (_fotosProducto.listaFotos!.isEmpty) {
      showMessageError(
          context, 'Debe añadir por lo menos una imagen de su producto');

      //COLORES cuadroAlertaValidacion("Debe añadir por lo menos una imagen de su producto", "Ok", context);
    } else
      Navigator.push(
          context,
          PageTransition(
              duration: const Duration(milliseconds: 500),
              ctx: context,
              type: PageTransitionType.rightToLeft,
              child: EditarPublicacion(
                  fotosProducto: this._fotosProducto,
                  publicacion: _publicacion,
                  usuario: _usuario)));
  }
}
