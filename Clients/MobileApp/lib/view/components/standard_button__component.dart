import 'package:flutter/material.dart';

class StandardButtonComponent extends StatefulWidget {

  final width, _height, text, onPressed, _color, _borderColor, _shouldAnimate;
  StandardButtonComponent({this.width, this.text, this.onPressed, height, color, borderColor, shouldAnimate})
   : this._height = height ?? 45.0,
     this._color = color ?? Color(0xFF009138),
     this._borderColor = borderColor ?? Color(0xFF005631),
     this._shouldAnimate = shouldAnimate ?? true;

  @override
  _StandardButtonComponentState createState() => _StandardButtonComponentState();
}

class _StandardButtonComponentState extends State<StandardButtonComponent> with SingleTickerProviderStateMixin {

  AnimationController _animationController;
  double scale;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.03
    )..addListener(() {
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    scale = 1 - _animationController.value;
    Widget button;

    if(widget._shouldAnimate) {
      button = Transform.scale(
        scale: scale,
        child: Container(
          alignment: Alignment.center,
          width: widget.width,
          height: widget._height,
          child: Text('${widget.text}', style: Theme.of(context).textTheme.button),
          decoration: BoxDecoration(
            color: widget._color,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: widget._borderColor, width: 1, style: BorderStyle.solid)
            ),
          ),
      );
    } else {
      button = Container(
          alignment: Alignment.center,
          width: widget.width,
          height: widget._height,
          child: Text('${widget.text}', style: Theme.of(context).textTheme.button),
          decoration: BoxDecoration(
            color: widget._color,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: widget._borderColor, width: 1, style: BorderStyle.solid)
            ),
          );
    }

    return GestureDetector(
      onTap: () {
        _animationController.forward().then((f) {
          _animationController.reverse();
          widget.onPressed();
        });
      },
      onTapCancel: () {
        _animationController.reverse();
      },
      child: button
    );
  }
}