import 'dart:math';

import 'package:intl/intl.dart';
import 'package:basic_utils/basic_utils.dart';

String capitalizarCadena(String cadena) {
  return StringUtils.capitalize(cadena);
}

String formatearFecha(DateTime? fecha) {
  var formatoFecha = new DateFormat('yyyy-MM-dd HH:mm');
  var inputDate = formatoFecha.parse(fecha.toString());
  var outputFormat = DateFormat('dd/MM/yyyy');
  return outputFormat.format(inputDate);
}

String obtenerFechaEquipo() {
  DateTime ahora = DateTime.now();
  String formatoFecha = DateFormat('dd/MM/yyyy').format(ahora);
  return formatoFecha;
}

String generarNumerosAleatorios(int cantidadDigitos, int rangoMax) {
  String numeros = "";
  var random = Random();
  for (var i = 0; i < cantidadDigitos; i++) {
    numeros = numeros + random.nextInt(rangoMax).toString();
  }
  return numeros;
}

String obtenerHoraEquipo() {
  DateTime ahora = DateTime.now().toLocal();
  String formatoFecha = DateFormat('HH:mm').format(ahora);
  return formatoFecha;
}

//Reemplaza algunos número por X 9 45625 526
String ocultaNumerosCel(String cadena) {
  return cadena = cadena.substring(0, 1) +
      " XXXXX " +
      cadena.substring(cadena.length - 3, cadena.length);
}

String quitarEspaciosExtremos(String cadena) {
  return cadena.trim();
}

String formatearCifra(String ingreso) {
  int cuentaUnidades = 0;
  String nuevaCadena = "";
  if (ingreso.length > 3) {
    for (int i = ingreso.length - 1; i >= 0; i--) {
      nuevaCadena = ingreso[i] + nuevaCadena;
      cuentaUnidades += 1;
      if (cuentaUnidades == 3 && i != 0) {
        cuentaUnidades = 0;
        nuevaCadena = '.' + nuevaCadena;
      }
    }
  } else {
    nuevaCadena = ingreso;
  }

  return nuevaCadena;
}

String getDigitoVerificador(String rut) {
  return rut.substring(rut.length - 1, rut.length);
}

int? extraerIdUsuario(String rut) {
  String rutUsuario = limpiarRut(rut);
  rutUsuario = rutUsuario.substring(0, rutUsuario.length - 1);
  return int.tryParse(rutUsuario);
}

String limpiarRut(String? ingreso) {
  String nuevaCadena = "";
  if (ingreso != null && ingreso.isNotEmpty) {
    for (int i = 0; i < ingreso.length; i++) {
      if (ingreso[i] == "k") {
        nuevaCadena += ingreso[i];
      } else if (ingreso[i] == "K") {
        nuevaCadena += ingreso[i];
      } else if (int.tryParse(ingreso[i]) != null) {
        nuevaCadena += ingreso[i];
      }
    }
  }
  return nuevaCadena;
}

String formatearRut(String ingreso) {
  int cuentaUnidades = 0;
  String nuevaCadena = "";

  if (ingreso.length > 2) {
    nuevaCadena = '-' + ingreso[ingreso.length - 1];
    for (int i = ingreso.length - 2; i >= 0; i--) {
      nuevaCadena = ingreso[i] + nuevaCadena;
      cuentaUnidades += 1;
      if (cuentaUnidades == 3 && i != 0) {
        cuentaUnidades = 0;
        nuevaCadena = '.' + nuevaCadena;
      }
    }
  } else {
    nuevaCadena = ingreso;
  }
  return nuevaCadena;
}
