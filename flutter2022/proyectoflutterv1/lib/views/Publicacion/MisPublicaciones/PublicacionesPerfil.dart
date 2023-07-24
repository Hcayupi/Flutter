import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proyectoflutterv1/constantes/Constantes.dart';
import 'package:proyectoflutterv1/models/VO/FotosProductoVO.dart';
import 'package:proyectoflutterv1/models/VO/PublicacionProductoVO.dart';
import 'package:proyectoflutterv1/models/VO/UsuarioVO.dart';
import 'package:proyectoflutterv1/views/ModuloTienda/AgroMercado.dart';
import 'package:proyectoflutterv1/views/Publicacion/MisPublicaciones/PublicacionesAbiertas.dart';
import 'package:proyectoflutterv1/views/Publicacion/MisPublicaciones/PublicacionesCerradas.dart';
import 'package:proyectoflutterv1/views/Publicacion/MisPublicaciones/PublicacionesEliminadas.dart';
import 'package:proyectoflutterv1/views/Widget/AppBar/AppBarWidget.dart';
import 'package:proyectoflutterv1/views/Widget/Drawer/Drawer.dart';

class PublicacionesPerfil extends StatefulWidget {
  final UsuarioVO usuario;

  PublicacionesPerfil(this.usuario, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ListaPublicaciones(this.usuario);
}

class ListaPublicaciones extends State<PublicacionesPerfil>
    with TickerProviderStateMixin {
  final UsuarioVO _usuario;
  FotosProductoVO fotosProducto = new FotosProductoVO();
  TabController? _tabcontroller;
  late List<XFile?> listaFotos = [];
  ListaPublicaciones(this._usuario);

  @override
  void initState() {
    _tabcontroller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: COLOR_FONDO_BODY_PAG,
          appBar: getAppBarTabBar(
              _tabcontroller,
              _usuario,
              context,
              PublicacionProductoVO
                  .instancia), //getAppBarConTitulo(tituloBarra: "Mis publicaciones"),
          body: TabBarView(controller: _tabcontroller, children: <Widget>[
            Center(child: PublicacionesAbiertas(usuario: _usuario)),
            Center(child: PublicacionesCerradas(usuario: _usuario)),
            Center(child: PublicacionesEliminadas(usuario: _usuario))
          ]),

          drawer: getDrawer(
              fotosProductoVO: fotosProducto,
              listaFotos: listaFotos,
              context: context,
              usuario: _usuario),
        ));
  }

  void regresarAgroMercado() {
    Navigator.push(
        context,
        PageTransition(
            duration: const Duration(milliseconds: 400),
            ctx: context,
            type: PageTransitionType.rightToLeft,
            child: AgroMercado(usuario: this._usuario)));
  }
}
