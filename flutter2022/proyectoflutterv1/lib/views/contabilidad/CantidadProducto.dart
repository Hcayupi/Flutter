import 'dart:async';

import 'package:flutter/material.dart';
import 'package:proyectoflutterv1/Utils/Utilidades.dart';
import 'package:proyectoflutterv1/constantes/Constantes.dart';
import 'package:proyectoflutterv1/models/VO/CompraVO.dart';
import 'package:proyectoflutterv1/models/VO/PublicacionProductoVO.dart';
import 'package:proyectoflutterv1/models/VO/UsuarioVO.dart';

import 'package:page_transition/page_transition.dart';
import 'package:proyectoflutterv1/views/ModuloTienda/InformacionPublicacionView.dart';
import 'package:proyectoflutterv1/views/contabilidad/Webpay.dart';

class CantidadProducto extends StatefulWidget {
  final PublicacionProductoVO publicacion;
  final UsuarioVO usuarioPublicacion;
  final UsuarioVO usuarioPerfil;
  final bool reserva;

  CantidadProducto(
      {required this.publicacion,
      required this.usuarioPublicacion,
      required this.usuarioPerfil,
      this.reserva = false});
  @override
  State<StatefulWidget> createState() => CantidadProductoState(this.publicacion,
      this.usuarioPublicacion, this.usuarioPerfil, this.reserva);
}

class CantidadProductoState extends State<CantidadProducto> {
  late PublicacionProductoVO _publicacion;
  late UsuarioVO _usuarioPublicacion;
  late UsuarioVO _usuarioPerfil;

  //TextEditingController _controladorRut = new TextEditingController();
  int _cantidad = 0;
  bool _reserva = false;
  int _total = 0;
  Timer timer = Timer.periodic(Duration(milliseconds: 0), (timer) {});

  TextEditingController _txtControlerCantidad = new TextEditingController();
  TextEditingController _txtControlerTotal = new TextEditingController();
  CantidadProductoState(this._publicacion, this._usuarioPublicacion,
      this._usuarioPerfil, this._reserva);

