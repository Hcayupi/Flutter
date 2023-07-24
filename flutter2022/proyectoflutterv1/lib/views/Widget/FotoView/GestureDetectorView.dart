import 'package:flutter/material.dart';

class GestureDetectorView extends StatelessWidget {
  final Function onTapCall;
  final String label;
  final double fontSize;
  final TextDirection direction;
  final bool left;

  GestureDetectorView({
    required this.onTapCall,
    required this.fontSize,
    required this.label,
    required this.direction,
    required this.left,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: left
          ? RichText(
              textDirection: TextDirection.rtl,
              text: new TextSpan(
                text: this.label,
                style: TextStyle(fontSize: this.fontSize),
                children: [
                  WidgetSpan(
                      child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    textDirection: direction,
                  )),
                ],
              ),
            )
          : RichText(
              //textDirection: TextDirection.rtl,
              text: new TextSpan(
                text: this.label,
                style: TextStyle(fontSize: this.fontSize),
                children: [
                  WidgetSpan(
                      child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    textDirection: direction,
                  )),
                ],
              ),
            ),
      onTap: () => onTapCall(),
    );
  }
}
