import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';
import 'package:simple_animations/simple_animations/multi_track_tween.dart';

import 'increment_decrement_button__component.dart';

class CustomPickerComponent extends StatefulWidget {
  final String title, subtitle;
  final Map<String, double> valueList;
  final onValueChanged;

  CustomPickerComponent(
      {this.title, this.subtitle, this.onValueChanged, this.valueList});

  @override
  _CustomPickerComponentState createState() => _CustomPickerComponentState();
}

class _CustomPickerComponentState extends State<CustomPickerComponent> {
  var questionDurationValue;
  var _opacity;
  var seconds;
  bool _shouldPlayAnimation;

  Timer timer;

  final tween = MultiTrackTween([
    Track("opacity")
        .add(Duration(milliseconds: 200), Tween(begin: 0.0, end: 1.0)),
    Track("translateY").add(
        Duration(milliseconds: 500), Tween(begin: 50.0, end: 0.0),
        curve: Curves.easeOutExpo)
  ]);

  @override
  void initState() {
    super.initState();
    questionDurationValue = '1';
    _opacity = 0.0;
    seconds = 120;
    _shouldPlayAnimation = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 20.0, left: 20.0, bottom: 20.0),
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.headline,
          ),
        ),
        CupertinoSegmentedControl(
          borderColor: Theme.of(context).highlightColor,
          pressedColor: Theme.of(context).highlightColor,
          selectedColor: Theme.of(context).highlightColor,
          groupValue: questionDurationValue,
          onValueChanged: (v) {
            setState(() {
              questionDurationValue = v;

              if (questionDurationValue == '0') {
                double secondsPicked = 15.0;
                _shouldPlayAnimation = false;
                _opacity = 0.0;
                widget.onValueChanged(secondsPicked);
              } else if (questionDurationValue == '1') {
                double secondsPicked = 30.0;
                _shouldPlayAnimation = false;
                _opacity = 0.0;
                widget.onValueChanged(secondsPicked);
              } else if (questionDurationValue == '2') {
                double secondsPicked = 60.0;
                _shouldPlayAnimation = false;
                _opacity = 0.0;
                widget.onValueChanged(secondsPicked);
              } else {
                _opacity = 1.0;
                _shouldPlayAnimation = true;
                widget.onValueChanged(seconds);
              }
            });
          },
          children: {
            '0': Center(
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: 35,
                  alignment: Alignment.center,
                  child: Text(widget.valueList.keys.first)),
            ),
            '1': Center(
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: 35,
                  alignment: Alignment.center,
                  child: Text(widget.valueList.keys.toList()[1])),
            ),
            '2': Center(
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: 35,
                  alignment: Alignment.center,
                  child: Text(widget.valueList.keys.last)),
            ),
            '3': Center(
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: 35,
                  alignment: Alignment.center,
                  child: Text('Custom')),
            )
          },
        ),
        AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(milliseconds: 250),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 20.0, left: 20.0, bottom: 8.0),
            child: Text(widget.subtitle,
                style: Theme.of(context)
                    .textTheme
                    .subhead
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary)),
          ),
        ),
        ControlledAnimation(
          playback: _shouldPlayAnimation
              ? Playback.PLAY_FORWARD
              : Playback.PLAY_REVERSE,
          tween: tween,
          duration: tween.duration,
          builder: (context, animation) {
            return Opacity(
              opacity: animation["opacity"],
              child: Transform.translate(
                offset: Offset(0, animation["translateY"]),
                child: Container(
                  height: 45.0,
                  width: MediaQuery.of(context).size.width - 35,
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    color: Color(0xCCFFFFFF),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Text('${seconds}s',
                              style: Theme.of(context).textTheme.body2.copyWith(
                                  color: Theme.of(context).highlightColor)),
                        ),
                      ),
                      IncrementDecrementButtonComponent(
                        isIncerement: false,
                        onLongPressed: () {
                          timer =
                              Timer.periodic(Duration(milliseconds: 250), (t) {
                            setState(() {
                              widget.onValueChanged(seconds);
                              if (seconds != 0) {
                                seconds -= 5;
                                widget.onValueChanged(seconds);
                              }
                            });
                          });
                        },
                        onLongPressEnd: () {
                          timer.cancel();
                        },
                        onPressed: () {
                          setState(() {
                            if (seconds != 0) {
                              seconds -= 5;
                              widget.onValueChanged(seconds);
                            }
                          });
                        },
                      ),
                      SizedBox(width: 20.0),
                      IncrementDecrementButtonComponent(
                        isIncerement: true,
                        onLongPressed: () {
                          timer =
                              Timer.periodic(Duration(milliseconds: 250), (t) {
                            setState(() {
                              if (seconds != 180) {
                                seconds += 5;
                                widget.onValueChanged(seconds);
                              }
                            });
                          });
                        },
                        onLongPressEnd: () {
                          timer.cancel();
                        },
                        onPressed: () {
                          setState(() {
                            if (seconds != 180) {
                              seconds += 5;
                              widget.onValueChanged(seconds);
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
