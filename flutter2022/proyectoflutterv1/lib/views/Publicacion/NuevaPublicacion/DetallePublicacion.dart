import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proyectoflutterv1/Utils/Mensajes.dart';
import 'package:proyectoflutterv1/Utils/Utilidades.dart';
import 'package:proyectoflutterv1/constantes/Constantes.dart';
import 'package:proyectoflutterv1/constantes/ConstFormularios.dart';
import 'package:proyectoflutterv1/models/CargaData/PublicacionBD.dart';
import 'package:proyectoflutterv1/models/VO/PublicacionProductoVO.dart';
import 'package:proyectoflutterv1/models/VO/FotosProductoVO.dart';
import 'package:proyectoflutterv1/models/VO/UsuarioVO.dart';
import 'package:proyectoflutterv1/views/Publicacion/NuevaPublicacion/FotoProducto.dart';
import 'package:proyectoflutterv1/views/Publicacion/NuevaPublicacion/PublicacionExitosa.dart';
import 'package:proyectoflutterv1/views/Widget/AppBar/AppBarWidget.dart';
import 'package:proyectoflutterv1/views/Widget/FormulariosView/BottomAppBarView.dart';
import 'package:proyectoflutterv1/views/Widget/FormulariosView/MaterialDropDownView.dart';
import 'package:proyectoflutterv1/views/Widget/FormulariosView/propiedades/InputsFormularioWidget.dart';

//import 'package:proyectoflutterv1/views/Inicio_app/CodValidacion.dart';
//import 'package:ruralapp/views/Publicacion/FuncionesPublicacion.dart';

