import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proyectoflutterv1/Utils/Mensajes.dart';
import 'package:proyectoflutterv1/Utils/UtilidadesWidget.dart';
import 'package:proyectoflutterv1/constantes/Constantes.dart';
import 'package:proyectoflutterv1/models/CargaData/ProfileBD.dart';
import 'package:proyectoflutterv1/models/VO/UsuarioVO.dart';
import 'package:proyectoflutterv1/views/ModuloTienda/AgroMercado.dart';
import 'package:proyectoflutterv1/views/Widget/AppBar/AppBarWidget.dart';
import 'package:proyectoflutterv1/views/Widget/FormulariosView/MaterialButtonGlobalView(.dart';
import 'package:proyectoflutterv1/views/estilos/StyleFroms.dart';

class Login extends StatefulWidget {
  final String? rutUsuario;

  Login({this.rutUsuario = ""});

  @override
  State<StatefulWidget> createState() => LoginState(this.rutUsuario);
}

class LoginState extends State<Login> {
  final Duration initialDelay = Duration(seconds: 1);
  final TextEditingController _controllerRut = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  String? _rutUsuario = "";
  bool _showLoading = false;

  LoginState(this._rutUsuario);

  @override
  void initState() {
    super.initState();
    _controllerRut.text = _rutUsuario.toString();
  }

  Future<UsuarioVO> getPasswordUsuario(String rut) async {
    if (mounted)
      setState(() {
        _showLoading = true;
      });
    UsuarioVO usuarioVO =
        await ProfileBD.instance.cargarDatosUsuario(rut).then((value) {
      if (mounted)
        setState(() {
          _showLoading = false;
        });

      return value;
    });
    return usuarioVO;
  }

  @override
  Widget build(BuildContext context) {
    //Solo muestra barra de botones inferior y oculta la barra superior (señal, estado baterìa...)
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return Scaffold(
        appBar: getAppBarRectrocederTranparente(),
        backgroundColor: COLOR_FONDO_BODY,
        resizeToAvoidBottomInset: false,
        body: new Stack(children: <Widget>[
          SafeArea(
              child: Container(
                  margin: EdgeInsets.fromLTRB(70, 10, 70, 10),
                  alignment: Alignment.center,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Spacer(),
                        Text("Login",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: FONTFAMILY_TEXTO,
                                color: COLOR_TEXT,
                                fontWeight: FontWeight.bold,
                                fontSize: SIZE_TEXT)),
                        SizedBox(height: 30),
                        TextFormField(
                            controller: _controllerRut,
                            readOnly: true,
                            textAlign: TextAlign.center,
                            enableSuggestions: false,
                            autocorrect: false,
                            style: TextStyle(
                                fontFamily: FONTFAMILY_LABEL_INPUT,
                                height: 1,
                                fontWeight: FontWeight.w400,
                                fontSize: SIZE_LABEL_INPUT + 5,
                                color: COLOR_LABEL_INPUT),
                            decoration: decoracionInputTextFormField("Rut")),
                        TextFormField(
                            controller: _controllerPassword,
                            textAlign: TextAlign.center,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            style: TextStyle(
                                fontFamily: FONTFAMILY_LABEL_INPUT,
                                height: 1,
                                fontWeight: FontWeight.w400,
                                fontSize: SIZE_LABEL_INPUT + 5,
                                color: COLOR_LABEL_INPUT),
                            decoration:
                                decoracionInputTextFormField("Contraseña")),
                        SizedBox(height: 20),
                        MaterialButtonGlobalView(
                            label: "Iniciar sesion",
                            onChangedCallback: () async {
                              UsuarioVO _usuarioVO = await getPasswordUsuario(
                                  _rutUsuario.toString());
                              if (_controllerPassword.text.isNotEmpty) {
                                if (_showLoading == false) {
                                  if (_controllerPassword.text.compareTo(
                                          _usuarioVO.password.toString()) ==
                                      0) {
                                    Navigator.pushReplacement(
                                        context,
                                        PageTransition(
                                            duration: const Duration(
                                                milliseconds:
                                                    DURATION_TRANSITION),
                                            type: PageTransitionType.fade,
                                            child: AgroMercado(
                                                usuario: _usuarioVO)));
                                  } else {
                                    showMessageError(
                                        context, 'Constraseña incorrecta');
                                  }
                                }
                              } else
                                showMessageError(
                                    context, 'Ingrese su contraseña');
                            }),
                        SizedBox(height: 20),
                        if (_showLoading == true)
                          Container(
                              child: Center(
                            child: getLoagingLinea(),
                          ))
                        else
                          Container(child: SizedBox(height: 3)),
                        Spacer(),
                      ])))
        ]));
  }
}
