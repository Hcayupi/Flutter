import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proyectoflutterv1/constantes/Constantes.dart';
import 'package:proyectoflutterv1/models/CargaData/ProfileBD.dart';
import 'package:proyectoflutterv1/models/VO/FotosProductoVO.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyectoflutterv1/models/VO/PublicacionProductoVO.dart';
import 'package:proyectoflutterv1/models/VO/UsuarioVO.dart';
import 'package:proyectoflutterv1/views/ModuloTienda/AgroMercado.dart';
import 'package:proyectoflutterv1/views/Publicacion/MisPublicaciones/PublicacionesPerfil.dart';
import 'package:proyectoflutterv1/views/Publicacion/NuevaPublicacion/FotoProducto.dart';
import 'package:proyectoflutterv1/views/Widget/ListTile/ListTileDrawer.dart';

Widget getDrawer(
    {required FotosProductoVO fotosProductoVO,
    required List<XFile?> listaFotos,
    required BuildContext context,
    required UsuarioVO usuario}) {
  return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(35), bottomRight: Radius.circular(35)),
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
                height: MediaQuery.of(context).size.height,
                color: COLOR_FONDO_PROFILE,
                child: Column(children: <Widget>[
                  DrawerHeader(
                      padding: EdgeInsets.only(bottom: 30),
                      curve: Curves.easeInCubic,
                      decoration: BoxDecoration(
                        color: COLOR_FONDO_PROFILE,
                        /*  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(140)),*/
                      ),
                      child: Row(children: <Widget>[
                        FutureBuilder(
                            future: ProfileBD.instance
                                .cargaImagenPerfil(usuario.rut),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> path) {
                              String pathImg = path.data.toString();
                              return new Container(
                                  margin: EdgeInsets.all(20),
                                  child: CircleAvatar(
                                      backgroundColor: COLOR_FONDO_PROFILE,
                                      backgroundImage:
                                          pathImg != "null" && pathImg != ""
                                              ? NetworkImage(pathImg)
                                              : AssetImage(IMAGEN_TIPO_PERFIL)
                                                  as ImageProvider),
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.grey)));
                            }),
                        Padding(padding: EdgeInsets.all(4.0)),
                        Text(usuario.nombres,
                            style: TextStyle(
                                fontFamily: FONTFAMILY_NOM_USER,
                                fontSize: SIZE_NAME_USER,
                                color: Colors.white)),
                      ])),

                  ListTileDrawer(
                      icono: Icons.shopping_cart,
                      colorIcono: Colors.white,
                      onTapCallBack: () {
                        Navigator.push(
                            context,
                            PageTransition(
                              ctx: context,
                              type: PageTransitionType.fade,
                              child: AgroMercado(usuario: usuario),
                            ));
                      },
                      label: 'Agro Mercado'),
                  //SizedBox(height: 3),
                  getLineaDivision(),
                  ListTileDrawer(
                      colorIcono: Colors.white,
                      icono: Icons.post_add,
                      onTapCallBack: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                ctx: context,
                                type: PageTransitionType.leftToRight,
                                alignment: Alignment.center,
                                child: FotoProducto(
                                    fotosProducto: new FotosProductoVO(),
                                    usuario: usuario,
                                    publicacion:
                                        PublicacionProductoVO.instancia)));
                      },
                      label: 'Publicar un producto'),
                  getLineaDivision(),
                  ListTileDrawer(
                      colorIcono: Colors.white,
                      icono: Icons.public,
                      onTapCallBack: () {
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                duration: const Duration(milliseconds: 400),
                                type: PageTransitionType.leftToRight,
                                child: PublicacionesPerfil(usuario)));
                      },
                      label: 'Mis publicaciones'),
                  getLineaDivision(),
                ])),
          ],
        ),
      ));
}

Divider getLineaDivision() {
  return Divider(
    height: 10,
    thickness: 1,
    indent: 5,
    endIndent: 5,
  );
}
