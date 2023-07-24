import 'package:flutter/material.dart';
import 'package:proyectoflutterv1/Utils/Mensajes.dart';
import 'package:proyectoflutterv1/Utils/Utilidades.dart';
import 'package:proyectoflutterv1/Utils/Validadores.dart';
import 'package:proyectoflutterv1/constantes/Constantes.dart';
import 'package:proyectoflutterv1/models/CargaData/ProfileBD.dart';
import 'package:proyectoflutterv1/models/VO/UsuarioVO.dart';
import 'package:proyectoflutterv1/views/Inicio_app/Login.dart';
import 'package:proyectoflutterv1/views/ModuloTienda/AgroMercado.dart';
import 'package:proyectoflutterv1/views/Widget/AppBar/AppBarWidget.dart';
import 'package:proyectoflutterv1/views/Widget/FormulariosView/MaterialButtonGlobalView(.dart';
import 'package:proyectoflutterv1/views/estilos/StyleFroms.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum EstadoVerificacionMovil {
  MOSTRAR_FORMULARIO_TEL,
  MOSTRAR_FORMULARIO_OTP,
  VALIDACION_CONFIRMADA
}

class ConfirmacionDatos extends StatefulWidget {
  final UsuarioVO usuario;
  final int? telefono;

  ConfirmacionDatos({required this.usuario, this.telefono});

  @override
  State<StatefulWidget> createState() =>
      _ConfirmacionDatosState(this.usuario, this.telefono);
}

