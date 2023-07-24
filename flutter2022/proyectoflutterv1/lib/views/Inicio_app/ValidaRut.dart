import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proyectoflutterv1/Utils/Mensajes.dart';
import 'package:proyectoflutterv1/Utils/Utilidades.dart';
import 'package:proyectoflutterv1/Utils/UtilidadesWidget.dart';
import 'package:proyectoflutterv1/Utils/Validadores.dart';
import 'package:proyectoflutterv1/constantes/Constantes.dart';
import 'package:proyectoflutterv1/models/CargaData/ProfileBD.dart';
import 'package:proyectoflutterv1/models/VO/UsuarioVO.dart';
import 'package:proyectoflutterv1/views/Inicio_app/Login.dart';
import 'package:proyectoflutterv1/views/Widget/FormulariosView/MaterialButtonGlobalView(.dart';
import 'package:proyectoflutterv1/views/estilos/StyleFroms.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';

import 'ConfirmacionDatos.dart';
import 'Registro.dart';
//import 'package:http/http.dart';

class ValidaRut extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ValidaRutState();
}

class ValidaRutState extends State<ValidaRut> {
  final Duration initialDelay = Duration(seconds: 1);
  final TextEditingController _controllerUser = TextEditingController();
  final GlobalKey<FormState> _formIdentificador = GlobalKey<FormState>();

  int contador = 0;
  bool _showLoading = false;

  // ignore: non_constant_identifier_names
  String ingreso_actualizado = "";
  List usuarios = [];

  @override
  void initState() {
    super.initState();

    //setUser();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _controllerUser.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Solo muestra barra de botones inferior y oculta la barra superior (señal, estado baterìa...)
    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    return Scaffold(
        backgroundColor: COLOR_FONDO_BODY,
        resizeToAvoidBottomInset: false,
        body: new Stack(children: <Widget>[
          SafeArea(
              child: Container(
                  margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: Form(
                      key: _formIdentificador,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(children: <Widget>[
                        Spacer(),
                        //SizedBox(height: 150),
                        /*Icon(Icons.account_circle,
                                size: 70, color: COLOR_ICONO_PAGE),*/
                        SizedBox(height: 10),
                        Text("Ingrese su rut \n sin punto ni guión",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: FONTFAMILY_TEXTO,
                                color: COLOR_TEXT,
                                fontSize: SIZE_TEXT - 2)),
                        SizedBox(height: 20),
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            child: Text("Rut",
                                style: TextStyle(
                                    color: Colors.green.shade100,
                                    fontSize: 18))),

                        _inputRut(), //TextFormField_rut
                        const SizedBox(height: 30),
                        MaterialButtonGlobalView(
                          label: "Ingresar",
                          onChangedCallback: () async {
                            if (mounted)
                              setState(() {
                                _showLoading = true;
                              });
                            bool hayconeccion = await SimpleConnectionChecker
                                .isConnectedToInternet();
                            if (hayconeccion) {
                              if (mounted)
                                setState(() {
                                  _showLoading = false;
                                });
                              _derivacionAPaginaCorrespondiente();
                            } else {
                              if (mounted)
                                setState(() {
                                  _showLoading = false;
                                });
                              showDialogError("No hay conexión",
                                  "No estás conectado a internet", context);
                            }
                          },
                        ),
                        SizedBox(height: 20),
                        if (_showLoading == true)
                          Container(
                              child: Center(
                            child: getLoagingLinea(),
                          ))
                        else
                          Container(child: SizedBox(height: 3)),
                        SizedBox(height: 40),
                        Spacer()
                      ]))))
        ]));
  }

  Widget _inputRut() {
    return TextFormField(
      textAlign: TextAlign.center,
      keyboardType: TextInputType.datetime,
      controller: _controllerUser,
      style: TextStyle(
          fontFamily: FONTFAMILY_LABEL_INPUT,
          fontWeight: FontWeight.w400,
          fontSize: SIZE_LABEL_INPUT,
          color: COLOR_LABEL_INPUT),
      decoration: decoracionInputTextFormField("Rut"),
      validator: (value) => _validaInputRut(value),
      onChanged: (value) {
        value = formatearRut(limpiarRut(value));
        if (mounted)
          setState(() {
            _controllerUser.text = value;
          });
        _controllerUser.selection = TextSelection.fromPosition(
            TextPosition(offset: _controllerUser.text.length));
      },
    );
  }

  _derivacionAPaginaCorrespondiente() async {
    var _state = _formIdentificador.currentState;

    if (!_state!.validate() == false) {
      var resultado =
          await ProfileBD.instance.existeUsuario(_controllerUser.text, context);

      if (resultado["existe"] && !resultado["confirmado"]) {
        if (mounted)
          setState(() {
            _showLoading = false;
          });

        UsuarioVO usuario =
            await ProfileBD.instance.cargarDatosUsuario(_controllerUser.text);

        Navigator.push(
            context,
            PageTransition(
                duration: const Duration(milliseconds: DURATION_TRANSITION),
                type: PageTransitionType.rightToLeft,
                child: ConfirmacionDatos(
                  usuario: usuario,
                )));
      } else if (resultado["existe"] && resultado["confirmado"]) {
        if (mounted)
          setState(() {
            _showLoading = false;
          });
        Navigator.push(
            context,
            PageTransition(
                duration: const Duration(milliseconds: DURATION_TRANSITION),
                type: PageTransitionType.rightToLeft,
                child: Login(
                  rutUsuario: _controllerUser.text,
                )));
      } else {
        if (mounted)
          setState(() {
            _showLoading = false;
          });

        // _showToast(context, "No  existe usuario entonces se deriva a registro");
        Navigator.push(
            context,
            PageTransition(
                duration: const Duration(milliseconds: DURATION_TRANSITION),
                type: PageTransitionType.bottomToTop,
                child: Registro(rutUsuario: _controllerUser.text)));
      }
    } else {
      if (mounted)
        setState(() {
          _showLoading = false;
        });
      showMessageError(context, 'Rut inválido');
    }
  }

  String? _validaInputRut(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return "Ingrese su rut";
      } else {
        String rut = limpiarRut(value);
        if (rut.length > 9 || rut.length < 9) {
          return "Ingrese un rut válido";
        } else if (rut.length == 9) {
          if (!validaRut(rut)) {
            return "Ingrese un rut válido";
          }
        }
      }
      return null;
    }
  }
}
