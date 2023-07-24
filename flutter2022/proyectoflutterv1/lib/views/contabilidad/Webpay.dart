import 'package:flutter/material.dart';
import 'package:proyectoflutterv1/Utils/Utilidades.dart';
import 'package:proyectoflutterv1/constantes/ConstFormularios.dart';
import 'package:proyectoflutterv1/constantes/Constantes.dart';
import 'package:proyectoflutterv1/models/VO/CompraVO.dart';
import 'package:proyectoflutterv1/models/VO/PublicacionProductoVO.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proyectoflutterv1/models/VO/UsuarioVO.dart';
import 'package:proyectoflutterv1/views/ModuloTienda/AgroMercado.dart';
import 'package:proyectoflutterv1/views/ModuloTienda/InformacionPublicacionView.dart';

class Webpay extends StatefulWidget {
  final PublicacionProductoVO publicacion;
  final UsuarioVO usuarioPublicacion;
  final UsuarioVO usuarioPerfil;
  final CompraVO compra;

  Webpay(
      {required this.publicacion,
      required this.usuarioPublicacion,
      required this.usuarioPerfil,
      required this.compra});
  @override
  State<StatefulWidget> createState() => WebpayState(this.publicacion,
      this.usuarioPublicacion, this.usuarioPerfil, this.compra);
}

class WebpayState extends State<Webpay> {
  late PublicacionProductoVO _publicacion;
  late UsuarioVO _usuarioPublicacion;
  late UsuarioVO _usuarioPerfil;
  late CompraVO _compra;

  TextEditingController _controladorRut = new TextEditingController();

  late String? _valueItemsBanco = "Selecciona tu banco";
  bool _cambiarPasoDos = false;
  bool _cambiarPasoTres = false;
  String _modoPago = "";

  WebpayState(
    this._publicacion,
    this._usuarioPublicacion,
    this._usuarioPerfil,
    this._compra,
  );

