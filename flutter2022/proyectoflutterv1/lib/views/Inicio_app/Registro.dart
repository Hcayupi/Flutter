import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proyectoflutterv1/Utils/Mensajes.dart';
import 'package:proyectoflutterv1/Utils/Utilidades.dart';
import 'package:proyectoflutterv1/constantes/Constantes.dart';
import 'package:proyectoflutterv1/constantes/ConstFormularios.dart';
import 'package:proyectoflutterv1/models/VO/UsuarioVO.dart';
import 'package:proyectoflutterv1/views/Widget/AppBar/AppBarWidget.dart';
import 'package:proyectoflutterv1/views/Inicio_app/ConfirmPasswordView.dart';
import 'package:proyectoflutterv1/views/Widget/FormulariosView/MaterialButtonGlobalView(.dart';
import 'package:proyectoflutterv1/views/Widget/FormulariosView/MaterialDropDownView.dart';
import 'package:proyectoflutterv1/views/Widget/FormulariosView/propiedades/InputsFormularioWidget.dart';
import 'package:proyectoflutterv1/views/estilos/StyleFroms.dart';

class Registro extends StatefulWidget {
  final String rutUsuario;
  Registro({required this.rutUsuario});

  @override
  State<StatefulWidget> createState() => RegistroState(
        this.rutUsuario,
      );
}

class RegistroState extends State<Registro> {
  late String _idUsuario;
  RegistroState(this._idUsuario);

  TextEditingController _txtControllerNombre = new TextEditingController();
  TextEditingController _txtControllerRut = new TextEditingController();
  TextEditingController _txtControllerApellidoP = new TextEditingController();
  TextEditingController _txtControllerApellidoM = new TextEditingController();
  TextEditingController _txtControllerEmail = new TextEditingController();
  TextEditingController _txtControllerFono = new TextEditingController();
  TextEditingController _txtControllerDireccion = new TextEditingController();

  final GlobalKey<FormState> _formRegistro = GlobalKey<FormState>();

  String _dropRegiones = "Seleccione";
  String _dropCiudad = "Seleccione";
  String _dropComuna = "Seleccione";

  @override
  void initState() {
    super.initState();
    _txtControllerRut.text = _idUsuario;
  }

  @override
  Widget build(BuildContext context) {
    //Solo muestra barra de botones inferior y oculta la barra superior (señal, estado baterìa...)
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return Scaffold(
        backgroundColor: COLOR_FONDO_BODY,
        appBar: getAppBarRectrocederTranparente(titulo: "Complete sus datos"),
        resizeToAvoidBottomInset:
            true, //Evita que el keyboward oculte el TextField u otro campo
        body: new Stack(children: <Widget>[
          SafeArea(
              top: true,
              child: Container(
                  margin: MARGIN_CONTAINER_FORM,
                  // constraints:
                  //   BoxConstraints(maxWidth: SIZE_ANCHO_MAXIMO_CONTAINER),
                  child: SingleChildScrollView(
                      //reverse: true,
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context)
                              .viewInsets
                              .bottom), //No oculta el TextField cuando se eleva el teclado
                      child: Form(
                          key: _formRegistro,
                          autovalidateMode: AutovalidateMode.always,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: SIZE_PADDING_BOTTOM_APPBAR)),
                                agregarEtiquetaInput("Rut"),
                                TextField(
                                  controller: _txtControllerRut,
                                  textAlign: TextAlign.center,
                                  //enabled: true,
                                  readOnly: true,
                                  keyboardType: TextInputType.phone,
                                  decoration: decoracionInputTextFormField(""),
                                  style: TextStyle(
                                      height: 1,
                                      fontWeight: FontWeight.w400,
                                      fontSize: SIZE_LABEL_INPUT + 7,
                                      color: Colors.black),
                                ),
                                /*inputTextFormField(_txtControllerRut, "Rut",
                                    tecladoNumber: false, readOnly: true),*/
                                agregarEtiquetaInput("Nombre"),
                                inputTextFormField(
                                    _txtControllerNombre, "Nombre",
                                    tecladoNumber: false),
                                agregarEtiquetaInput("Apellido paterno"),
                                inputTextFormField(
                                    _txtControllerApellidoP, "Apellido paterno",
                                    tecladoNumber: false),
                                agregarEtiquetaInput("Apellido materno"),
                                inputTextFormField(
                                    _txtControllerApellidoM, "Apellido materno",
                                    tecladoNumber: false),
                                agregarEtiquetaInput("Región"),
                                MaterialDropDownView(
                                    onChangedCallback: (value) {
                                      setState(() {
                                        _dropRegiones = value;
                                      });
                                    },
                                    value: _dropRegiones,
                                    label: "Región",
                                    values: ConstFormularios.itemsRegiones),
                                agregarEtiquetaInput("Ciudad"),
                                MaterialDropDownView(
                                    onChangedCallback: (value) {
                                      setState(() {
                                        _dropCiudad = value;
                                      });
                                    },
                                    value: _dropCiudad,
                                    label: "Ciudad",
                                    values: ['Seleccione', 'Temuco', 'Freire']),
                                agregarEtiquetaInput("Comuna"),
                                MaterialDropDownView(
                                    onChangedCallback: (value) {
                                      setState(() {
                                        _dropComuna = value;
                                      });
                                    },
                                    value: _dropComuna,
                                    label: "Comuna",
                                    values: ['Seleccione', 'Temuco', 'Freire']),
                                agregarEtiquetaInput("Dirección"),
                                inputTextFormField(
                                    _txtControllerDireccion, "Dirección",
                                    tecladoNumber: false),
                                agregarEtiquetaInput("E-mail"),
                                inputTextFormField(
                                    _txtControllerEmail, "Correo electrónico",
                                    tecladoNumber: false),
                                agregarEtiquetaInput("Celular"),
                                inputTextFormField(
                                    _txtControllerFono, "Número de celular",
                                    tecladoNumber: true),
                                SizedBox(height: ESPACIO_INPUTS_FORM),
                                MaterialButtonGlobalView(
                                    label: "Enviar",
                                    onChangedCallback: () {
                                      _validacionFormulario();
                                    }),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: SIZE_PADDING_BOTTOM_APPBAR)),
                              ])))))
        ]));
  }

  void _validacionFormulario() {
    var _state = _formRegistro.currentState;

    if (!_state!.validate() == false) {
      UsuarioVO usuarioVO = _almacenarDatosIngresados();
      Navigator.pushReplacement(
          context,
          PageTransition(
              duration: const Duration(milliseconds: DURATION_TRANSITION),
              type: PageTransitionType.bottomToTop,
              child: ConfirmPasswordView(usuarioVO)));
      //_guardarRegistro();
    } else
      showMessageError(context, 'Debe completar el formulario de registro');
  }

  UsuarioVO _almacenarDatosIngresados() {
    return UsuarioVO(
        rut: extraerIdUsuario(_idUsuario),
        digitoV: getDigitoVerificador(_idUsuario),
        nombres: _txtControllerNombre.text,
        apellidoP: _txtControllerApellidoP.text,
        apellidoM: _txtControllerApellidoM.text,
        region: _dropRegiones,
        ciudad: _dropCiudad,
        comuna: _dropComuna,
        direccion: _txtControllerDireccion.text,
        rubro: null,
        email: _txtControllerEmail.text,
        numeroCel: int.tryParse(_txtControllerFono.text),
        edad: null,
        fechaNac: null,
        id: null);
  }
}
