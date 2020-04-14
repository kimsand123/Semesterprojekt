import 'package:flutter/material.dart';

class BorderlessButtonComponent extends StatelessWidget {
  final onPressed, text, margin, padding;
  BorderlessButtonComponent(
      {this.onPressed, this.text, this.margin, this.padding});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          margin: margin,
          color: Colors.transparent,
          padding: this.padding ?? EdgeInsets.all(8.0),
          child: text),
    );
  }
}
