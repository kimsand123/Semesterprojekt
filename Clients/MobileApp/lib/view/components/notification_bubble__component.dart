import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NotificationBubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red,
      ),
      alignment: Alignment.center,
      height: 15,
      width: 15,
    );
  }
}
