import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:golfquiz/localization/appLocalizations.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class GameDurationTimer extends StatelessWidget {
  final double _totalSeconds, _secondsLeft;
  final String _type;
  final Timer _timer;

  /// When using the GameDurationTimer, you will need to use a timer.
  /// Open this class to see an example on this.
  /*

    Timer _timer;
    double _totalTime;

    @override
    void initState() {
          super.initState();
           _totalTime = 10;

           _timer = Timer.periodic(Duration(seconds: 1), (timer) {
               if (timer.tick == _totalTime) {
               timer.cancel();
             }
             setState(() {
              timer = timer;
             });

           });
    }

    @override
    Widget build(BuildContext context) {
        return GameDurationTimer(
          totalSeconds: _totalTime,
          timer: _timer,
        ),
    }
  */
  GameDurationTimer(
      {@required double totalSeconds,
      double secondsLeft,
      String type,
      @required Timer timer})
      : this._totalSeconds = totalSeconds ?? 0.0,
        this._secondsLeft = secondsLeft ?? null,
        this._type = type ?? 'Sec',
        this._timer = timer ?? Timer(Duration(seconds: 0), null);

  @override
  Widget build(BuildContext context) {
    double progressPercent;
    Widget timeLeftText;

    if (_secondsLeft != null) {
      progressPercent = (_secondsLeft / _totalSeconds);
      if (_type == AppLocalization.of(context).secs) {
        timeLeftText = Text(
          //"$_seconds\n" + AppLocalization.of(context).game_flow__seconds_short,
          "${((_totalSeconds - _timer.tick) - (_totalSeconds - _secondsLeft)).toStringAsFixed(0)}\n" +
              AppLocalization.of(context).game_flow__seconds_short,
          textAlign: TextAlign.center,
        );
      } else if (_type == AppLocalization.of(context).mins) {
        timeLeftText = Text(
          //"$_seconds\n" + AppLocalization.of(context).game_flow__seconds_short,
          "${(((_totalSeconds - _timer.tick) - (_totalSeconds - _secondsLeft)) / 60).toStringAsFixed(0)}\n" +
              AppLocalization.of(context).game_flow__minutes_short,
          textAlign: TextAlign.center,
        );
      } else if (_type == AppLocalization.of(context).hours) {
        timeLeftText = Text(
          //"$_seconds\n" + AppLocalization.of(context).game_flow__seconds_short,
          "${(((_totalSeconds - _timer.tick) - (_totalSeconds - _secondsLeft)) / 3600).toStringAsFixed(0)}\n" +
              AppLocalization.of(context).game_flow__hours_short,
          textAlign: TextAlign.center,
        );
      } else if (_type == AppLocalization.of(context).days) {
        timeLeftText = Text(
          //"$_seconds\n" + AppLocalization.of(context).game_flow__seconds_short,
          "${(((_totalSeconds - _timer.tick) - (_totalSeconds - _secondsLeft)) / 86400).toStringAsFixed(0)}\n" +
              AppLocalization.of(context).game_flow__days_short,
          textAlign: TextAlign.center,
        );
      } else {
        timeLeftText = Text(
          //"$_seconds\n" + AppLocalization.of(context).game_flow__seconds_short,
          "${((_totalSeconds - _timer.tick) - (_totalSeconds - _secondsLeft)).toStringAsFixed(0)}\n" +
              AppLocalization.of(context).game_flow__seconds_short,
          textAlign: TextAlign.center,
        );
      }
    } else {
      timeLeftText = Text(
        //"$_seconds\n" + AppLocalization.of(context).game_flow__seconds_short,
        "${(_totalSeconds - _timer.tick).toStringAsFixed(0)}\n" +
            AppLocalization.of(context).game_flow__seconds_short,
        textAlign: TextAlign.center,
      );
      progressPercent = 1 - (_timer.tick / _totalSeconds);
    }

    return CircularPercentIndicator(
      radius: 70.0,
      lineWidth: 4.0,
      percent: progressPercent,
      center: timeLeftText,
      progressColor: Color.fromARGB(153, 255, 255, 255),
      backgroundColor: Color.fromARGB(76, 255, 255, 255),
    );
  }
}
