import 'package:flutter/material.dart';

class ConstImagenes {
  static const String loading = "assets/loading.gif";
  static const String nature =
      "https://staticuestudio.blob.core.windows.net/buhomag/2016/03/01195417/pexels-com.jpg";
  static const String maquina = "assets/tractor_001.jpeg";
  static Image fotoGenerica = Image.asset(ConstImagenes.maquina,
      scale: 5, fit: BoxFit.fill, width: 180, height: 150);
}
