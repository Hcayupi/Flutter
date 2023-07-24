import 'package:flutter/material.dart';
import 'package:proyectoflutterv1/constantes/Constantes.dart';

class BottomAppBarView extends StatelessWidget {
  final Function onTapCallBack;
  final Function onTapCallForward;
  final String labelBack;
  final String labelForward;

  BottomAppBarView(
      {required this.labelBack,
      required this.onTapCallBack,
      required this.labelForward,
      required this.onTapCallForward});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        color: COLOR_FONDO_APPBAR,
        child: SizedBox(
          height: SIZENAVBAR,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: SIZEBOX_WIDTH + 10),
              GestureDetector(
                  child: RichText(
                    textDirection: TextDirection.rtl,
                    text: new TextSpan(
                      text: this.labelBack,
                      style: TextStyle(fontSize: SIZE_TEXT_NAVBAR),
                      children: [
                        WidgetSpan(
                            child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          textDirection: TextDirection.ltr,
                        )),
                      ],
                    ),
                  ),
                  onTap: () => this.onTapCallBack()),
              Spacer(),
              SizedBox(height: 30),
              Spacer(),
              GestureDetector(
                  child: RichText(
                    text: new TextSpan(
                      text: this.labelForward,
                      style: TextStyle(fontSize: SIZE_TEXT_NAVBAR),
                      children: [
                        WidgetSpan(
                            child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          textDirection: TextDirection.ltr,
                        )),
                      ],
                    ),
                  ),
                  onTap: () => this.onTapCallForward()),
              SizedBox(width: SIZEBOX_WIDTH),
            ],
          ),
        ));
  }
}