  @override
  void initState() {
    super.initState();
    _cantidad = 1;
    _txtControlerCantidad.text = _cantidad.toString();
    int precio = _publicacion.precio;
    _total = _cantidad * precio;

    _txtControlerTotal.text = "\$" + _total.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: COLOR_FONDO_BODY_PAG,
        body: Stack(children: [
          SingleChildScrollView(
              //reverse: true,
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                  child: SingleChildScrollView(
                      //reverse: true,
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context)
                              .viewInsets
                              .bottom), //No oculta el TextField cuando se eleva el teclado
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 40),
                          Container(
                              margin: EdgeInsets.all(30),
                              alignment: Alignment.center,
                              child: Text(_publicacion.titulo,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FONTFAMILY_TEXTO))),
                          Container(
                              margin: EdgeInsets.all(30),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: _cargarImagenPrincipal())),
                          _cargarFormularioCantidad(),
                          SizedBox(height: 30),
                          _cargarBotonesInferiores()
                        ],
                      ))))
        ]));
  }

  _cargarFormularioCantidad() {
    return Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: Color(0xFFC0B7B7), spreadRadius: 1, blurRadius: 7),
        ], borderRadius: BorderRadius.circular(10), color: Colors.white),
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(10),
        child: Column(children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("Precio por " + _publicacion.unidad.toLowerCase(),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: FONTFAMILY_TEXTO)),
                Text("\$" + formatearCifra(_publicacion.precio.toString()),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: FONTFAMILY_TEXTO))
              ]),
          SizedBox(height: 20),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 125,
                  child: Text("Cantidad",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: FONTFAMILY_TEXTO)),
                ),
                Text(":",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: FONTFAMILY_TEXTO)),
                GestureDetector(
                    onTap: () {
                      _restarCantidad();
                    },
                    onLongPress: () {
                      timer =
                          Timer.periodic(Duration(milliseconds: 20), (timer) {
                        _restarCantidad();
                      });
                    },
                    onLongPressUp: () {
                      timer.cancel();
                    },
                    onLongPressEnd: (LongPressEndDetails detalles) {
                      timer.cancel();
                    },
                    child: Icon(Icons.arrow_back_ios, size: 20)),
                Container(
                    width: 90,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      readOnly: true,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: FONTFAMILY_TEXTO),
                      keyboardType: TextInputType.number,
                      controller: _txtControlerCantidad,
                    )),
                GestureDetector(
                    onTap: () {
                      _sumarCantidad();
                    },
                    onLongPress: () {
                      timer =
                          Timer.periodic(Duration(milliseconds: 20), (timer) {
                        _sumarCantidad();
                      });
                    },
                    onLongPressUp: () {
                      timer.cancel();
                    },
                    onLongPressEnd: (LongPressEndDetails detalles) {
                      timer.cancel();
                    },
                    child: Icon(Icons.arrow_forward_ios, size: 20)),
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 125,
                  child: Text("Total",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: FONTFAMILY_TEXTO)),
                ),
                Text(":",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: FONTFAMILY_TEXTO)),
                Container(
                    width: 150,
                    child: TextFormField(
                        textAlign: TextAlign.center,
                        readOnly: true,
                        keyboardType: TextInputType.number,
                        controller: _txtControlerTotal,
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: FONTFAMILY_TEXTO)))
              ])
        ]));
  }

  _restarCantidad() {
    if (_cantidad > 1) {
      _cantidad = int.tryParse(_txtControlerCantidad.text) ?? 0;
      _cantidad = _cantidad - 1;
      _txtControlerCantidad.text = _cantidad.toString();
      _total = _publicacion.precio * _cantidad;
      _txtControlerTotal.text = "\$" + formatearCifra(_total.toString());
    }
  }

  _sumarCantidad() {
    _cantidad = int.tryParse(_txtControlerCantidad.text) ?? 0;
    _cantidad = _cantidad + 1;
    _txtControlerCantidad.text = _cantidad.toString();
    _total = _publicacion.precio * _cantidad;
    _txtControlerTotal.text = "\$" + formatearCifra(_total.toString());
  }

  _cargarBotonesInferiores() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            width: 130,
            height: 50,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.green.shade400),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                        duration:
                            const Duration(milliseconds: DURATION_TRANSITION),
                        type: PageTransitionType.leftToRight,
                        child: InformacionPublicacionView(
                            publicacion: _publicacion,
                            usuarioPublicacion: _usuarioPublicacion,
                            usuarioPerfil: _usuarioPerfil),
                      ));
                },
                child: Text("Cancelar", style: TextStyle(fontSize: 20)))),
        SizedBox(width: 20),
        Container(
            width: 130,
            height: 50,
            child: _reserva
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red.shade600,
                    ),
                    onPressed: () {
                      CompraVO compraVO = new CompraVO(
                          cantidad: this._cantidad, total: this._total);
                    },
                    child: Text("Reservar", style: TextStyle(fontSize: 20)))
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red.shade600,
                    ),
                    onPressed: () {
                      CompraVO compraVO = new CompraVO(
                          cantidad: this._cantidad, total: this._total);

                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                            duration: const Duration(
                                milliseconds: DURATION_TRANSITION),
                            type: PageTransitionType.topToBottom,
                            child: Webpay(
                                publicacion: _publicacion,
                                usuarioPublicacion: _usuarioPublicacion,
                                usuarioPerfil: _usuarioPerfil,
                                compra: compraVO),
                          ));
                    },
                    child: Text("Pagar", style: TextStyle(fontSize: 20))))
      ],
    );
  }

  Widget _cargarImagenPrincipal() {
    return _publicacion.imagenprevia != "null" &&
            _publicacion.imagenprevia != ""
        ? Image.network(_publicacion.imagenprevia.toString(),
            width: 200, height: 200, fit: BoxFit.fill)
        : Image.asset(
            IMAGEN_TIPO_PUBLICACION,
            //  Image.network("$element['image_url']", //"$element['rutaImg']",
            width: 200,
            height: 200,
            fit: BoxFit.fill,
          );
  }
}
