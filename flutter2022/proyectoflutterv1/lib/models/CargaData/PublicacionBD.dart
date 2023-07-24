import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:proyectoflutterv1/Utils/Validadores.dart';
import 'package:proyectoflutterv1/models/VO/FotosProductoVO.dart';
import 'package:proyectoflutterv1/models/VO/PublicacionProductoVO.dart';
import 'package:image_picker/image_picker.dart';

class PublicacionBD {
  PublicacionBD._privateConstructor();

  static final PublicacionBD _instance = PublicacionBD._privateConstructor();

  static PublicacionBD get instance {
    return _instance;
  }

  Future<bool?> actualizarPublicacionBD(
      {required PublicacionProductoVO publicacion}) async {
    var firebaseInstance = FirebaseFirestore.instance;
    await firebaseInstance
        .collection("publicacion")
        .doc(publicacion.id)
        .update({
      "titulo": publicacion.titulo,
      "categoria": publicacion.categoria,
      "precio": publicacion.precio,
      "imagenprevia": "",
      "pesoNeso": publicacion.peso,
      "unidad": publicacion.unidad,
      "unidadPeso": publicacion.unidadPeso,
      "condicion": publicacion.condicionVenta,
      "detalleProducto": publicacion.detalles,
      "fechamodificacion": DateTime.fromMillisecondsSinceEpoch(
              Timestamp.now().toDate().millisecondsSinceEpoch,
              isUtc: true)
          .toString()
    });

    actualizaListaFotosPublicacion(publicacion);

    if (publicacion.fotosProducto!.listaFotos!.length == 0) return true;

    return await Future.wait([
      guardarFoto(
          idUsuario: publicacion.rut as int,
          idDocument: publicacion.id as String,
          listaFotos: publicacion.fotosMemoriaLocal as List<XFile?>)
    ]).then((guardado) async {
      if (guardado[0] == true) {
        await Future.wait([cargarUnaImagenPublicacion(publicacion)])
            .then((imagen) async {
          print(imagen);
          _actualizarImagenPrevia(publicacion, imagen[0]);
        }).then((value) => print("Se actualiza la publicacion"));
        return true;
      }
      return false;
    });
  }

  ///Función que elimina todas las imágenes seleccionada por el usuario.
  ///Luego crea una lista auxiliar que almacenarà las nuevas imagenes para reemplazar
  ///la lista original de PublicacionProductoVO publicacion
  Future<void> actualizaListaFotosPublicacion(
      PublicacionProductoVO publicacion) async {
    publicacion.fotosProducto!.fotosEliminarBD.forEach((elemento) async {
      await eliminarImagenBD(elemento);
    });
    List<XFile?>? listaAuxiliar = [];
    publicacion.fotosProducto!.listaFotos!.asMap().forEach((index, elemento) {
      if (elemento!.path.indexOf("https") >= 0) {
        listaAuxiliar.add(publicacion.fotosProducto!.listaFotos![index]);
      }
    });
    //_actualizarImagenPrevia(publicacion);
    publicacion.fotosProducto!.listaFotos!
        .removeWhere((e) => listaAuxiliar.contains(e));
  }

  ///Actualiza la imagen previa de la publicacion en caso de que se haya eliminado la anterior
  void _actualizarImagenPrevia(
      PublicacionProductoVO publicacion, String rutaImagen) async {
    await FirebaseFirestore.instance
        .collection("publicacion")
        .doc(publicacion.id)
        .update({"imagenprevia": rutaImagen}).then(
            (value) => print("Se actualiza la publicacion"));
  }

  ///Actualiza la imagen previa de la publicacion en caso de que se haya eliminado la anterior
  /* void _actualizarImagenPrevia(PublicacionProductoVO publicacion) async {
    List<XFile?>? imagenes = publicacion.fotosProducto!.listaFotos;
    if (imagenes!.length > 0 && imagenes[0]!.path.indexOf("https") >= 0) {
      await FirebaseFirestore.instance
          .collection("publicacion")
          .doc(publicacion.id)
          .update({"imagenprevia": imagenes[0]!.path}).then(
              (value) => print("Se actualiza la publicacion"));
    }
  }*/

