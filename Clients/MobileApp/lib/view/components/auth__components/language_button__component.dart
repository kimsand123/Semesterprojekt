import 'package:flutter/material.dart';

class LanguageButtonComponent extends StatefulWidget {

  final language;
  final Function onPressed;
  LanguageButtonComponent({@required this.language, @required this.onPressed});

  @override
  _LanguageButtonComponentState createState() => _LanguageButtonComponentState();
}

class _LanguageButtonComponentState extends State<LanguageButtonComponent> {
  var _left, _colorDA, _colorEN;

  @override
  void initState() {
    super.initState();
    if(widget.language == 'da') {
      _colorDA = Colors.white;
      _colorEN = Colors.black;
      _left = 0.0;
    } else {
      _colorDA = Colors.black;
      _colorEN = Colors.white;
      _left = 50.0;
    }
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            alignment: Alignment.centerRight,
            width: 100,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 100),
            left: _left,
            child: Container(
              alignment: Alignment.center,
              width: 50,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 15.0),
            child: Text('DA',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: _colorDA
              )
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 7.0, bottom: 7.0, left: 65.0),
            child: Text('EN',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: _colorEN
              )
            ),
          ),
      ]),
    );
  }

  onTap() {
    widget.onPressed();
    setState(() {
      _left = _left == 0.0 ? 50.0 : 0.0;
      _colorDA = _colorDA == Colors.white ? Colors.black : Colors.white;
      _colorEN = _colorEN == Colors.black ? Colors.white : Colors.black;
    });
  }
}