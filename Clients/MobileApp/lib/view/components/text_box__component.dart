import 'package:flutter/material.dart';
import 'dart:core';

class TextBoxComponent extends StatelessWidget {
  final text;
  TextBoxComponent({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 15, 20, 8),
      width: MediaQuery.of(context).size.width - 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Color(0x90FFFFFF),
      ),
      child: RichText(
        text: TextSpan(
          children: text,
        ),
      ),
    );
  }
}
