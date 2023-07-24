import 'package:flutter/material.dart';
import 'package:proyectoflutterv1/constantes/Constantes.dart';
import 'package:proyectoflutterv1/constantes/ConstFormularios.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

bool validaRut(String cadenaRut) {
  var digitoVerificador = "";
  var factores = [2, 3, 4, 5, 6, 7];
  int contadorFactores = 0;
  int operacion = 0;
  int suma = 0;

  var digitoAux = "";
  if (cadenaRut.length > 2) {
    digitoVerificador = cadenaRut[cadenaRut.length - 1];
    if (digitoVerificador == "k" ||
        digitoVerificador == "K" ||
        int.tryParse(digitoVerificador) != null) {
      for (int i = cadenaRut.length - 2; i >= 0; i--) {
        if (int.tryParse(cadenaRut[i]) != null) {
          suma += int.tryParse(cadenaRut[i])! * factores[contadorFactores];
          if (contadorFactores != 5) {
            contadorFactores++;
          } else
            contadorFactores = 0;
        } else
          return false;
      }
      operacion = suma % 11;
      operacion = 11 - operacion;
      if (operacion == 11) {
        digitoAux = "0";
      } else if (operacion == 10) {
        digitoAux = "k";
      } else
        digitoAux = operacion.toString();

      if (digitoAux.toLowerCase() != digitoVerificador.toLowerCase()) {
        return false;
      }
    } else
      return false;
  } else
    return false;

  return true;
}

bool validadorFormulario(GlobalKey<FormState> formulario) {
  if (formulario.currentState!.validate()) {
    return true;
  }
  return false;
}

cuadroAlertaValidacion(String mensaje, String txtButton, BuildContext context) {
  Alert(
    context: context,
    type: AlertType.none,
    desc: mensaje,
    style: AlertStyle(
        animationType: AnimationType.grow,
        animationDuration: Duration(milliseconds: 300)),
    buttons: [
      DialogButton(
        child: Text(
          txtButton,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => {Navigator.pop(context)},
        width: 110,
        color: Color.fromRGBO(0, 179, 134, 1.0),
      )
    ],
  ).show();
}

int caracteresMaximos(String label) {
  if (label == ConstFormularios.precio) {
    return 7;
  } else if (label == ConstFormularios.pesoNeto) {
    return 4;
  }
  return 50;
}

String? validarIngresoFormulario(String? value, String label) {
  if (value != null && value == TXTDEFAULT_DROPDOWN) {
    return "Seleccione " + label.toString();
  } else if (value != null && value.isEmpty) {
    return "Ingrese " + label.toString();
  } else
    return null;
}

///Devuelvue la posición en la que se encuentra la coincidencia
///Si no encuantra una coincidencia dentro de la cadena devolverá -1
int existeEnCadena(String cadena, String patronABuscar) {
  return cadena.indexOf(patronABuscar);
}

//Valida que el numero de teléfono es numèrico
bool validaNumeroTelefono(String cadena) {
  String cadenaAuxiliar = cadena.substring(1);
  print(cadenaAuxiliar);
  if (esNumero(cadenaAuxiliar)) return true;
  return false;
}

//Valida que la cedena es numérica
bool esNumero(String cadena) {
  if (int.tryParse(cadena) != null) return true;
  return false;
}

// Si no es un numero de telefono válido, devolverá falso
bool numeroTelefonoValido(String cadena) {
  if (cadena.isEmpty)
    return false;
  else if (existeEnCadena(cadena.trim(), "+56") == -1)
    return false;
  else if (cadena.trim().length < 12) return false;

  return true;
}

//Valida el campo Codigo validacion
bool campoNumericoValido(String cadena) {
  if (cadena.isEmpty) return false;
  if (!esNumero(cadena)) return false;
  if (cadena.trim().length > 6) return false;
  return true;
}