  /// Función a  cargo de guardar la información o descripción de un producto
  Future<bool> guardarProducto(PublicacionProductoVO? publicacion) async {
    var firebaseInstance = FirebaseFirestore.instance;

    DocumentReference<Map<String, dynamic>> documentoRef =
        await firebaseInstance.collection("publicacion").add({
      "titulo": publicacion!.titulo,
      "categoria": publicacion.categoria,
      "precio": publicacion.precio,
      "unidad": publicacion.unidad,
      "imagenprevia": "",
      "unidadPeso": publicacion.unidadPeso,
      "pesoNeto": publicacion.peso,
      "condicion": publicacion.condicionVenta,
      "detalleProducto": publicacion.detalles,
      "rut": publicacion.rut,
      "fechainicio": DateTime.fromMillisecondsSinceEpoch(
              Timestamp.now().toDate().millisecondsSinceEpoch,
              isUtc: true)
          .toString(),
      "fechamodificacion": DateTime.fromMillisecondsSinceEpoch(
              Timestamp.now().toDate().millisecondsSinceEpoch,
              isUtc: true)
          .toString(),
      "fechatermino": null,
      "eliminado": false
    });

    publicacion.id = documentoRef.id;

    return await Future.wait([
      guardarFoto(
          idUsuario: publicacion.rut as int,
          idDocument: documentoRef.id,
          listaFotos: publicacion.fotosMemoriaLocal as List<XFile?>)
    ]).then((guardado) async {
      if (guardado[0] == true) {
        await Future.wait([cargarUnaImagenPublicacion(publicacion)])
            .then((imagen) async {
          await FirebaseFirestore.instance
              .collection("publicacion")
              .doc(documentoRef.id)
              .update({"imagenprevia": imagen[0]});
        }).then((value) => print("Se actualiza la publicacion"));
        return true;
      }
      return false;
    });
  }

  /// Función a cargo de guardar la o las fotos de un producto
  Future<bool> guardarFoto(
      {required int idUsuario,
      required String idDocument,
      required List<XFile?> listaFotos}) async {
    print("--------------" + listaFotos.length.toString());
    int contador;
    for (contador = 0; contador < listaFotos.length; contador++) {
      XFile? foto = listaFotos[contador];
      Reference ref = FirebaseStorage.instance.ref().child(
          "users/$idUsuario/$idDocument/publicacion_" +
              DateTime.fromMillisecondsSinceEpoch(
                      Timestamp.now().toDate().millisecondsSinceEpoch,
                      isUtc: true)
                  .toString());
      File imagen = File(foto!.path);

      await ref.putFile(imagen);
      print(contador);
      await ref.getDownloadURL();
    }
    print("-------------------------contador:" + contador.toString());
    return contador == listaFotos.length ? true : false;
  }

  /// Carga una imagen de BD respecto al id de un documento
  Future<String> cargarUnaImagenPublicacion(
      PublicacionProductoVO publicacion) async {
    signInAnonymously();
    String pathImagen = "";
    String? idDocument = publicacion.id;
    int? idUsuario = publicacion.rut;
    try {
      ListResult result = await FirebaseStorage.instance
          .ref()
          .child("users/$idUsuario/$idDocument")
          .listAll();

      for (var i = 0; i < result.items.length; i++) {
        pathImagen = await FirebaseStorage.instance
            .ref()
            .child(result.items[i].fullPath)
            .getDownloadURL();
        print(pathImagen);
        break;
      }
    } on Exception catch (e) {
      print(e);
    }
    return pathImagen;
  }

  Future<FotosProductoVO> cargarFotosPublicacion(
      PublicacionProductoVO publicacion) async {
    signInAnonymously();
    FotosProductoVO fotosProductoVO = new FotosProductoVO();
    List<XFile?> rutasBD = [];

    String pathImagen = "";
    String? idDocument = publicacion.id;
    int? idUsuario = publicacion.rut;

    try {
      ListResult result = await FirebaseStorage.instance
          .ref()
          .child("users/$idUsuario/$idDocument")
          .listAll();

      for (var i = 0; i < result.items.length; i++) {
        pathImagen = await FirebaseStorage.instance
            .ref()
            .child(result.items[i].fullPath)
            .getDownloadURL();

        XFile archivoImagen = new XFile(pathImagen);

        rutasBD.add(archivoImagen);
      }
      fotosProductoVO.listaFotos = rutasBD;
    } on Exception catch (e) {
      print(e);
    }
    return fotosProductoVO;
  }

  /// Función para eliminar de forma lógica una imagen de la lista de imagenes
  FotosProductoVO eliminarImagenLista(
      {required FotosProductoVO fotosProducto, required int index}) {
    if (fotosProducto.listaFotos != null ||
        fotosProducto.listaFotos!.isNotEmpty) {
      if (existeEnCadena(fotosProducto.listaFotos![index]!.path, "https") >=
          0) {
        eliminarImagenBD(fotosProducto.listaFotos![index]!.path);
        fotosProducto.fotosEliminarBD
            .add(fotosProducto.listaFotos![index]!.path);
        fotosProducto.listaFotos!.removeAt(index);
      } else
        fotosProducto.listaFotos!.removeAt(index);
    }
    return fotosProducto;
  }

