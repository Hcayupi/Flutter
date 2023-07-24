import 'package:flutter/material.dart';
import 'package:proyectoflutterv1/constantes/Constantes.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proyectoflutterv1/models/VO/FotosProductoVO.dart';
import 'package:proyectoflutterv1/models/VO/PublicacionProductoVO.dart';
import 'package:proyectoflutterv1/models/VO/UsuarioVO.dart';
import 'package:proyectoflutterv1/views/ModuloTienda/AgroMercado.dart';
import 'package:proyectoflutterv1/views/Publicacion/NuevaPublicacion/FotoProducto.dart';

class PublicacionExitosa extends StatefulWidget {
  final UsuarioVO usuario;
  PublicacionExitosa(this.usuario, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      MensajePublicacionExitosa(this.usuario);
}

class MensajePublicacionExitosa extends State<PublicacionExitosa> {
  UsuarioVO _usuario;

  MensajePublicacionExitosa(this._usuario);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: COLOR_FONDO_BODY,
        body: Stack(children: <Widget>[
          SafeArea(
              child: Column(
            children: [
              Spacer(),
              //Image.asset(IMAGEN_TIPO_SUCCESS, height: 200),
              Text("¡Publicación creada exitosamente!",
                  style: TextStyle(
                      color: COLOR_TEXTO_GENERAL_PAGINA,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 50),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            primary: Color(0xffffb03f),
                            fixedSize: Size(150, 45)),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  ctx: context,
                                  type: PageTransitionType.leftToRight,
                                  child: AgroMercado(usuario: this._usuario)));
                        },
                        child: Text("Ir al mercado",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                fontFamily: FONTFAMILY_TEXTO_BUTTON))),
                    SizedBox(
                      width: 7,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            primary: Colors.green.shade500, //Color(0xffffb03f),
                            fixedSize: Size(150, 45)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  ctx: context,
                                  type: PageTransitionType.leftToRight,
                                  child: FotoProducto(
                                      fotosProducto: new FotosProductoVO(),
                                      usuario: this._usuario,
                                      publicacion:
                                          PublicacionProductoVO.instancia)));
                        },
                        child: Text("Nueva publicación",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                fontFamily: FONTFAMILY_TEXTO_BUTTON))),
                  ]),
              Spacer()
            ],
          ))
        ]));
  }
}
