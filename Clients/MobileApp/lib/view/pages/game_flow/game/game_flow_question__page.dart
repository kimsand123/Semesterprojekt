import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golfquiz/misc/game_flow_helper.dart';
import 'package:golfquiz/models/game.dart';
import 'package:golfquiz/providers/current_game__provider.dart';
import 'package:golfquiz/providers/user__provider.dart';
import 'package:golfquiz/routing/route_constants.dart';
import 'package:golfquiz/view/animations/fade_in_btt__animation.dart';
import 'package:golfquiz/view/base_pages/base_page.dart';
import 'package:golfquiz/view/components/answer_button__component.dart';
import 'package:golfquiz/view/components/game_duration_timer.dart';
import 'package:golfquiz/view/components/popup__component.dart';
import 'package:golfquiz/view/components/sliver_app_bar__component.dart';
import 'package:golfquiz/view/mixins/sliver_page__mixin.dart';
import 'package:provider/provider.dart';

class GameFlowQuestionPage extends BasePage {
  @override
  _GameFlowQuestionPageState createState() => _GameFlowQuestionPageState();
}

class _GameFlowQuestionPageState extends BasePageState<GameFlowQuestionPage>
    with SliverPage {
  Timer _timer;
  var _totalTime;

  @override
  Widget action() {
    Color color = GameFlowHelper.setPopupTextColor(context);
    return GestureDetector(
      onTap: () {
        showPopupDialog(
            context, appLocale().game_flow__result__pause_dialog, null, {
          Text(appLocale().yes,
              style: appTheme().textTheme.button.copyWith(color: color)): () {
            _timer.cancel();
            Navigator.pushNamedAndRemoveUntil(context, gameRoute,
                ModalRoute.withName(Navigator.defaultRouteName));
          },
          Text(
            appLocale().no,
            style: appTheme()
                .textTheme
                .button
                .copyWith(color: appTheme().errorColor),
          ): () {}
        });
      },
      child: Container(
          padding: EdgeInsets.only(right: 20.0, top: 15.0),
          child: Text('Pause', style: appTheme().textTheme.subhead)),
    );
  }

  @override
  Widget body() {
    return Consumer<CurrentGameProvider>(
      builder: (context, provider, child) {
        Game game = provider.getGame();
        var currentUserInfo = GameFlowHelper.determineUser(
                Provider.of<UserProvider>(context),
                Provider.of<CurrentGameProvider>(context))
            .values
            .toList()[0];

        return Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              alignment: Alignment.bottomLeft,
              child: Text('${appLocale().hole} ${currentUserInfo.gameProgress}',
                  style: appTheme()
                      .textTheme
                      .subhead
                      .copyWith(color: Color(0xFF2D2D2D))),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              width: screenWidth(),
              decoration: BoxDecoration(
                  border:
                      Border.all(color: appTheme().highlightColor, width: 1),
                  borderRadius: BorderRadius.circular(10.0)),
              child: RichText(
                text: TextSpan(
                    style: appTheme()
                        .textTheme
                        .display1
                        .copyWith(color: Color(0xFF2D2D2D)),
                    text:
                        '${game.questions[currentUserInfo.gameProgress - 1].question}'),
              ),
            ),
            buildAnswerButtons(currentUserInfo.gameProgress - 1)
          ],
        );
      },
    );
  }

  @override
  Widget appBarContainer() {
    return Consumer<CurrentGameProvider>(builder: (context, provider, child) {
      Game game = provider.getGame();
      var currentUserInfo = GameFlowHelper.determineUser(
              Provider.of<UserProvider>(context),
              Provider.of<CurrentGameProvider>(context))
          .values
          .toList()[0];

      _totalTime = game.questionDuration;

      _timer = _timer ??
          Timer.periodic(Duration(seconds: 1), (timer) {
            if (timer.tick == _totalTime) {
              timer.cancel();
              Navigator.pushReplacementNamed(context, gameFlowAnswerRoute,
                  arguments: false);
              Provider.of<CurrentGameProvider>(context, listen: false)
                  .setGameHistory(currentUserInfo, currentUserInfo.gameProgress,
                      _totalTime.round(), currentUserInfo.score);
            }
            setState(() {
              timer = timer;
            });
          });
      return SliverAppBarComponent(
        currentUserInfo: currentUserInfo,
        game: game,
        middleWidget:
            GameDurationTimer(timer: _timer, totalSeconds: _totalTime),
        rowLeftTitle: appLocale().game_flow__question__q_duration,
        rowRightTitle: appLocale().game_flow__question__your_score,
        rowLeftContent: '${_totalTime.toStringAsFixed(0)}s',
        rowRightContent: currentUserInfo.score,
        showProgress: true,
        title: game.matchName,
      );
    });
  }

  @override
  String title() => appLocale().game_flow__question__title;

  Widget buildAnswerButtons(int questionNumber) {
    Game game = Provider.of<CurrentGameProvider>(context).getGame();
    var question = game.questions[questionNumber];
    var availableAnswers = question.answers;
    var player = GameFlowHelper.determineUser(
            Provider.of<UserProvider>(context),
            Provider.of<CurrentGameProvider>(context))
        .values
        .toList()[0];

    List<Widget> answerButtons = List();

    for (var i = 0; i < availableAnswers.length; i++) {
      answerButtons.add(FadeInBTTAnimation(
        child: AnswerButton(
          text: availableAnswers[i],
          onPressed: () {
            if (i == question.correctAnswer - 1) {
              debugPrint('Pressed correct answer');
              _timer.cancel();
              final timeSpent = _timer.tick;
              Provider.of<CurrentGameProvider>(context, listen: false)
                  .setGameHistory(
                      player, player.gameProgress, timeSpent, player.score);
              Navigator.pushReplacementNamed(context, gameFlowAnswerRoute,
                  arguments: true);
            } else {
              debugPrint('Pressed wrong answer');
              _timer.cancel();
              final timeSpent = _timer.tick;
              Provider.of<CurrentGameProvider>(context, listen: false)
                  .setGameHistory(
                      player, player.gameProgress, timeSpent, player.score);
              Navigator.pushReplacementNamed(context, gameFlowAnswerRoute,
                  arguments: false);
            }
          },
        ),
        delay: 0.2 * (i + 1),
      ));
    }

    var answers = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: answerButtons,
    );
    return answers;
  }
}
