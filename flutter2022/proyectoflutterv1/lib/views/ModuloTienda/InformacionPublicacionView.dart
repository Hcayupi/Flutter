import 'package:flutter/material.dart';
import 'package:proyectoflutterv1/Utils/Utilidades.dart';
import 'package:proyectoflutterv1/constantes/Constantes.dart';
import 'package:proyectoflutterv1/constantes/ConstFormularios.dart';
import 'package:proyectoflutterv1/models/VO/PublicacionProductoVO.dart';
import 'package:proyectoflutterv1/models/VO/UsuarioVO.dart';
import 'package:proyectoflutterv1/views/Widget/AppBar/AppBarWidget.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:proyectoflutterv1/models/CargaData/PublicacionBD.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proyectoflutterv1/views/contabilidad/CantidadProducto.dart';

class InformacionPublicacionView extends StatefulWidget {
  final PublicacionProductoVO publicacion;
  final UsuarioVO usuarioPublicacion;
  final UsuarioVO usuarioPerfil;

  InformacionPublicacionView(
      {required this.publicacion,
      required this.usuarioPublicacion,
      required this.usuarioPerfil});
  @override
  State<StatefulWidget> createState() => InformacionPublicacionViewState(
      this.publicacion, this.usuarioPublicacion, this.usuarioPerfil);
}

