class Maquina {
  final int? id;
  final String nombre;
  final String modelo;
  final String unidad;
  final String descripcion;
  final int agno;
  final int lecturaPanel;

  const Maquina({
    this.id,
    required this.nombre,
    required this.modelo,
    required this.unidad,
    required this.descripcion,
    required this.agno,
    required this.lecturaPanel,
  });

  factory Maquina.fromJson(Map<String, dynamic> json) {
    return Maquina(
        id: int.tryParse(json["id"].toString()),
        nombre: json["nombre"],
        modelo: json["modelo"],
        unidad: json["unidad"],
        descripcion: json["descripcion"],
        agno: int.tryParse(json["agno"].toString()) as int,
        lecturaPanel: int.tryParse(json["lecturaPanel"].toString()) as int);
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'modelo': modelo,
      'agno': agno,
      'descripcion': descripcion,
      'lecturaPanel': lecturaPanel,
      'unidad': unidad
    };
  }

  @override
  String toString() {
    return 'Maquina{ id: $id,nombre: $nombre, modelo: $modelo,agno: $agno, descripcion: $descripcion, lecturaPanel: $lecturaPanel, unidad: $unidad }';
  }
}
