import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class SwitchComponent extends StatefulWidget {

  final onChanged, initValue;
  SwitchComponent({this.onChanged, this.initValue});

  @override
  _SwitchComponentState createState() => _SwitchComponentState();
}

class _SwitchComponentState extends State<SwitchComponent> {

  var switchComponent;
  var value;

  @override
  void initState() {
    super.initState();
    value = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    if(Platform.isAndroid) {
      switchComponent = Switch(
        activeColor: Theme.of(context).colorScheme.primary,
        activeTrackColor: Theme.of(context).highlightColor,
        onChanged: (v) {
          setState(() {
            value = v;
          });
          widget.onChanged(value);
        },
        value: value,
      );
    } else if(Platform.isIOS) {
      switchComponent = Container(
        child: CupertinoSwitch(
          onChanged: (v) {
            setState(() {
              value = v;
            });
            widget.onChanged(value);
          },
          value: value,
        ),
      );
    }
    return switchComponent;
  }
}