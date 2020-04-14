import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardListAddButtonComponent extends StatelessWidget {
  final bool _selected;

  CardListAddButtonComponent({@required bool selected})
      : this._selected = selected;

  @override
  Widget build(BuildContext context) {
    Color buttonColor =
        _selected ? Colors.red[800] : Theme.of(context).colorScheme.primary;

    return Container(
      height: 15.0,
      width: 15.0,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Icon(
        _selected ? Icons.remove : Icons.add,
        size: 15,
        color: Colors.white,
      ),
    );
  }
}
