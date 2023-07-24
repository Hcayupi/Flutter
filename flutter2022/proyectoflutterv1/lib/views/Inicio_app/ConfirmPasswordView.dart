import 'package:flutter/material.dart';
import 'package:proyectoflutterv1/Utils/Mensajes.dart';
import 'package:proyectoflutterv1/constantes/Constantes.dart';
import 'package:proyectoflutterv1/models/CargaData/ProfileBD.dart';
import 'package:proyectoflutterv1/models/VO/UsuarioVO.dart';
import 'package:page_transition/page_transition.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:proyectoflutterv1/views/Inicio_app/ConfirmacionDatos.dart';
import 'package:proyectoflutterv1/views/Widget/FormulariosView/MaterialButtonGlobalView(.dart';
import 'package:proyectoflutterv1/views/Widget/FormulariosView/propiedades/InputsFormularioWidget.dart';

enum EstadoRegistro {
  INGRESO_PASSWORD,
  REGISTRO_CONFIRMADO,
  REGISTRO_NO_REALIZADO
}

class ConfirmPasswordView extends StatefulWidget {
  final UsuarioVO usuarioVO;

  ConfirmPasswordView(this.usuarioVO);
  @override
  State<StatefulWidget> createState() =>
      ConfirmPasswordViewState(this.usuarioVO);
}

class ConfirmPasswordViewState extends State<ConfirmPasswordView> {
  UsuarioVO _usuarioVO;
  final GlobalKey<FormState> _formPassword = GlobalKey<FormState>();
  EstadoRegistro _estadoActual = EstadoRegistro.INGRESO_PASSWORD;
  TextEditingController _txtPassword = new TextEditingController();
  TextEditingController _txtConfirmacionPass = new TextEditingController();
  bool _mostrarLoading = false;
  final Duration _initialDelay = Duration(seconds: 1);

  ConfirmPasswordViewState(this._usuarioVO);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: COLOR_FONDO_BODY,
        resizeToAvoidBottomInset: false,
        body: new Stack(children: <Widget>[
          SafeArea(
              child: Container(
                  margin: EdgeInsets.fromLTRB(50, 80, 50, 0),
                  alignment: Alignment.center,
                  child: Form(
                      key: _formPassword,
                      autovalidateMode: AutovalidateMode.always,
                      child: _mostrarLoading
                          ? Center(child: CircularProgressIndicator())
                          : _estadoActual == EstadoRegistro.INGRESO_PASSWORD
                              ? _creacionDePassword()
                              : _confirmacionRegistro())))
        ]));
  }

  Widget _confirmacionRegistro() {
    return Column(
      children: [
        Image.asset(IMAGEN_TIPO_SUCCESS, height: 200),
        SizedBox(height: 45),
        Text(
            "El registro se ha realizado exitosamente. Ahora solo necesita confirmar su número de teléfono.",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: COLOR_TEXTO_GENERAL_PAGINA,
                fontSize: 20,
                fontWeight: FontWeight.w300)),
        SizedBox(height: 45),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          /* ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.orange.shade600, fixedSize: Size(150, 45)),
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        ctx: context,
                        type: PageTransitionType.leftToRight,
                        child: AgroMercado(idUsuario: this._usuarioVO.rut)));
              },
              child: Text("Ir al mercado",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),*/
          SizedBox(width: 8),
          MaterialButtonGlobalView(
              label: "Confirmar",
              onChangedCallback: () {
                Navigator.push(
                    context,
                    PageTransition(
                        ctx: context,
                        type: PageTransitionType.leftToRight,
                        child: ConfirmacionDatos(
                            usuario: this._usuarioVO,
                            telefono: this._usuarioVO.numeroCel)));
              })
        ])
      ],
    );
  }

  Widget _creacionDePassword() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 30),
          DelayedDisplay(
              slidingCurve: Curves.easeInCirc,
              delay: Duration(seconds: _initialDelay.inSeconds),
              child: Icon(Icons.security,
                  size: 90, color: COLOR_TEXTO_GENERAL_PAGINA)),
          DelayedDisplay(
              slidingCurve: Curves.easeInCirc,
              delay: Duration(seconds: _initialDelay.inSeconds),
              child: Text("Para acceder a su cuenta debe crear un password.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: FONTFAMILY_TEXTO,
                      color: COLOR_TEXTO_GENERAL_PAGINA,
                      fontWeight: FontWeight.bold,
                      fontSize: SIZE_TEXT - 6))),
          SizedBox(height: 40),
          DelayedDisplay(
              slidingCurve: Curves.easeInCirc,
              delay: Duration(seconds: _initialDelay.inSeconds),
              child: inputTextFormFieldPass(_txtPassword, "Password",
                  tecladoNumber: false)),
          SizedBox(height: ESPACIO_INPUTS_FORM),
          DelayedDisplay(
              slidingCurve: Curves.easeInCirc,
              delay: Duration(seconds: _initialDelay.inSeconds),
              child: inputTextFormFieldPass(
                  _txtConfirmacionPass, "Confirmación",
                  tecladoNumber: false)),
          SizedBox(height: 50),
          DelayedDisplay(
              slidingCurve: Curves.easeInCirc,
              delay: Duration(seconds: _initialDelay.inSeconds),
              child: MaterialButtonGlobalView(
                  label: "Confirmar",
                  onChangedCallback: () {
                    var _state = _formPassword.currentState;

                    if (!_state!.validate() == false) {
                      if (_txtPassword.text
                              .compareTo(_txtConfirmacionPass.text) ==
                          0) {
                        _guardarRegistro();
                      } else {
                        showMessageError(context,
                            'Asegurese de ingresar la misma contraseña en ambos campos');
                      }
                    } else {
                      showMessageError(
                          context, 'Debe completar el fomulario de registro');
                    }
                  })),
          Spacer()
        ]);
  }

  void _guardarRegistro() async {
    setState(() {
      _mostrarLoading = true;
    });

    _usuarioVO.password = _txtPassword.text;

    await Future.wait(
            [ProfileBD.instance.guardarRegistro(registro: _usuarioVO)])
        .then((value) {
      if (value[0] != null && value[0] == true) {
        // if (this.entry != null) this.entry!.remove();
        setState(() {
          _mostrarLoading = false;
          _estadoActual = EstadoRegistro.REGISTRO_CONFIRMADO;
        });
      } else
        showMessageError(context, 'Hay problemas para guardar los datos');

      _mostrarLoading = false;
    });
  }
}
