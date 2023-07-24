import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:proyectoflutterv1/constantes/Constantes.dart';

import 'Login.dart';
import 'ValidaRut.dart';

class Principal extends StatelessWidget {
  final Duration initialDelay = Duration(seconds: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: const Color(0xff659a1a),
        body: Stack(
      children: <Widget>[
        SafeArea(
            top: true,
            child: Container(
                alignment: Alignment.center,
                color: COLOR_FONDO_BODY,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      DelayedDisplay(
                          delay: Duration(seconds: initialDelay.inSeconds + 3),
                          child: Text("Ruralap",
                              style: TextStyle(
                                  fontFamily: FONTFAMILY_BIENVENIDA,
                                  color: COLOR_TEXTO_GENERAL_PAGINA,
                                  fontWeight: FontWeight.w600,
                                  fontSize: SIZE_TEXT_BIENVENIDA))),
                      DelayedDisplay(
                          delay: Duration(seconds: initialDelay.inSeconds + 3),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: COLOR_BUTTON_TIPO, //Color fondo
                                shadowColor: Colors.black,
                                // side: BorderSide(color: Colors.white, width: 2.0),
                                elevation: ELEVATION,
                                minimumSize:
                                    Size(SIZE_BUTTON_WIDTH, SIZE_BUTTON_HIGHT),
                                shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(RADIUS_BOTON),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                        duration:
                                            const Duration(milliseconds: 600),
                                        type: PageTransitionType.topToBottom,
                                        child: ValidaRut()));
                              },
                              child: Text("Crea una cuenta",
                                  style: TextStyle(
                                    fontFamily: FONTFAMILY_TEXTO_BUTTON,
                                    color: COLOR_TEXTO_GENERAL_PAGINA,
                                    fontSize: SIZE_LABEL_BUTTON,
                                    fontWeight: FontWeight.w400,
                                  ))),
                          slidingBeginOffset: const Offset(0.35, 0.0)),
                      /*  Text("Ya tengo una cuenta",
                      style:
                          TextStyle(color: _colorYaTengoCuenta, fontSize: 20.0)),*/
                      DelayedDisplay(
                          delay: Duration(seconds: initialDelay.inSeconds + 3),
                          child: GestureDetector(
                              child: Text("Ya tengo una cuenta",
                                  style: TextStyle(
                                    fontFamily: FONTFAMILY_TEXTO_BUTTON,
                                    color: Color(0xffFFFFFF), //Color de Texto
                                    fontSize: SIZE_LABEL_BUTTON_LARGE,
                                    fontWeight: FontWeight.w400,
                                  )),
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                        duration:
                                            const Duration(milliseconds: 600),
                                        type: PageTransitionType.bottomToTop,
                                        child: Login()));
                              }),
                          slidingBeginOffset: const Offset(-0.35, 0.0))
                    ])))
      ],
    ));
  }
}
