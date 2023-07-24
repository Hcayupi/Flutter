import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proyectoflutterv1/Utils/Mensajes.dart';
import 'package:proyectoflutterv1/constantes/Constantes.dart';
import 'package:proyectoflutterv1/models/CargaData/PublicacionBD.dart';
import 'package:proyectoflutterv1/models/VO/FotosProductoVO.dart';
import 'package:proyectoflutterv1/models/VO/PublicacionProductoVO.dart';
import 'package:proyectoflutterv1/models/VO/UsuarioVO.dart';
import 'package:proyectoflutterv1/views/ModuloTienda/AgroMercado.dart';
import 'package:proyectoflutterv1/views/Widget/AppBar/AppBarWidget.dart';
import 'package:proyectoflutterv1/views/Widget/Drawer/Drawer.dart';
import 'package:proyectoflutterv1/views/Widget/FotoView/GestureDetectorView.dart';

import 'DetallePublicacion.dart';

class FotoProducto extends StatefulWidget {
  final UsuarioVO usuario;
  final FotosProductoVO fotosProducto;
  final PublicacionProductoVO publicacion;

  FotoProducto(
      {required this.fotosProducto,
      required this.usuario,
      required this.publicacion,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      FotoCaptura(this.fotosProducto, this.usuario, this.publicacion);
}

class FotoCaptura extends State<FotoProducto> {
  late List<XFile?> _listaImagenes = [];
  FotosProductoVO _fotosProductos;
  PublicacionProductoVO _publicacion;
  UsuarioVO _usuario;
  bool _existeFoto = false;

  FotoCaptura(this._fotosProductos, this._usuario, this._publicacion);

  @override
  void initState() {
    super.initState();

    if (_fotosProductos.listaFotos == null) {
      _fotosProductos = new FotosProductoVO();
      _fotosProductos.listaFotos = _listaImagenes;
      _existeFoto = false;
    } else if (_fotosProductos.listaFotos!.length > 0) {
      _existeFoto = true;
    }
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
          fotosProducto: _fotosProductos),
      resizeToAvoidBottomInset: false,
      body: new Stack(
        children: <Widget>[
          _fotosProductos.listaFotos!.length == 0
              ? Center(
                  child: Text("No se han cargado fotos.",
                      style: TextStyle(
                          color: COLOR_TEXTO_HAY_REGISTROS, fontSize: 20)))
              : GridView.builder(
                  padding: EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: _fotosProductos.listaFotos == null
                      ? 0
                      : _fotosProductos.listaFotos!.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Stack(
                        alignment: Alignment(0.1, 1),
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            child: Image.file(
                                File(_fotosProductos.listaFotos![index]!.path),
                                fit: BoxFit.cover,
                                height: 250,
                                alignment: Alignment.centerLeft),
                            decoration: BoxDecoration(
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
                                  _fotosProductos = PublicacionBD.instance
                                      .eliminarImagenLista(
                                          fotosProducto: _fotosProductos,
                                          index: index);
                                  if (_fotosProductos.listaFotos!.length == 0) {
                                    _existeFoto = false;
                                  }
                                });
                              })
                        ]);
                  })
        ],
      ),
      drawer: getDrawer(
          fotosProductoVO: _fotosProductos,
          listaFotos: _listaImagenes,
          context: context,
          usuario: _usuario),
      /* floatingActionButton: getFloatingActionButton(_fotosProductos,
          _listaImagenes, context, _usuario, false, false, null),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,*/
      bottomNavigationBar: BottomAppBar(
          clipBehavior: Clip.antiAlias,
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
    _fotosProductos = new FotosProductoVO();
    Navigator.push(
        context,
        PageTransition(
            duration: const Duration(milliseconds: 500),
            ctx: context,
            type: PageTransitionType.bottomToTop,
            child: AgroMercado(usuario: this._usuario)));
  }

  void continuarDetallePublicacion() {
    if (!_existeFoto) {
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
              child: DetallePublicacion(
                  fotosProducto: this._fotosProductos,
                  usuario: this._usuario,
                  publicacion: this._publicacion)));
  }
}