class DetallePublicacion extends StatefulWidget {
  final FotosProductoVO fotosProducto;
  final PublicacionProductoVO? publicacion;
  final UsuarioVO usuario;
  DetallePublicacion(
      {required this.fotosProducto,
      required this.usuario,
      this.publicacion,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => DetallePublicacionState(
      this.fotosProducto, this.usuario, this.publicacion);
}

class DetallePublicacionState extends State<DetallePublicacion>
    with TickerProviderStateMixin {
  String dropCategoria = 'Seleccione';
  String dropUnidad = 'Seleccione';
  String dropUnidadPeso = 'Seleccione';
  String dropCondicionVenta = 'Seleccione';
  FotosProductoVO _fotosProductoVO;
  PublicacionProductoVO? _publicacion;
  UsuarioVO _usuario;
  final GlobalKey<FormState> _formDetalle = GlobalKey<FormState>();
  final TextEditingController _txtTituloController = TextEditingController();
  final TextEditingController _txtPrecioController = TextEditingController();
  final TextEditingController _txtPesoNetoController = TextEditingController();
  final TextEditingController _txtDetalleController = TextEditingController();

  DetallePublicacionState(
      this._fotosProductoVO, this._usuario, this._publicacion);

  @override
  void initState() {
    /*  _animationController = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);
    _colorTween = ColorTween(begin: Colors.yellow, end: Colors.blue)
        .animate(_animationController);*/
    if (_publicacion!.id != null) {
      dropCategoria = _publicacion!.categoria;
      dropUnidad = _publicacion!.unidad;
      dropUnidadPeso = _publicacion!.unidadPeso;
      dropCondicionVenta = _publicacion!.condicionVenta;

      _txtTituloController.text = _publicacion!.titulo;
      _txtPrecioController.text = _publicacion!.precio.toString();
      _txtPesoNetoController.text = _publicacion!.peso.toString();
      _txtDetalleController.text = _publicacion!.detalles;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Solo muestra barra de botones inferior y oculta la barra superior (señal, estado baterìa...)
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return Scaffold(
      backgroundColor: COLOR_FONDO_BODY,
      appBar: getAppBarDrawer(tituloBarra: "Formulario de publicación"),
      //resizeToAvoidBottomInset: false,
      body: new Stack(children: <Widget>[
        SafeArea(
            // top: true,
            child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    //color: Colors.amber,
                    child: Form(
                        key: _formDetalle,
                        autovalidateMode: AutovalidateMode.always,
                        child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SizedBox(height: ESPACIO_INPUTS_FORM + 6),
                              agregarEtiquetaInput("Titulo"),
                              inputTextFormField(
                                  _txtTituloController, ConstFormularios.titulo,
                                  tecladoNumber: false),
                              // SizedBox(height: ESPACIO_INPUTS_FORM),
                              agregarEtiquetaInput("Categoría"),
                              MaterialDropDownView(
                                  onChangedCallback: (value) {
                                    setState(() {
                                      dropCategoria = value;
                                    });
                                  },
                                  value: dropCategoria,
                                  label: ConstFormularios.categoria,
                                  values: ConstFormularios.itemsCategoria),
                              //SizedBox(height: ESPACIO_INPUTS_FORM),
                              Row(children: <Widget>[
                                Expanded(
                                  child: Column(children: <Widget>[
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          agregarEtiquetaInput("Precio"),
                                          SizedBox(width: 132),
                                          agregarEtiquetaInput("Unidad"),
                                        ]),
                                    Row(children: <Widget>[
                                      Expanded(
                                          child: inputTextFormField(
                                              _txtPrecioController,
                                              ConstFormularios.precio,
                                              tecladoNumber: true)),
                                      //inputTextFormField(_txtPesoNetoController,FDetalles.pesoNeto,tecladoNumber: true))),
                                      SizedBox(width: 2),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 18.0),
                                          child: Text(
                                            "X",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          )),
                                      SizedBox(width: 2),
                                      Expanded(
                                          child: MaterialDropDownView(
                                              onChangedCallback: (value) {
                                                setState(() {
                                                  dropUnidad = value;
                                                });
                                              },
                                              value: dropUnidad,
                                              label: ConstFormularios.unidad,
                                              values: ConstFormularios
                                                  .itemsUnidad)),
                                    ])
                                  ]),
                                )
                              ]),
                              //SizedBox(height: ESPACIO_INPUTS_FORM),

                              Row(children: <Widget>[
                                Expanded(
                                    child: Column(children: <Widget>[
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        agregarEtiquetaInput("Peso Neto"),
                                        SizedBox(width: 100),
                                        agregarEtiquetaInput("Unidad"),
                                      ]),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Expanded(
                                            child: inputTextFormField(
                                                _txtPesoNetoController,
                                                ConstFormularios.pesoNeto,
                                                tecladoNumber: true)),
                                        //inputTextFormField(_txtPesoNetoController,FDetalles.pesoNeto,tecladoNumber: true))),
                                        SizedBox(width: 2),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 18.0),
                                            child: Text(
                                              "X",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            )),
                                        SizedBox(width: 2),
                                        Expanded(
                                            child: MaterialDropDownView(
                                                onChangedCallback: (value) {
                                                  setState(() {
                                                    dropUnidadPeso = value;
                                                  });
                                                },
                                                value: dropUnidadPeso,
                                                label: ConstFormularios.unidad,
                                                values: ConstFormularios
                                                    .itemsUnidadPeso)),
                                      ]),
                                ]))
                              ]),
                              agregarEtiquetaInput("Tipo de venta"),
                              MaterialDropDownView(
                                  onChangedCallback: (value) {
                                    setState(() {
                                      dropCondicionVenta = value;
                                    });
                                  },
                                  value: dropCondicionVenta,
                                  label: ConstFormularios.condicionVenta,
                                  values: ConstFormularios.itemsCondicionVenta),
                              // SizedBox(height: SIZEBOX_ESPACIO),
                              agregarEtiquetaInput("Detalles"),
                              inputTextFormField(_txtDetalleController,
                                  ConstFormularios.detalle,
                                  maxLines: 7, tecladoNumber: false),
                              SizedBox(height: SIZEBOX_ESPACIO),
                            ])))))
      ]),
      bottomNavigationBar: BottomAppBarView(
          labelBack: FOTOS,
          onTapCallBack: () => _regresarCargaDeFotos(),
          labelForward: PUBLICAR,
          onTapCallForward: () => _validacionFormulario()),
    );
  }

  void _validacionFormulario() {
    var _state = _formDetalle.currentState;

    if (!_state!.validate() == false) {
      guardarPublicacion();
    } else
      showMessageError(context, 'Debe completar el formulario de publicación');

    /*cuadroAlertaValidacion(
          "Debe completar el formulario de publicación", "Ok", context);*/
  }

  void _regresarCargaDeFotos() {
    PublicacionProductoVO _publicacionProducto = _almacenarDatosIngresados();
    Navigator.push(
        context,
        PageTransition(
            duration: const Duration(milliseconds: 500),
            ctx: context,
            type: PageTransitionType.topToBottom,
            child: FotoProducto(
                fotosProducto: this._fotosProductoVO,
                usuario: _usuario,
                publicacion: _publicacionProducto)));
  }

  PublicacionProductoVO _almacenarDatosIngresados() {
    return new PublicacionProductoVO(
        rut: _usuario.rut,
        titulo: capitalizarCadena(_txtTituloController.text),
        categoria: dropCategoria,
        precio: int.tryParse(_txtPrecioController.text) ?? 0,
        unidad: dropUnidad,
        unidadPeso: dropUnidadPeso,
        peso: int.tryParse(_txtPrecioController.text) ?? 0,
        condicionVenta: dropCondicionVenta,
        detalles: _txtDetalleController.text,
        fotosProducto: _fotosProductoVO);
  }

  Future<void> guardarPublicacion() async {
    PublicacionProductoVO _publicacionProducto = _almacenarDatosIngresados();
    Future.wait([PublicacionBD.instance.guardarProducto(_publicacionProducto)])
        .then((value) {
      print("-------Detalles------" + value[0].toString());
      if (value[0] == true) {
        Navigator.push(
            context,
            PageTransition(
                duration: const Duration(milliseconds: 500),
                ctx: context,
                type: PageTransitionType.leftToRight,
                child: PublicacionExitosa(this._usuario)));
      }
    });
  }
}