class _ConfirmacionDatosState extends State<ConfirmacionDatos> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  EstadoVerificacionMovil _currentState =
      EstadoVerificacionMovil.MOSTRAR_FORMULARIO_TEL;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formTelefono = GlobalKey<FormState>();

  final Duration _initialDelay = Duration(seconds: 1);

  //final TextEditingController _txtControllerEmail = TextEditingController();
  final TextEditingController _txtControllerTelefono = TextEditingController();
  final TextEditingController _txtControllerCode = TextEditingController();
  final TextEditingController _txtControllerCodePais = TextEditingController();

  final GlobalKey expansionTileCorreo = new GlobalKey();

  bool _showLoading = false;

  String _numeroCel = "";
  String _titulo = "Ingrese su número de teléfono";
  String _verificacionID = "";

  UsuarioVO _usuario;
  int? _telefono;

  _ConfirmacionDatosState(this._usuario, this._telefono);

  @override
  void initState() {
    super.initState();
    _txtControllerCodePais.text = "+56";
    if (_telefono != null) {
      _txtControllerTelefono.text = '$_telefono';
      _titulo = "Confirmación de número de teléfono";
    }
  }

  @override
  Widget build(BuildContext context) {
    //Solo muestra barra de botones inferior y oculta la barra superior (señal, estado baterìa...)
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return Scaffold(
        appBar: getAppBarRectrocederTranparente(),
        key: _scaffoldKey,
        backgroundColor: COLOR_FONDO_BODY,
        resizeToAvoidBottomInset: false,
        body: new Stack(children: <Widget>[
          SafeArea(
              child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Center(
                      heightFactor: 1.3,
                      child: Container(
                          margin: EdgeInsets.fromLTRB(30, 0, 30, 10),
                          alignment: Alignment.center,
                          child: _showLoading
                              ? getBarraProgreso()
                              : _currentState ==
                                      EstadoVerificacionMovil
                                          .MOSTRAR_FORMULARIO_TEL
                                  ? getMobileFormWidget(context)
                                  : _currentState ==
                                          EstadoVerificacionMovil
                                              .MOSTRAR_FORMULARIO_OTP
                                      ? getOtpFormWidget(context)
                                      : _currentState ==
                                              EstadoVerificacionMovil
                                                  .VALIDACION_CONFIRMADA
                                          ? _confirmacionRegistro(context)
                                          : getMobileFormWidget(context)))))
        ]));
  }

  Widget getBarraProgreso() {
    return Container(
        alignment: Alignment.center,
        child: Center(
            child: LinearProgressIndicator(minHeight: 3, color: Colors.green)));
  }

  Widget getMobileFormWidget(context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 15),
          // Spacer(),
          DelayedDisplay(
              delay: Duration(seconds: _initialDelay.inSeconds),
              child: Text(_titulo,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: FONTFAMILY_TEXTO,
                      color: COLOR_TEXTO_GENERAL_PAGINA,
                      fontWeight: FontWeight.bold,
                      fontSize: SIZE_TEXT - 6))),
          SizedBox(height: 20),
          //Spacer(),
          DelayedDisplay(
              delay: Duration(seconds: _initialDelay.inSeconds),
              child: Text(
                  "Se le enviará un código que deberá ingresar posteriormente.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: FONTFAMILY_TEXTO,
                      color: COLOR_TEXTO_GENERAL_PAGINA,
                      fontSize: SIZE_TEXT - 8))),
          SizedBox(height: 40),
          DelayedDisplay(
              delay: Duration(seconds: _initialDelay.inSeconds),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Expanded(
                    flex: 3,
                    child: TextField(
                      controller: _txtControllerCodePais,
                      textAlign: TextAlign.center,
                      //enabled: true,
                      readOnly: true,
                      keyboardType: TextInputType.phone,
                      decoration: decoracionInputTextFormField(""),
                      style: TextStyle(
                          fontFamily: FONTFAMILY_LABEL_INPUT,
                          height: 1,
                          fontWeight: FontWeight.w400,
                          fontSize: SIZE_LABEL_INPUT,
                          color: Colors.black),
                    ),
                  ),
                  Form(
                    key: _formTelefono,
                    autovalidateMode: AutovalidateMode.always,
                    child: Expanded(
                      flex: 8,
                      child: TextFormField(
                          keyboardType: TextInputType.phone,
                          decoration: decoracionInputTextFormField("Teléfono"),
                          controller: _txtControllerTelefono,
                          style: TextStyle(
                              fontFamily: FONTFAMILY_LABEL_INPUT,
                              height: 1,
                              fontWeight: FontWeight.w400,
                              fontSize: SIZE_LABEL_INPUT,
                              color: Colors.black),
                          validator: (value) =>
                              validarIngresoFormulario(value, "Teléfono")),
                    ),
                  )
                ],
              )),
          //: new Container(),
          SizedBox(height: 40),
          DelayedDisplay(
              delay: Duration(seconds: _initialDelay.inSeconds),
              child: MaterialButtonGlobalView(
                  label: "Enviar",
                  onChangedCallback: () async {
                    if (_txtControllerTelefono.text.isEmpty ||
                        _txtControllerTelefono.text.length < 9) {
                      showMessageError(context,
                          "Debe ingresar su número de teléfono válido");
                    } else {
                      setState(() {
                        _numeroCel = ocultaNumerosCel(
                            _txtControllerTelefono.text.trim());
                        _showLoading = true;
                      });

                      _realizarVerificacion();
                    }
                  })),
          // Spacer()
        ]);
  }

  Widget getOtpFormWidget(context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 15),
          // Spacer(),
          Text("Ingrese el código",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: FONTFAMILY_TEXTO,
                  color: COLOR_TEXTO_GENERAL_PAGINA,
                  fontWeight: FontWeight.bold,
                  fontSize: SIZE_TEXT - 6)),
          SizedBox(height: 20),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Se ha enviado un SMS con un código de validación al  \n',
              style: TextStyle(
                  fontFamily: FONTFAMILY_TEXTO,
                  color: COLOR_TEXTO_GENERAL_PAGINA,
                  fontSize: SIZE_TEXT - 8),
              children: <TextSpan>[
                TextSpan(
                    text: '$_numeroCel',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: FONTFAMILY_TEXTO,
                        color: COLOR_TEXTO_GENERAL_PAGINA,
                        fontSize: SIZE_TEXT - 4)),
              ],
            ),
          ),

          SizedBox(height: 40),
          TextField(
              maxLength: 6,
              keyboardType: TextInputType.phone,
              controller: _txtControllerCode,
              style: TextStyle(
                  fontFamily: FONTFAMILY_LABEL_INPUT,
                  height: 1.2,
                  fontWeight: FontWeight.w400,
                  fontSize: SIZE_LABEL_INPUT,
                  color: Colors.black),
              // obscureText: true,
              decoration: decoracionInputTextFormField("Código de validación")),
          GestureDetector(
              child: Text("Solicitar nuevo código de validación",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontFamily: FONTFAMILY_TEXTO,
                      color: Colors.blue,
                      fontWeight: FontWeight.normal,
                      fontSize: 15)),
              onTapDown: (value) {
                _realizarVerificacion();
              }),

          SizedBox(height: 25),

          MaterialButtonGlobalView(
              label: "Validar",
              onChangedCallback: () async {
                // print("------>" + '$this._verificacionID');
                if ((this._verificacionID.isNotEmpty)) {
                  if (_txtControllerCode.text.isEmpty) {
                    showMessageError(context, "Debe ingresar el código");
                  } else if (!campoNumericoValido(
                      _txtControllerCode.text.trim())) {
                    showMessageError(context, "No es un código válido");
                  } else {
                    PhoneAuthCredential phoneAuthCredential =
                        PhoneAuthProvider.credential(
                            verificationId: this._verificacionID,
                            smsCode: _txtControllerCode.text.trim());
                    _signInWithPhoneAuthCredential(phoneAuthCredential);
                  }
                } else {
                  showMessageError(
                      context, "No se pudo enviar el código de validación");
                }
              }),

          //  Spacer()
        ]);
  }

  Widget _confirmacionRegistro(BuildContext context) {
    return Column(
      children: [
        Image.asset(IMAGEN_TIPO_SUCCESS, height: 200),
        SizedBox(height: 45),
        Text("Confirmación finalizada con éxito",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: COLOR_TEXTO_GENERAL_PAGINA,
                fontSize: 20,
                fontWeight: FontWeight.w300)),
        SizedBox(height: 45),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.orange.shade600, fixedSize: Size(150, 45)),
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        ctx: context,
                        type: PageTransitionType.leftToRight,
                        child: AgroMercado(usuario: this._usuario)));
              },
              child: Text("Ir al mercado",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: FONTFAMILY_TEXTO_BUTTON,
                      fontSize: 14))),
          SizedBox(width: 8),
        ])
      ],
    );
  }

  void _signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      _showLoading = true;
    });
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        _showLoading = false;
      });
      if (authCredential.user != null) {
        await ProfileBD.instance
            .actualizarConfirmacion(true, _usuario.rut,
                int.tryParse(this._txtControllerTelefono.text.trim()))
            .then((value) => Navigator.pushReplacement(
                context,
                PageTransition(
                    duration: const Duration(milliseconds: DURATION_TRANSITION),
                    type: PageTransitionType.topToBottom,
                    child: Login(
                        rutUsuario: formatearRut(
                            _usuario.rut.toString().trim() +
                                _usuario.digitoV.trim())))))
            .onError((error, stackTrace) {
          showMessageError(context,
              "Ocurrió un problema durante la confimación del código ingresado");
        });
      }
      // ignore: unused_catch_clause
    } on FirebaseException catch (e) {
      setState(() {
        _showLoading = false;
      });
      showMessageError(context, "Verificación fallida");
    }
  }

  Future _realizarVerificacion() async {
    await _auth.verifyPhoneNumber(
        phoneNumber: _txtControllerCodePais.text.trim() +
            _txtControllerTelefono.text.trim(),
        verificationCompleted: (credencialFono) async {
          setState(() {
            _showLoading = false;
            //_currentState = EstadoVerificacionMovil.MOSTRAR_FORMULARIO_OTP;
          });
        },
        verificationFailed: (verificacionFallida) async {
          setState(() {
            _showLoading = false;
            // _currentState = EstadoVerificacionMovil.MOSTRAR_FORMULARIO_OTP;
          });
          showMessageError(context,
              "No se pudo enviar el código de validación. Verifique la cobertura de su red móvil");
        },
        codeSent: (idverificacion, tokenReenvio) async {
          setState(() {
            _showLoading = false;

            _currentState = EstadoVerificacionMovil.MOSTRAR_FORMULARIO_OTP;
            this._verificacionID = idverificacion;
          });
        },
        codeAutoRetrievalTimeout: (idverificacion) async {
          setState(() {
            _showLoading = false;
            _currentState = EstadoVerificacionMovil.MOSTRAR_FORMULARIO_OTP;
          });
        });
  }
}
