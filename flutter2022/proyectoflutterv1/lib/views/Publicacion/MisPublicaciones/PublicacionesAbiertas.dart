import 'package:flutter/material.dart';
import 'package:proyectoflutterv1/Enum/EstadoPublicacion.dart';
import 'package:proyectoflutterv1/constantes/Constantes.dart';
import 'package:proyectoflutterv1/models/CargaData/PublicacionBD.dart';
import 'package:proyectoflutterv1/models/VO/PublicacionProductoVO.dart';
import 'package:proyectoflutterv1/models/VO/UsuarioVO.dart';
import 'package:proyectoflutterv1/views/Widget/TarjetasPublicacion/TarjetasWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PublicacionesAbiertas extends StatefulWidget {
  final UsuarioVO usuario;

  PublicacionesAbiertas({required this.usuario});
  @override
  State<StatefulWidget> createState() => PubAbiertas(this.usuario);
}

class PubAbiertas extends State<PublicacionesAbiertas> {
  final UsuarioVO _usuario;

  PubAbiertas(this._usuario);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        StreamBuilder<QuerySnapshot>(
            stream: PublicacionBD.instance.cargarPublicacionesUsuarioAbiertas(
                _usuario
                    .rut), //FirebaseFirestore.instance.collection("publicacion").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: CircularProgressIndicator(
                        color: Colors.green, strokeWidth: 6.0));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                        color: Colors.green, strokeWidth: 6.0));
              }
              if (snapshot.data!.docs.length == 0) {
                return Center(
                    child: Text("No hay publicaciones abiertas.",
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
                        estadoPublicacion: EstadoPublicacion.ABIERTA,
                        context: context);
                  });
            })
      ],
    );
  }
}