  /// Función que elimina una imagen almacenada en Base de datos en base a la ruta de la imagen
  Future<bool?> eliminarImagenBD(String rutaImagen) async {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference storageReference = firebaseStorage.refFromURL(rutaImagen);
    try {
      await storageReference.delete();
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  ///Elimina una publicación almacenada en base de datos

  Future<bool?> eliminarPublicacionBD(
      PublicacionProductoVO publicacion, String rutaImagen) async {
    var firebaseInstance = FirebaseFirestore.instance;
    await firebaseInstance
        .collection("publicacion")
        .doc(publicacion.id)
        .delete()
        .then((value) {
      eliminarImagenBD(rutaImagen).then((value) {
        print(value);
        if (value == true) {
          print("Publicación eliminada exitosamente");
          return true;
        } else
          return false;
      });
    }).catchError((error) {
      print("Error eliminar publicacion:     ");
      print(error);
      print("Hubo un problema al eliminar la publicación");
    });
  }

  /// Re-abre una publicación previamente cerrada para que sea visualizada en el mercado
  Future<bool?> reabrirPublicacionBD(PublicacionProductoVO publicacion) async {
    var firebaseInstance = FirebaseFirestore.instance;
    await firebaseInstance
        .collection("publicacion")
        .doc(publicacion.id)
        .update({"fechatermino": null, "eliminado": false});
  }

  /// Cierra una publicación. Esto hará que la publicación deje de ser visualizada
  Future<bool?> cerrarPublicacionBD(PublicacionProductoVO publicacion) async {
    DateTime todaysDate = DateTime.fromMillisecondsSinceEpoch(
        Timestamp.now().toDate().millisecondsSinceEpoch,
        isUtc: true);

    print(todaysDate);
    //DateTime yesterdayDate = DateTime.utc(todaysDate.year, todaysDate.month, todaysDate.day -1);
    var firebaseInstance = FirebaseFirestore.instance;
    await firebaseInstance
        .collection("publicacion")
        .doc(publicacion.id)
        .update({"fechatermino": todaysDate});
  }

  /// Eliminación lógica de una publicación. Solo actualiza un campo de la BD
  /// que hará que este deje de ser publico o editable por el usuario.
  /// Su visualización en la sección Mis publicaciones solo será informativa
  Future<bool?> eliminacionLogicaPublicacionBD(
      PublicacionProductoVO publicacion) async {
    var firebaseInstance = FirebaseFirestore.instance;
    await firebaseInstance
        .collection("publicacion")
        .doc(publicacion.id)
        .update({"eliminado": true});
  }

  ///Abre una sesión anónima
  Future<void> signInAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      print("Error en signInAnonymously: $e");
    }
  }

  ///Carga todas las publicación abiertas en el mercado
  Stream<QuerySnapshot<Map<String, dynamic>>> cargarPublicaciones() {
    /* DateTime todaysDate = DateTime.fromMillisecondsSinceEpoch(
        Timestamp.now().toDate().millisecondsSinceEpoch,
        isUtc: true);*/
    //DateTime yesterdayDate = DateTime.utc(todaysDate.year, todaysDate.month, todaysDate.day -1);
    return FirebaseFirestore.instance
        .collection("publicacion")
        .where("fechatermino", isNull: true)
        .where("eliminado", isEqualTo: false)
        .orderBy("fechainicio", descending: true)
        .snapshots();
  }

  /// Carga las publicaciones activas o abiertas de un usuario
  Stream<QuerySnapshot<Map<String, dynamic>>>
      cargarPublicacionesUsuarioAbiertas(int? idUsuario) {
    /* DateTime todaysDate = DateTime.fromMillisecondsSinceEpoch(
      Timestamp.now().toDate().millisecondsSinceEpoch,
      isUtc: true);

  print(todaysDate);*/
    //DateTime yesterdayDate = DateTime.utc(todaysDate.year, todaysDate.month, todaysDate.day -1);
    return FirebaseFirestore.instance
        .collection("publicacion")
        .where("rut", isEqualTo: idUsuario)
        .where("fechatermino", isNull: true)
        .where("eliminado", isEqualTo: false)
        .snapshots();
  }

  /// Carga las publicaciones cerradas  de un usuario
  Stream<QuerySnapshot<Map<String, dynamic>>>
      cargarPublicacionesUsuarioCerradas(int? idUsuario) {
    /* DateTime todaysDate = DateTime.fromMillisecondsSinceEpoch(
      Timestamp.now().toDate().millisecondsSinceEpoch,
      isUtc: true);

  print(todaysDate);*/
    //DateTime yesterdayDate = DateTime.utc(todaysDate.year, todaysDate.month, todaysDate.day -1);
    return FirebaseFirestore.instance
        .collection("publicacion")
        .where("rut", isEqualTo: idUsuario)
        .where("fechatermino", isNull: false)
        .snapshots();
  }

  /// Carga las publicaciones eliminadas de un usuario
  Stream<QuerySnapshot<Map<String, dynamic>>>
      cargarPublicacionesUsuarioEliminada(int? idUsuario) {
    /* DateTime todaysDate = DateTime.fromMillisecondsSinceEpoch(
      Timestamp.now().toDate().millisecondsSinceEpoch,
      isUtc: true);

  print(todaysDate);*/
    //DateTime yesterdayDate = DateTime.utc(todaysDate.year, todaysDate.month, todaysDate.day -1);
    return FirebaseFirestore.instance
        .collection("publicacion")
        .where("rut", isEqualTo: idUsuario)
        .where("eliminado", isEqualTo: true)
        .snapshots();
  }
}
