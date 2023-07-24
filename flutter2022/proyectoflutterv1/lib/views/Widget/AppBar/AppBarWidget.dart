import 'package:flutter/material.dart';
import 'package:proyectoflutterv1/constantes/Constantes.dart';
import 'package:proyectoflutterv1/Utils/UtilitadadesFuture.dart';
import 'package:proyectoflutterv1/models/VO/FotosProductoVO.dart';
import 'package:proyectoflutterv1/models/VO/PublicacionProductoVO.dart';
import 'package:proyectoflutterv1/models/VO/UsuarioVO.dart';

PreferredSizeWidget getAppBarConTitulo(
    {required String tituloBarra, bool pagAnterior = false}) {
  return AppBar(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(0),
      )),
      automaticallyImplyLeading: pagAnterior,
      centerTitle: true,
      //shadowColor: Color(0xff354b0e),
      //elevation: ELEVATION_APPBAR,
      title: Text(tituloBarra,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: SIZE_TITULO_APPBAR,
              fontFamily: FONTFAMILY_TITULO_PAGINA)),
      backgroundColor: COLOR_FONDO_APPBAR);
}

PreferredSizeWidget getAppBarRectrocederTranparente({String? titulo = ""}) {
  return AppBar(
    iconTheme: IconThemeData(color: COLOR_TEXTO_GENERAL_PAGINA),
    elevation: 0,
    backgroundColor: COLOR_TRANSPARENTE,
    automaticallyImplyLeading: true,
    centerTitle: true,
    title: Text(titulo.toString(),
        style: TextStyle(
            color: COLOR_TEXTO_GENERAL_PAGINA,
            fontWeight: FontWeight.w400,
            fontSize: SIZE_TITULO_APPBAR,
            fontFamily: FONTFAMILY_TITULO_PAGINA)),
  );
}

PreferredSizeWidget getAppBarConTituloTranparente(
    {required String tituloBarra, bool pagAnterior = false}) {
  return AppBar(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(0),
      )),
      automaticallyImplyLeading: pagAnterior,
      centerTitle: true,
      //shadowColor: Color(0xff354b0e),
      //elevation: ELEVATION_APPBAR,
      title: Text(tituloBarra,
          style: TextStyle(
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(0.0, 2.0),
                  blurRadius: 2.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ],
              fontWeight: FontWeight.w400,
              fontSize: SIZE_TITULO_APPBAR,
              fontFamily: FONTFAMILY_TITULO_PAGINA)),
      backgroundColor: COLOR_TRANSPARENTE);
}

PreferredSizeWidget getAppBarTituloFoto(
    {required String titulo,
    required UsuarioVO usuario,
    required BuildContext context,
    required FotosProductoVO fotosProducto,
    required PublicacionProductoVO publicacion,
    bool actualizacion = false,
    bool pagAnterior = false}) {
  return AppBar(
      // automaticallyImplyLeading: pagAnterior,
      centerTitle: true,
      //shadowColor: Color(0xff354b0e),
      //elevation: ELEVATION_APPBAR,
      actions: <Widget>[
        // Navigate to the Search Screen
        IconButton(
            onPressed: () {
              optionDialogBox(
                  fotosProducto: fotosProducto,
                  context: context,
                  usuario: usuario,
                  publicacion: publicacion,
                  actualizacion: actualizacion);
            },
            icon: Icon(Icons.camera_alt))
      ],
      title: Text(titulo,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: SIZE_TITULO_APPBAR,
              fontFamily: FONTFAMILY_TITULO_PAGINA)),
      backgroundColor: COLOR_FONDO_APPBAR);
}

PreferredSizeWidget getAppBarDrawer({required String tituloBarra}) {
  return AppBar(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(0),
      )),
      //automaticallyImplyLeading: false,
      centerTitle: true,
      //shadowColor: Color(0xff354b0e),
      //elevation: ELEVATION_APPBAR,

      title: Text(tituloBarra,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: SIZE_TITULO_APPBAR,
              fontFamily: FONTFAMILY_TITULO_PAGINA)),
      backgroundColor: COLOR_FONDO_APPBAR);
}

PreferredSizeWidget getAppBarBusqueda(BuildContext? context) {
  return AppBar(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(0),
    )),
    //automaticallyImplyLeading: false,
    centerTitle: true,
    elevation: 0,

    backgroundColor: COLOR_FONDO_APPBAR,
    actions: <Widget>[
      // Navigate to the Search Screen
      /*  TextFormField(
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: SIZE_LABEL_INPUT + 10,
            color: COLOR_LABEL_INPUT),
        decoration: decoracionInputTextFormField("Rut"),
      )*/
      IconButton(onPressed: () {}, icon: Icon(Icons.search))
    ],
  );
}

PreferredSizeWidget getAppBarVacia() {
  return AppBar(
    //automaticallyImplyLeading: false,
    centerTitle: true,
    backgroundColor: COLOR_FONDO_APPBAR,
  );
}

PreferredSizeWidget getAppBarTabBar(
    TabController? _tabcontroller,
    UsuarioVO usuario,
    BuildContext context,
    PublicacionProductoVO publicacion) {
  FotosProductoVO fotosProducto = new FotosProductoVO();

  return AppBar(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(0),
    )),
    //automaticallyImplyLeading: false,
    centerTitle: true,
    backgroundColor: COLOR_FONDO_APPBAR,
    actions: <Widget>[
      // Navigate to the Search Screen
      IconButton(
          onPressed: () {
            optionDialogBox(
                fotosProducto: fotosProducto,
                context: context,
                usuario: usuario,
                publicacion: publicacion);
          },
          icon: Icon(Icons.camera_alt))
    ],
    title: Text("Mis publicaciones",
        style: TextStyle(fontFamily: FONTFAMILY_TITULO_PAGINA)),
    bottom: TabBar(
      labelStyle: TextStyle(fontFamily: FONTFAMILY_TITULO_PAGINA),
      indicatorColor: Colors.orangeAccent,
      indicatorSize: TabBarIndicatorSize.label,
      /* indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), // Creates border
                  color: Colors.green.shade100),*/
      controller: _tabcontroller,
      tabs: <Widget>[
        Tab(text: "Abiertas", icon: Icon(Icons.check_circle)),
        Tab(text: "Cerradas", icon: Icon(Icons.close_sharp)),
        Tab(text: "Eliminadas", icon: Icon(Icons.delete)),
      ],
    ),
  );
}
