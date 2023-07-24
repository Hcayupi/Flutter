import 'package:flutter/material.dart';
import 'package:proyectoflutterv1/Enum/EstadoPublicacion.dart';
import 'package:proyectoflutterv1/constantes/Constantes.dart';
import 'package:proyectoflutterv1/models/CargaData/PublicacionBD.dart';
import 'package:proyectoflutterv1/models/VO/PublicacionProductoVO.dart';
import 'package:proyectoflutterv1/models/VO/UsuarioVO.dart';
import 'package:proyectoflutterv1/views/Widget/TarjetasPublicacion/TarjetasWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PublicacionesCerradas extends StatefulWidget {
  final UsuarioVO usuario;

  PublicacionesCerradas({required this.usuario});
  @override
  State<StatefulWidget> createState() => PubCerradas(this.usuario);
}

class PubCerradas extends State<PublicacionesCerradas> {
  final UsuarioVO _usuario;

  PubCerradas(this._usuario);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        StreamBuilder<QuerySnapshot>(
            stream: PublicacionBD.instance.cargarPublicacionesUsuarioCerradas(
                _usuario
                    .rut), //FirebaseFirestore.instance.collection("publicacion").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 6.0));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 6.0));
              }
              if (snapshot.data!.docs.length == 0) {
                return Center(
                    child: Text("No hay publicaciones cerradas.",
                        style: TextStyle(
                            color: COLOR_TEXTO_HAY_REGISTROS, fontSize: 20)));
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  padding: const EdgeInsets.only(top: 10.0),
                  itemBuilder: (context, index) {
                    PublicacionProductoVO publicacion =
                        PublicacionProductoVO.fromDocument(
                            snapshot.data!.docs[index]);
                    return tarjetaPublicacionUsuario(
                        publicacion: publicacion,
                        usuarioPublicacion: _usuario,
                        estadoPublicacion: EstadoPublicacion.CERRADA,
                        context: context);
                  });
            })
      ],
    );
  }
}
