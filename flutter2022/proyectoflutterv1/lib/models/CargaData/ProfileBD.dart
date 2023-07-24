import 'package:flutter/material.dart';
import 'package:proyectoflutterv1/Utils/Utilidades.dart';
import 'package:proyectoflutterv1/models/CargaData/PublicacionBD.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyectoflutterv1/models/VO/UsuarioVO.dart';

class ProfileBD {
  ProfileBD._privateConstructor();

  static final ProfileBD _instance = ProfileBD._privateConstructor();

  static ProfileBD get instance {
    return _instance;
  }

  Future<String> cargaImagenPerfil(int? idUsuario) async {
    PublicacionBD.instance.signInAnonymously();
    String pathImagen = "";

    try {
      ListResult result = await FirebaseStorage.instance
          .ref()
          .child("users/$idUsuario/foto_perfil")
          .listAll();

      for (var i = 0; i < result.items.length; i++) {
        pathImagen = await FirebaseStorage.instance
            .ref()
            .child(result.items[i].fullPath)
            .getDownloadURL();
        break;
      }
    } on Exception catch (e) {
      print(e);
    }

    return pathImagen;
  }

  Future<Map<String, dynamic>> existeUsuario(
      String rutUsuario, BuildContext context) async {
    Map<String, dynamic> resultado = {"existe": false, "confirmado": false};
    int? idUsuario = extraerIdUsuario(rutUsuario);

    try {
      final firebaseInstance = FirebaseFirestore.instance.collection("users");
      var snapshotUser =
          await firebaseInstance.where('rut', isEqualTo: idUsuario).get();
      snapshotUser.docs.forEach((result) {
        if (result.data().isNotEmpty) {
          resultado["existe"] = true;

          if (result.data()["confirmado"]) {
            resultado["confirmado"] = true;
          }
        }
      });
    } catch (e) {
      // showMessageError(context, 'Error ');
      print("Error de consulta");
    }

    return resultado;
  }

  Future<UsuarioVO> cargarDatosUsuario(String rutUsuario) async {
    UsuarioVO usuarioVO = UsuarioVO.instance;
    final firebaseInstance = FirebaseFirestore.instance.collection("users");
    int? idUsuario = 0;

    if (rutUsuario.length > 8) {
      idUsuario = extraerIdUsuario(rutUsuario);
    } else
      idUsuario = int.tryParse(rutUsuario);

    var snapshotUser =
        await firebaseInstance.where('rut', isEqualTo: idUsuario).get();
    if (snapshotUser.docs.isNotEmpty) {
      usuarioVO = UsuarioVO.fromMap(snapshotUser.docs[0].data());
    }

    return usuarioVO;
  }

  Future<bool?> guardarRegistro({required UsuarioVO registro}) async {
    var firebaseInstance = FirebaseFirestore.instance;

    bool? guardado = await firebaseInstance.collection("users").add({
      "rut": registro.rut,
      "digitoV": registro.digitoV,
      "nombres": registro.nombres,
      "apellidoP": registro.apellidoP,
      "apellidoM": registro.apellidoM,
      "region": registro.region,
      "ciudad": registro.ciudad,
      "comuna": registro.comuna,
      "direccion": registro.direccion,
      "telefono": registro.numeroCel,
      "rubro": registro.rubro == null ? null : registro.rubro,
      "email": registro.email,
      "edad": registro.edad == null ? null : registro.edad,
      "fechaNac": registro.fechaNac == null ? null : registro.fechaNac,
      "fecha_creation": DateTime.fromMillisecondsSinceEpoch(
              Timestamp.now().toDate().millisecondsSinceEpoch,
              isUtc: true)
          .toString(),
      "fecha_update": DateTime.fromMillisecondsSinceEpoch(
              Timestamp.now().toDate().millisecondsSinceEpoch,
              isUtc: true)
          .toString(),
      "fecha_delete": null,
      "confirmado": registro.confirmado,
      "password": registro.password,
      "eliminado": false
    }).then((value) {
      if (value.id.isNotEmpty) {
        return true;
      }
    }).catchError((error) {
      print("Error eliminar publicacion:     ");
      print(error);
      print("Hubo un problema al eliminar la publicación");
      return false;
    });

    return guardado;
  }

  Future<bool?> actualizarConfirmacion(
      bool confirmacion, int? rut, int? numTelefono) async {
    final firebaseInstance = FirebaseFirestore.instance.collection("users");
    var snapshotUser =
        await firebaseInstance.where('rut', isEqualTo: rut).get();
    // print(snapshotUser.docs[0].id);

    bool actualizado = await firebaseInstance
        .doc(snapshotUser.docs[0].id)
        .update({"confirmado": confirmacion, "telefono": numTelefono}).then(
            (value) {
      return true;
    }).catchError((error) {
      print("Error eliminar publicacion:     ");
      print(error);
      print("Hubo un problema al eliminar la publicación");
      return false;
    });

    return actualizado;
  }
}
