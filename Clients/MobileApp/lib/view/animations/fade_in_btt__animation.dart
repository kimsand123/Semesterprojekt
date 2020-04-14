import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';
import 'package:simple_animations/simple_animations/multi_track_tween.dart';

class FadeInBTTAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeInBTTAnimation({this.delay, this.child});

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity")
          .add(Duration(milliseconds: 200), Tween(begin: 0.0, end: 1.0)),
      Track("translateY").add(
          Duration(milliseconds: 1000), Tween(begin: 80.0, end: 0.0),
          curve: Curves.elasticOut)
    ]);

    return ControlledAnimation(
      curve: Curves.easeOut,
      delay: Duration(milliseconds: (300 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
            opacity: animation["opacity"],
            child: Transform.translate(
                offset: Offset(0, animation['translateY']), child: child),
          ),
    );
  }
}