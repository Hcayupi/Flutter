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
import 'package:proyectoflutterv1/views/Publicacion/MisPublicaciones/ActualizarFotosPublicacion.dart';
import 'package:proyectoflutterv1/views/Publicacion/NuevaPublicacion/PublicacionExitosa.dart';
import 'package:proyectoflutterv1/views/Widget/AppBar/AppBarWidget.dart';
import 'package:proyectoflutterv1/views/Widget/FormulariosView/BottomAppBarView.dart';
import 'package:proyectoflutterv1/views/Widget/FormulariosView/MaterialDropDownView.dart';
import 'package:proyectoflutterv1/views/Widget/FormulariosView/propiedades/InputsFormularioWidget.dart';

//import 'package:proyectoflutterv1/views/Inicio_app/CodValidacion.dart';
//import 'package:ruralapp/views/Publicacion/FuncionesPublicacion.dart';

class EditarPublicacion extends StatefulWidget {
  final UsuarioVO usuario;
  final PublicacionProductoVO publicacion;
  final FotosProductoVO fotosProducto;
  EditarPublicacion(
      {required this.fotosProducto,
      required this.publicacion,
      required this.usuario,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      EdicionPublicacion(this.fotosProducto, this.publicacion, this.usuario);
}

class EdicionPublicacion extends State<EditarPublicacion>
    with TickerProviderStateMixin {
  UsuarioVO _usuario;
  String dropCategoria = 'Seleccione';
  String dropUnidad = 'Seleccione';
  String dropUnidadPeso = 'Selecciones';
  String dropCondicionVenta = 'Seleccione';
  FotosProductoVO fotosProducto = new FotosProductoVO();
  late final PublicacionProductoVO publicacion;

  final GlobalKey<FormState> _formDetalle = GlobalKey<FormState>();
  final TextEditingController _txtTituloController = TextEditingController();
  final TextEditingController _txtPrecioController = TextEditingController();
  final TextEditingController _txtPesoNetoController = TextEditingController();
  final TextEditingController _txtDetalleController = TextEditingController();

  EdicionPublicacion(this.fotosProducto, this.publicacion, this._usuario);

  @override
  void initState() {
    super.initState();
    _txtTituloController.text = publicacion.titulo;
    _txtPrecioController.text = publicacion.precio.toString();
    _txtPesoNetoController.text = publicacion.peso.toString();
    _txtDetalleController.text = publicacion.detalles;

    dropCategoria = publicacion.categoria;
    dropUnidad = publicacion.unidad;
    dropUnidadPeso = publicacion.unidadPeso;
    dropCondicionVenta = publicacion.condicionVenta;
  }

  @override
  Widget build(BuildContext context) {
    //Solo muestra barra de botones inferior y oculta la barra superior (señal, estado baterìa...)
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return Scaffold(
      backgroundColor: COLOR_FONDO_BODY,
      appBar: getAppBarDrawer(tituloBarra: "Formulario de actualización"),
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
                                                fontWeight: FontWeight.bold,
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
                                                  fontWeight: FontWeight.bold,
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

                              // SizedBox(height: ESPACIO_INPUTS_FORM),
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
                              //SizedBox(height: SIZEBOX_ESPACIO),
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
          labelForward: ACTUALIZAR,
          onTapCallForward: () => _validacionFormulario()),
    );
  }

  void _validacionFormulario() {
    var _state = _formDetalle.currentState;

    if (!_state!.validate() == false) {
      _actualizarPublicacion();
    } else
      showMessageError(context, 'Debe completar el formulario de publicación');
  }

  void _regresarCargaDeFotos() {
    PublicacionProductoVO publicacionProducto = _almacenarDatosIngresados();
    Navigator.push(
        context,
        PageTransition(
            duration: const Duration(milliseconds: 500),
            ctx: context,
            type: PageTransitionType.topToBottom,
            child: ActualizarFotosPublicacion(
              fotosProducto: this.fotosProducto,
              usuario: _usuario,
              publicacion: publicacionProducto,
            )));
  }

  PublicacionProductoVO _almacenarDatosIngresados() {
    return new PublicacionProductoVO(
        rut: _usuario.rut,
        titulo: capitalizarCadena(_txtTituloController.text),
        categoria: dropCategoria,
        precio: int.tryParse(_txtPrecioController.text) ?? 0,
        unidad: dropUnidad,
        peso: int.tryParse(_txtPesoNetoController.text) ?? 0,
        unidadPeso: dropUnidadPeso,
        condicionVenta: dropCondicionVenta,
        detalles: _txtDetalleController.text,
        fotosProducto: fotosProducto,
        id: publicacion.id);
  }

  Future<void> _actualizarPublicacion() async {
    PublicacionProductoVO publicacionProducto = _almacenarDatosIngresados();
    bool? actualizado = await PublicacionBD.instance
        .actualizarPublicacionBD(publicacion: publicacionProducto);
    print(actualizado);
    if (actualizado != null && actualizado) {
      Navigator.push(
          context,
          PageTransition(
              duration: const Duration(milliseconds: 500),
              ctx: context,
              type: PageTransitionType.leftToRight,
              child: PublicacionExitosa(this._usuario)));
    }
  }
}
