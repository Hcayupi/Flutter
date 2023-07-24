class ConstFormularios {
  static String get titulo => "Titulo";
  static String get categoria => "Categoría";
  static String get precio => "Precio";
  static String get pesoNeto => "Peso neto";
  static String get unidad => "Unidad";
  static String get condicionVenta => "Condición de venta";
  static String get previaReservacion => 'Previa reservación';
  static String get detalle => "Detalle";
  static String get ventaInmediata => "Venta inmediata";
  static List<String> get itemsCondicionVenta =>
      ['Seleccione', 'Previa reservación', 'Venta inmediata'];
  static List<String> get itemsUnidad => [
        'Seleccione',
        'Gramo',
        'Kilogramo',
        'Unidad',
        'Docena',
        'Saco',
        'Malla',
        'Caja',
        'Paquete'
      ];
  static List<String> get itemsUnidadPeso => [
        'Seleccione',
        'Gramo',
        'Kilogramo',
      ];
  static List<String> get itemsCategoria => <String>[
        'Seleccione',
        'Verduras',
        'Frutas',
        'Cereales',
        'Lacteos',
      ];
  static List<String> get itemsRegiones => [
        'Seleccione',
        'Arica y Parinacota',
        'Tarapacá',
        'Antofagasta',
        'Atacama',
        'Coquimbo',
        'Valparaíso',
        'Santiago',
        'Libertador Gral. Bernardo O’Higgins',
        'Maule',
        'Biobío',
        'Araucanía',
        'Los Ríos',
        'Los Lagos',
        'Aysén',
        'Magallanes y de la Antártica Chilena',
        'Ñuble',
      ];

  static Map<String, String> get abreviaturaUnidad => {
        'Seleccione': '',
        'Gramos': 'g',
        'Kilogramos': 'kg',
        'Unidad': 'u',
        'Docena': 'doc',
        'Sacos': 'sco',
        'Malla': 'malla',
        'Caja': 'caja',
        'Paquete': 'paq'
      };

  static List<String> get itemsBancos => [
        "Selecciona tu banco",
        "BANCO SANTANDER",
        "BANCO SANTANDER BANEFE",
        "BANCO ITAÚ",
        "BCI -TBANC",
        "BANCO FALABELLA",
        "CORBANCA DE CHILE / EDWARDS CITI",
        "BANCO ESTADO",
        "BANCO BICE",
        "BANCO SECURITY",
        "BANCO CONSORCIO",
        "BANCO RIPLEY",
        "BANCO INTERNACIONAL",
        "SCOTIABANCK",
        "COOPEUCH",
      ];
}
