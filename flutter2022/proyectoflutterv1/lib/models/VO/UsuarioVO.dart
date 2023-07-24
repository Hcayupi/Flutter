import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class UsuarioVO {
  late String? id;
  late bool confirmado;
  late int? rut;
  late String digitoV;
  late String nombres;
  late String apellidoP;
  late String apellidoM;
  late String region;
  late String ciudad;
  late String comuna;
  late String direccion;
  late String email;
  late String? rubro;
  late int? numeroCel;
  late int? edad;
  late DateTime? fechaNac;
  late XFile? fotoPerfil;
  late String? password;

  static final UsuarioVO _instance = UsuarioVO._privateConstructor();

  UsuarioVO._privateConstructor();

  static UsuarioVO get instance {
    return _instance;
  }

  UsuarioVO(
      {required this.rut,
      required this.digitoV,
      required this.nombres,
      required this.apellidoP,
      required this.apellidoM,
      required this.region,
      required this.ciudad,
      required this.comuna,
      required this.direccion,
      required this.email,
      required this.rubro,
      required this.numeroCel,
      required this.edad,
      this.fechaNac,
      this.fotoPerfil,
      this.id,
      this.confirmado = false,
      this.password});

  factory UsuarioVO.fromDocument(DocumentSnapshot documento) {
    return UsuarioVO(
        rut: documento.get('rut'),
        digitoV: documento.get('digitoV'),
        nombres: documento.get('nombres'),
        apellidoP: documento.get('apellidoP'),
        apellidoM: documento.get('apellidoM'),
        region: documento.get('region'),
        ciudad: documento.get('ciudad'),
        comuna: documento.get('comuna'),
        direccion: documento.get('direccion'),
        rubro: documento.get('rubro'),
        email: documento.get('email'),
        numeroCel: documento.get('peso_neto'),
        edad: documento.get('condicion'),
        fechaNac: documento.get('detalleProducto'),
        id: documento.id,
        confirmado: documento.get('confirmado'),
        password: documento.get('password'));
  }

  factory UsuarioVO.fromMap(Map<String, dynamic> usuarioMap) {
    return UsuarioVO(
        rut: usuarioMap['rut'],
        digitoV: usuarioMap['digitoV'],
        nombres: usuarioMap['nombres'],
        apellidoP: usuarioMap['apellidoP'],
        apellidoM: usuarioMap['apellidoM'],
        region: usuarioMap['region'],
        ciudad: usuarioMap['ciudad'],
        comuna: usuarioMap['comuna'],
        direccion: usuarioMap['direccion'],
        rubro: usuarioMap['rubro'],
        email: usuarioMap['email'],
        numeroCel: usuarioMap['peso_neto'],
        edad: usuarioMap['condicion'],
        fechaNac: usuarioMap['detalleProducto'],
        confirmado: usuarioMap['confirmado'],
        password: usuarioMap['password']);
  }
}
