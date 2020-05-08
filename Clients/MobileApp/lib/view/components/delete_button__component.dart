import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DeleteButtonComponent extends StatelessWidget {
  final VoidCallback onDeleteAction;
  final buttonText;

  DeleteButtonComponent({this.onDeleteAction, this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RawMaterialButton(
        fillColor: Colors.red[600],
        highlightColor: Colors.red[800],
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.red)),
        onPressed: onDeleteAction,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Text(
            this.buttonText,
            style: Theme.of(context)
                .textTheme
                .button
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
