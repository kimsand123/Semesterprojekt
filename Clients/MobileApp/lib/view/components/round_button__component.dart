import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class RoundButtonComponent extends StatefulWidget {
  final icon, text, onPressed, animationState, padding, isPaused;
  RoundButtonComponent(
      {this.icon,
      this.text,
      this.onPressed,
      this.animationState,
      this.padding,
      this.isPaused});

  @override
  _RoundButtonComponentState createState() => _RoundButtonComponentState();
}

class _RoundButtonComponentState extends State<RoundButtonComponent>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  double scale;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 100),
        lowerBound: 0.0,
        upperBound: 0.03)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    scale = 1 - _animationController.value;

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
      child: Column(
        children: <Widget>[
          Transform.scale(
            scale: scale,
            child: Container(
              padding: widget.padding,
              width: MediaQuery.of(context).size.width * 0.12,
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Theme.of(context).highlightColor),
                shape: BoxShape.circle,
              ),
              child: FlareActor(
                widget.icon,
                alignment: Alignment.center,
                animation: widget.animationState,
                isPaused: widget.isPaused,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(widget.text, style: Theme.of(context).textTheme.body2)
        ],
      ),
    );
  }
}