class InformacionPublicacionViewState
    extends State<InformacionPublicacionView> {
  // UsuarioVO? _usuarioVO;
  late Widget widgetPrincipalSlide = _cargarImagenPrincipal();

  double _anchoPantalla = 350;
  List<XFile?>? listaFotos;
  bool _isLoading = true;
  bool _soyElCreadorDelaPublicacion = false;
  String _nombreUsuario = "";
  String _localizacion = "";
  PublicacionProductoVO _publicacion;
  UsuarioVO _usuarioPublicacion;
  UsuarioVO _usuarioPerfil;
  InformacionPublicacionViewState(
      this._publicacion, this._usuarioPublicacion, this._usuarioPerfil);

  @override
  void initState() {
    super.initState();

    if (_publicacion.rut == _usuarioPerfil.rut) {
      _soyElCreadorDelaPublicacion = true;
    }
    _cargarDatosUsuario();
    _cargarListaDeImagenes();
  }

  @override
  void dispose() {
    super.dispose();
    _cargarListaDeImagenes();
  }

  _cargarDatosUsuario() {
    _nombreUsuario = _usuarioPublicacion.nombres;
    _localizacion =
        _usuarioPublicacion.region + ", " + _usuarioPublicacion.comuna;
  }

  @override
  Widget build(BuildContext context) {
    _anchoPantalla = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xfffef2da), //COLOR_FONDO_BODY,
      appBar: getAppBarConTituloTranparente(
          tituloBarra: StringUtils.capitalize("Información del producto"),
          pagAnterior: true),
      body: Container(
          //height: _altoPantalla,
          child: SingleChildScrollView(
              child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment(-0.9, 1),
            children: [
              Hero(
                  tag: _publicacion.id.toString(), child: widgetPrincipalSlide),
              _mostrarInformacionProductor()
            ],
          ),
          _isLoading
              ? Container(
                  alignment: Alignment.center,
                  child: Center(
                      child: LinearProgressIndicator(
                          minHeight: 3, color: Colors.green)))
              : Container(
                  child: SizedBox(height: 3, width: 420),
                  color: Color(0xff460b2e).withOpacity(0.8),
                ),
          Container(
              child: Column(children: <Widget>[
            _mostrarFecha(),
            SizedBox(height: 20),
            _listaCuadrosInformativos(),
            SizedBox(height: 20),
            _cuadroDescripcion(),
            SizedBox(height: 20),
            _seccionBotonesAccion(),
            SizedBox(height: 50),
          ]))
        ],
      ))),
      //bottomNavigationBar: _getBarraDeBotones(),
    );
  }

  Widget _cuadroDescripcion() {
    return Container(
        width: _anchoPantalla - 20,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: Color(0xFFC0B7B7), spreadRadius: 1, blurRadius: 7),
        ], borderRadius: BorderRadius.circular(10), color: Color(0xFFFFFFFF)),
        child: Column(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                height: 70,
                width: _anchoPantalla - 20,
                child: Text(capitalizarCadena(_publicacion.titulo),
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontFamily: FONTFAMILY_TITULO_PAGINA,
                      fontSize: SIZE_TEXT_TITULO_PUBL + 2,
                      //fontWeight: FontWeight.bold,
                    ),
                    softWrap: false,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis)),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(15),
              child: Text(_publicacion.detalles,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: FONTFAMILY_TEXTO_PUBL,
                      fontSize: 19),
                  maxLines: 7,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ));
  }

  void _cargarListaDeImagenes() async {
    await Future.wait(
            [PublicacionBD.instance.cargarFotosPublicacion(_publicacion)])
        .then((value) {
      if (value[0].listaFotos!.length > 1) {
        if (mounted)
          setState(() {
            _isLoading = false;
            listaFotos = value[0].listaFotos;
            _crearSlideDeImagenes();
          });
      } else if (mounted)
        setState(() {
          _isLoading = false;
        });
    });
  }

  Widget _cargarImagenPrincipal() {
    return _publicacion.imagenprevia != "null" &&
            _publicacion.imagenprevia != ""
        ? Image.network(_publicacion.imagenprevia.toString(),
            width: _anchoPantalla, height: 350, fit: BoxFit.cover)
        : _imagenDefault();
  }

  void _crearSlideDeImagenes() {
    widgetPrincipalSlide = Container(
        color: Colors.black87,
        child: CarouselSlider(
          options: CarouselOptions(height: 350, autoPlay: true),
          items: listaFotos!.map((item) {
            return ClipRRect(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(item!.path.toString(),
                      width: MediaQuery.of(context).size.width,
                      height: 350,
                      fit: BoxFit.cover),
                ],
              ),
            );
          }).toList(),
        ));
  }

  Widget _seccionBotonesAccion() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _publicacion.condicionVenta == ConstFormularios.ventaInmediata &&
                  !_soyElCreadorDelaPublicacion
              ? GestureDetector(
                  child: _dibujaBotonAccion(
                      colorTexto: Color(0xFFfdf6f4),
                      colorBoton: Color(0xFFE46330),
                      icono: Icons.shopping_bag,
                      etiqueta: 'Comprar'),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                          duration:
                              const Duration(milliseconds: DURATION_TRANSITION),
                          type: PageTransitionType.bottomToTop,
                          child: CantidadProducto(
                              publicacion: _publicacion,
                              usuarioPublicacion: _usuarioPublicacion,
                              usuarioPerfil: _usuarioPerfil),
                        ));
                  })
              : _dibujaBotonAccion(
                  colorTexto: Color(0xFF73b26b),
                  colorBoton: Color(0xFFBCDAB8),
                  icono: Icons.shopping_bag,
                  etiqueta: 'Comprar '),
          _publicacion.condicionVenta == ConstFormularios.previaReservacion &&
                  !_soyElCreadorDelaPublicacion
              ? GestureDetector(
                  child: _dibujaBotonAccion(
                      colorTexto: Color(0xFFdaeff6),
                      colorBoton: Color(0xFF298FC2),
                      icono: Icons.restore_page,
                      etiqueta: 'Reservar'),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                          duration:
                              const Duration(milliseconds: DURATION_TRANSITION),
                          type: PageTransitionType.bottomToTop,
                          child: CantidadProducto(
                              publicacion: _publicacion,
                              usuarioPublicacion: _usuarioPublicacion,
                              usuarioPerfil: _usuarioPerfil,
                              reserva: true),
                        ));
                  })
              : _dibujaBotonAccion(
                  colorTexto: Color(0xFF73b26b),
                  colorBoton: Color(0xFFBCDAB8),
                  icono: Icons.restore_page,
                  etiqueta: 'Reservar'),
          !_soyElCreadorDelaPublicacion
              ? GestureDetector(
                  child: _dibujaBotonAccion(
                      colorTexto: Color(0xFFf9dfa6),
                      colorBoton: Color(0xFFEE9C44),
                      icono: Icons.save,
                      etiqueta: 'Guardar publicación'),
                  onTap: () {})
              : _dibujaBotonAccion(
                  colorTexto: Color(0xFF73b26b),
                  colorBoton: Color(0xFFBCDAB8),
                  icono: Icons.save,
                  etiqueta: 'Guardar publicación')
        ],
      ),
    );
  }

  Container _dibujaBotonAccion(
      {required Color colorTexto,
      required Color colorBoton,
      required IconData icono,
      required String etiqueta}) {
    return Container(
        decoration: BoxDecoration(
            color: colorBoton, borderRadius: BorderRadius.circular(10)),
        width: 120,
        height: 90,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icono, color: colorTexto),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                etiqueta,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colorTexto,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ));
  }

  Widget _listaCuadrosInformativos() {
    return Container(
        alignment: Alignment.center,
        height: 80.0,
        child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              _dibujaCuadroInformativo(
                  datoPublicacion: _publicacion.unidad.toString(),
                  color: Colors.transparent,
                  icono: Icons.inbox,
                  etiqueta: "Tipo Unidad",
                  tamagno: 15,
                  anchoCuadro: 120),
              SizedBox(width: 2),
              _dibujaCuadroInformativo(
                  datoPublicacion:
                      "\$" + formatearCifra(_publicacion.precio.toString()),
                  color: Colors.transparent,
                  icono: Icons.price_change,
                  etiqueta: "Precio Unidad",
                  tamagno: 15,
                  anchoCuadro: 120),
              SizedBox(width: 2),
              _dibujaCuadroInformativo(
                  datoPublicacion: _publicacion.peso.toString() +
                      ' ' +
                      ConstFormularios
                          .abreviaturaUnidad[_publicacion.unidadPeso.toString()]
                          .toString(),
                  color: Colors.transparent,
                  icono: Icons.inbox,
                  etiqueta: "Peso neto",
                  tamagno: 15,
                  anchoCuadro: 120),
              SizedBox(width: 2),
              _dibujaCuadroInformativo(
                  datoPublicacion: _publicacion.condicionVenta,
                  color: Colors.transparent,
                  icono: Icons.business,
                  etiqueta: "Tipo Venta",
                  tamagno: 15,
                  anchoCuadro: 120),
              SizedBox(width: 2),
              _dibujaCuadroInformativo(
                  datoPublicacion:
                      formatearFecha(_publicacion.fechaModificacion),
                  color: Colors.transparent,
                  icono: Icons.business,
                  etiqueta: "Última modificación",
                  tamagno: 15,
                  anchoCuadro: 120)
            ]));
  }

  Widget _dibujaCuadroInformativo(
      {required String datoPublicacion,
      required Color color,
      required IconData icono,
      required String etiqueta,
      required double tamagno,
      required double anchoCuadro}) {
    return /*ClipOval(
        child: new
        */
        Container(

            // color: color,
            decoration: BoxDecoration(
                /*     boxShadow: [
                  BoxShadow(
                      color: Color(0xFF94A865).withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5),
                ],*/
                color: Color(0xFF7FAC18).withOpacity(0.5),
                borderRadius: BorderRadius.circular(10)
                // shape: BoxShape.circle
                ),
            alignment: Alignment.center,
            //color: Colors.amber,
            width: anchoCuadro,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //Icon(icono, size: 30),
                  Text(etiqueta,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF425C06),
                        fontSize: tamagno,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(height: 5),
                  Text(datoPublicacion,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: tamagno + 1, color: Color(0xFF425C06))),
                ]));
  }

  _mostrarFecha() {
    return Container(
      //color: Colors.green.shade100,
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    "Publicado el:  " +
                        formatearFecha(_publicacion.fechaInicio),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: FONTFAMILY_TITULO_PAGINA,
                      fontSize: SIZE_TEXT_TITULO_PUBL - 5,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _mostrarInformacionProductor() {
    return Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        width: _anchoPantalla,
        height: 75,
        color: Color(0xff001707).withOpacity(0.4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                ' Productor: ' + _nombreUsuario,
                style: TextStyle(
                  fontFamily: FONTFAMILY_TITULO_PAGINA,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              ' ' + _localizacion,
              style: TextStyle(
                fontFamily: FONTFAMILY_TITULO_PAGINA,
                fontSize: 15,
                color: Colors.grey[300],
              ),
            ),
          ],
        ));
  }

  Widget _imagenDefault() {
    return Image.asset(
      IMAGEN_TIPO_PUBLICACION,
      //  Image.network("$element['image_url']", //"$element['rutaImg']",
      width: _anchoPantalla,
      height: 350,
      fit: BoxFit.fill,
    );
  }
}