  @override
  void initState() {
    super.initState();
    _controladorRut.text =
        formatearRut(_usuarioPerfil.rut.toString() + _usuarioPerfil.digitoV);
    print(_publicacion.rut);
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
                child: _cambiarPasoTres
                    ? _generarPasoPagado()
                    : Column(children: <Widget>[
                        _generarParteSuperior(),
                        _cambiarPasoDos
                            ? _generarPasoSeleccionarBanco()
                            : Column(children: <Widget>[
                                Center(
                                  heightFactor: 1,
                                  child: Container(
                                      alignment: Alignment.center,
                                      width: 285,
                                      child: Column(children: <Widget>[
                                        Text("Selecciona tu medio de pago:",
                                            style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 20)),
                                        SizedBox(height: 10),
                                        Row(children: <Widget>[
                                          _generateButton("OnePay", () {
                                            if (mounted)
                                              setState(() {
                                                _modoPago = "OnePay";
                                                _cambiarPasoDos = true;
                                              });
                                          }, Colors.black, Colors.black26),
                                          _generateButton("Debito", () {
                                            if (mounted)
                                              setState(() {
                                                _modoPago = "Debito";
                                                _cambiarPasoDos = true;
                                              });
                                          }, Colors.black,
                                              Colors.orange.shade300)
                                        ]),
                                        Row(children: <Widget>[
                                          _generateButton("Credito", () {
                                            if (mounted)
                                              setState(() {
                                                _modoPago = "Credito";
                                                _cambiarPasoDos = true;
                                              });
                                          }, Colors.black, Colors.black26),
                                          _generateButton("Prepago", () {
                                            if (mounted)
                                              setState(() {
                                                _modoPago = "Prepago";
                                                _cambiarPasoDos = true;
                                              });
                                          }, Colors.black, Colors.black26)
                                        ]),
                                      ])),
                                ),
                                GestureDetector(
                                    child: Row(children: <Widget>[
                                      SizedBox(width: 20, height: 100),
                                      Icon(
                                        Icons.arrow_back,
                                        color: Colors.blue.shade300,
                                      ),
                                      Text(
                                          "Anular compra y volver al comercio.",
                                          style: TextStyle(
                                              color: Colors.blue.shade300,
                                              fontSize: 20)),
                                    ]),
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          PageTransition(
                                            duration: const Duration(
                                                milliseconds:
                                                    DURATION_TRANSITION),
                                            type:
                                                PageTransitionType.bottomToTop,
                                            child: InformacionPublicacionView(
                                                publicacion: this._publicacion,
                                                usuarioPublicacion:
                                                    this._usuarioPublicacion,
                                                usuarioPerfil:
                                                    this._usuarioPerfil),
                                          ));
                                    })
                              ])
                      ])),
          )
        ]));
  }

  _generarPasoPagado() {
    return Center(
        heightFactor: 1,
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              Container(
                  margin: EdgeInsets.fromLTRB(30, 10, 0, 0),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "WebPay",
                          style: TextStyle(color: Colors.red, fontSize: 25)),
                      TextSpan(
                          text: "\nTransbank",
                          style: TextStyle(color: Colors.purple)),
                    ]),
                  ))
            ]),
            Container(
                margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Column(children: <Widget>[
                  SizedBox(height: 30),
                  Icon(Icons.check_circle, color: Colors.green, size: 50),
                  SizedBox(height: 20),
                  Text("¡Tu pago fue realizado con éxito!",
                      style: TextStyle(fontSize: 20)),
                  SizedBox(height: 50),
                  Row(children: <Widget>[
                    Column(children: <Widget>[
                      Text("Tiendia",
                          style: TextStyle(color: Colors.black, fontSize: 17)),
                      SizedBox(height: 12),
                      Text("AgroMercado",
                          style: TextStyle(color: Colors.green, fontSize: 16))
                    ]),
                    Spacer(),
                    Column(children: <Widget>[
                      Text("Montón",
                          style: TextStyle(color: Colors.black, fontSize: 17)),
                      SizedBox(height: 12),
                      Text(
                          "\$" + formatearCifra(_publicacion.precio.toString()),
                          style: TextStyle(color: Colors.black, fontSize: 23))
                    ])
                  ]),
                  SizedBox(height: 50),
                  Row(children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Hora:",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16)),
                          SizedBox(height: 12),
                          Text("Fecha:",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16)),
                          SizedBox(height: 12),
                          Text("Número de Tarjeta:",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16)),
                          SizedBox(height: 12),
                          Text("Cód. autorización:",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16))
                        ]),
                    Spacer(),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(obtenerHoraEquipo(),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16)),
                          SizedBox(height: 12),
                          Text(obtenerFechaEquipo(),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16)),
                          SizedBox(height: 12),
                          Row(children: <Widget>[
                            Icon(Icons.house),
                            Text(generarNumerosAleatorios(4, 10),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16))
                          ]),
                          SizedBox(height: 12),
                          Text(generarNumerosAleatorios(6, 10),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16))
                        ])
                  ]),
                  SizedBox(height: 60),
                  _generateButtonVolver("Volver a la tienda", () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            duration: const Duration(
                                milliseconds: DURATION_TRANSITION),
                            type: PageTransitionType.bottomToTop,
                            child: AgroMercado(usuario: _usuarioPerfil)));
                  }, Colors.white, Colors.purple)
                ]))
          ],
        ));
  }

  _generarPasoSeleccionarBanco() {
    return Center(
        child: Column(children: <Widget>[
      Container(
          width: 300,
          child: Row(children: <Widget>[
            Container(
                child: Text(_modoPago,
                    style: TextStyle(color: Colors.black, fontSize: 20))),
            Spacer(),
            GestureDetector(
                child: Text("Cambiar",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                        fontSize: 20)),
                onTap: () {
                  if (mounted)
                    setState(() {
                      _modoPago = "";
                      _valueItemsBanco = "Selecciona tu banco";
                      _cambiarPasoDos = false;
                    });
                })
          ])),
      SizedBox(height: 50),
      Container(
          width: 350,
          child: DropdownButtonFormField<String>(
              value: _valueItemsBanco,
              items: ConstFormularios.itemsBancos
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                    value: value, child: Text(value));
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _valueItemsBanco = value;
                });
              })),
      SizedBox(height: 40),
      Container(
          width: 350,
          child: TextFormField(
            style: TextStyle(color: Colors.black, fontSize: 20),
            controller: _controladorRut,
            decoration: InputDecoration(label: Text("Rut")),
          )),
      Container(
          width: 200,
          height: 50,
          margin: EdgeInsets.only(top: 50),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.amber,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(12.0),
                ),
              ),
              onPressed: () {
                if (mounted)
                  setState(() {
                    _modoPago = "";
                    _valueItemsBanco = "Selecciona tu banco";
                    _cambiarPasoDos = false;
                    _cambiarPasoTres = true;
                  });
              },
              child: Text("Pagar",
                  style: TextStyle(fontSize: 20, color: Colors.black))))
    ]));
  }

  _generateButton(String label, VoidCallback function, Color colorTexto,
      Color colorButton) {
    return Container(
        margin: EdgeInsets.all(10),
        width: 120,
        height: 120,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: colorButton,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(12.0),
              ),
            ),
            onPressed: function,
            child: Text(label, style: TextStyle(color: colorTexto))));
  }

  _generateButtonVolver(String label, VoidCallback function, Color colorTexto,
      Color colorButton) {
    return Container(
        margin: EdgeInsets.all(10),
        width: 200,
        height: 60,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: colorButton,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(12.0),
              ),
            ),
            onPressed: function,
            child: Text(label,
                style: TextStyle(color: colorTexto, fontSize: 18))));
  }

  _generarParteSuperior() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(40, 20, 0, 0),
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "WebPay",
                    style: TextStyle(color: Colors.red, fontSize: 25)),
                TextSpan(
                    text: "\nTransbank",
                    style: TextStyle(color: Colors.purple)),
              ]),
            ),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 50),
              child: Row(children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(30, 60, 20, 0),
                  child: Column(children: <Widget>[
                    Text("Estas pagando en",
                        style: TextStyle(color: Colors.blue, fontSize: 20)),
                    Text("AgroApp",
                        style: TextStyle(color: Colors.green, fontSize: 20))
                  ]),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(0, 60, 10, 0),
                    child: Column(children: <Widget>[
                      Text("Monto a pagar",
                          style: TextStyle(color: Colors.blue, fontSize: 20)),
                      Text("\$" + formatearCifra(this._compra.total.toString()),
                          style: TextStyle(
                              color: Colors.red.shade700, fontSize: 20))
                    ]))
              ]))
        ]);
  }
}
