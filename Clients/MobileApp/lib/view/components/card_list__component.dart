import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardList extends StatelessWidget {
  final Widget _child;
  final double _cardHeight;

  CardList({
    @required Widget child,
    @required double cardHeight,
  })  : this._cardHeight = cardHeight,
        this._child = child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      borderOnForeground: true,
      clipBehavior: Clip.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(20),
      ),
      child: Container(
          height: _cardHeight, padding: EdgeInsets.all(10), child: _child),
    );
  }
}
