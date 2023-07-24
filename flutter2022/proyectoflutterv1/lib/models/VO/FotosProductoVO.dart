import 'package:image_picker/image_picker.dart';

class FotosProductoVO {
  XFile? foto;
  List<XFile?>? listaFotos = [];
  List<String> fotosEliminarBD = [];

  FotosProductoVO({this.foto, this.listaFotos});

  void listafotosBDeliminar(int index) {
    fotosEliminarBD.removeAt(index);
  }
}
