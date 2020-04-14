import 'package:flutter/material.dart';

class IncrementDecrementButtonComponent extends StatefulWidget {
  final bool isIncerement;
  final onPressed, onLongPressed, onLongPressEnd;
  IncrementDecrementButtonComponent({this.isIncerement, this.onPressed, this.onLongPressed, this.onLongPressEnd});

  @override
  _IncrementDecrementButtonComponentState createState() => _IncrementDecrementButtonComponentState();
}

class _IncrementDecrementButtonComponentState extends State<IncrementDecrementButtonComponent> with SingleTickerProviderStateMixin{
  
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


    var buttonSymbol;
    if (widget.isIncerement) {
      buttonSymbol = '+';
    } else {
      buttonSymbol = '-';
    }

    return GestureDetector(
      onTap: () {
        _animationController.forward().then((f) {
          _animationController.reverse();
          widget.onPressed();
        });
      },
      onLongPress: () {
        widget.onLongPressed();
      },
      onLongPressEnd: (details) {
        widget.onLongPressEnd();
      },
      child: Transform.scale(
        scale: scale,
        child: Container(
          width: 25,
          height: 25,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Theme.of(context).highlightColor)),
          child: Text('$buttonSymbol',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .body2
                  .copyWith(color: Theme.of(context).highlightColor, fontSize: 18)),
        ),
      ),
    );
  }
}
