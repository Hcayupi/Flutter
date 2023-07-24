import 'package:flutter/material.dart';
import 'package:rolling_switch/rolling_switch.dart';

class RollingSwitchWidget extends StatefulWidget {
  final Function(bool) onChanged;
  final String labelText;

  const RollingSwitchWidget(
      {Key? key, required this.onChanged, required this.labelText})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => RollingSwitchWidgetState();
}

class RollingSwitchWidgetState extends State<RollingSwitchWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Text(widget.labelText),
      RollingSwitch.widget(
        onChanged: (bool state) {
          widget.onChanged(state);
        },
        rollingInfoRight: const RollingWidgetInfo(
          backgroundColor: Colors.green,
          icon: Icon(Icons.done, color: Colors.green),
          text: Text(
            'Hecho',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        rollingInfoLeft: const RollingWidgetInfo(
          icon: Icon(Icons.remove_circle_outline, color: Colors.red),
          backgroundColor: Colors.red,
          text: Text(
            'No',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      )
    ]);
  }
}
