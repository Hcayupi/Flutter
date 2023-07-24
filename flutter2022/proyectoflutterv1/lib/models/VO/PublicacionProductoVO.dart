import 'FotosProductoVO.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class PublicacionProductoVO {
  int? rut;
  String titulo;
  String categoria;
  int precio;
  String unidad;
  int peso;
  String unidadPeso;
  String condicionVenta;
  String detalles;
  String? imagenprevia;
  bool? eliminado;
  DateTime? fechaInicio;
  DateTime? fechaModificacion;
  DateTime? fechaTermino;
  FotosProductoVO? fotosProducto;
  String? id;

  PublicacionProductoVO(
      {required this.rut,
      required this.titulo,
      required this.categoria,
      required this.precio,
      required this.unidad,
      required this.unidadPeso,
      required this.peso,
      required this.condicionVenta,
      required this.detalles,
      this.fechaInicio,
      this.fechaModificacion,
      this.imagenprevia,
      this.fotosProducto,
      this.id});

  factory PublicacionProductoVO.fromDocument(DocumentSnapshot documento) {
    var formatoFecha = new DateFormat('yyyy-MM-dd');

    return PublicacionProductoVO(
        rut: documento.get('rut'),
        imagenprevia: documento.get('imagenprevia'),
        titulo: documento.get('titulo'),
        categoria: documento.get('categoria'),
        precio: documento.get('precio'),
        unidad: documento.get('unidad'),
        unidadPeso: documento.get('unidadPeso'),
        peso: documento.get('pesoNeto'),
        condicionVenta: documento.get('condicion'),
        detalles: documento.get('detalleProducto'),
        fechaInicio: formatoFecha.parse(documento.get('fechainicio')),
        fechaModificacion:
            formatoFecha.parse(documento.get('fechamodificacion')),
        id: documento.id);
  }

  List<XFile?>? get fotosMemoriaLocal {
    return this.fotosProducto!.listaFotos;
  }

  List<String> get listaFotosEliminarBD {
    return this.fotosProducto!.fotosEliminarBD;
  }

  set setRutaImagen(ruta) {
    this.imagenprevia = ruta;
  }

  static PublicacionProductoVO get instancia {
    return PublicacionProductoVO(
        rut: 0,
        titulo: "",
        categoria: "",
        precio: 0,
        unidad: "",
        peso: 0,
        unidadPeso: "",
        condicionVenta: "",
        detalles: "");
  }
}
