import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyectoflutterv1/constantes/Constantes.dart';
import 'package:proyectoflutterv1/models/CargaData/PublicacionBD.dart';
import 'package:proyectoflutterv1/models/VO/FotosProductoVO.dart';
import 'package:proyectoflutterv1/models/VO/PublicacionProductoVO.dart';
import 'package:proyectoflutterv1/models/VO/UsuarioVO.dart';
import 'package:proyectoflutterv1/views/Widget/AppBar/AppBarWidget.dart';
import 'package:proyectoflutterv1/views/Widget/Drawer/Drawer.dart';
import 'package:proyectoflutterv1/views/Widget/TarjetasPublicacion/TarjetasWidget.dart';

class AgroMercado extends StatefulWidget {
  final UsuarioVO usuario;
  AgroMercado({Key? key, required this.usuario}) : super(key: key);
  @override
  State<StatefulWidget> createState() => MercadoAgricola(this.usuario);
}

class MercadoAgricola extends State<AgroMercado> {
  FotosProductoVO _fotosProducto = new FotosProductoVO();
  UsuarioVO _usuario;

  bool isLoading = false;

  MercadoAgricola(this._usuario);

  late List<XFile?> _listPhoto = [];

  @override
  void initState() {
    super.initState();
    _fotosProducto.listaFotos = _listPhoto;
  }

  @override
  Widget build(BuildContext context) {
    //Solo muestra barra de botones inferior y oculta la barra superior (señal, estado baterìa...)
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return Scaffold(
      backgroundColor: COLOR_FONDO_BODY_PAG,
      appBar: getAppBarBusqueda(context),
      body: new Stack(children: <Widget>[
        StreamBuilder<QuerySnapshot>(
            stream: PublicacionBD.instance
                .cargarPublicaciones(), //FirebaseFirestore.instance.collection("publicacion").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 5.0));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 5.0));
              }
              if (snapshot.connectionState == ConnectionState.none) {
                return Center(child: Text("Necesita conectarse a internet"));
              } else if (snapshot.data!.docs.length == 0) {
                return Center(
                    child: Text("No hay publicaciones.",
                        style: TextStyle(
                            color: COLOR_TEXTO_HAY_REGISTROS, fontSize: 20)));
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  padding: const EdgeInsets.only(top: 5.0),
                  itemBuilder: (context, index) {
                    PublicacionProductoVO publicacion =
                        PublicacionProductoVO.fromDocument(
                            snapshot.data!.docs[index]);

                    return tarjetaPublicacion(
                        publicacionVO: publicacion,
                        usuarioPerfilVO: this._usuario,
                        context: context);
                  });
            })
      ]),
      drawer: getDrawer(
          fotosProductoVO: _fotosProducto,
          listaFotos: _listPhoto,
          context: context,
          usuario: _usuario),
      /* floatingActionButton: getFloatingActionButton(
          _fotosProducto, _listPhoto, context, _usuario, false, false, null),*/
      // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
