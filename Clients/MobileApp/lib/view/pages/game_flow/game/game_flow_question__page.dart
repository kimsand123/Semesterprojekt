import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golfquiz_dtu/misc/game_flow_helper.dart';
import 'package:golfquiz_dtu/models/game.dart';
import 'package:golfquiz_dtu/models/game_round.dart';
import 'package:golfquiz_dtu/models/player.dart';
import 'package:golfquiz_dtu/models/player_status.dart';
import 'package:golfquiz_dtu/network/remote_helper.dart';
import 'package:golfquiz_dtu/providers/current_game__provider.dart';
import 'package:golfquiz_dtu/providers/me__provider.dart';
import 'package:golfquiz_dtu/routing/route_constants.dart';
import 'package:golfquiz_dtu/view/animations/fade_in_btt__animation.dart';
import 'package:golfquiz_dtu/view/base_pages/base_page.dart';
import 'package:golfquiz_dtu/view/components/answer_button__component.dart';
import 'package:golfquiz_dtu/view/components/game_duration_timer.dart';
import 'package:golfquiz_dtu/view/components/popup__component.dart';
import 'package:golfquiz_dtu/view/components/sliver_app_bar__component.dart';
import 'package:golfquiz_dtu/view/mixins/sliver_page__mixin.dart';
import 'package:provider/provider.dart';

class GameFlowQuestionPage extends BasePage {
  @override
  _GameFlowQuestionPageState createState() => _GameFlowQuestionPageState();
}

class _GameFlowQuestionPageState extends BasePageState<GameFlowQuestionPage>
    with SliverPage {
  Timer _timer;
  double _totalTime;

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
          ): null
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
        var currentUserInfo = GameFlowHelper.determinePlayerStatus(
            Provider.of<MeProvider>(context, listen: false).getPlayer.id,
            provider.getGame());

        return Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              alignment: Alignment.bottomLeft,
              child: Text(
                  '${appLocale().hole} ${currentUserInfo.gamePlayer.gameProgress + 1}',
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
                        '${game.questions[currentUserInfo.gamePlayer.gameProgress].questionText}'),
              ),
            ),
            buildAnswerButtons(currentUserInfo.gamePlayer.gameProgress)
          ],
        );
      },
    );
  }

  @override
  Widget appBarContainer() {
    return Consumer<CurrentGameProvider>(builder: (context, provider, child) {
      Game game = provider.getGame();
      var currentUserInfo = GameFlowHelper.determinePlayerStatus(
          Provider.of<MeProvider>(context, listen: false).getPlayer.id,
          provider.getGame());

      _totalTime = game.questionDuration;

      _timer = _timer ??
          Timer.periodic(Duration(seconds: 1), (timer) async {
            if (timer.tick == _totalTime.round()) {
              timer.cancel();

              updateWithNewGameRound(0, _totalTime + 0.0).then((v) {
                Navigator.pushReplacementNamed(context, gameFlowAnswerRoute,
                    arguments: false);
              }).catchError((error) async {
                debugPrint("Updating gameround" + error.toString());
                await disableProgressIndicator();

                if (error == "Token invalid") {
                  showPopupDialog(
                    context,
                    'You have been logged out',
                    'Your login has been expired, please login again',
                    {
                      Text(
                        "Ok",
                        style: TextStyle(color: Colors.black),
                      ): () {
                        RemoteHelper().emptyProvider(context).then(
                          (v) {
                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                introRoute,
                                ModalRoute.withName(
                                    Navigator.defaultRouteName));
                          },
                        );
                      },
                    },
                  );
                }

                showPopupDialog(
                  context,
                  'An error occured',
                  'Could not connect to the backend.\n${error.toString()}',
                  {
                    Text(
                      "Ok",
                      style: TextStyle(color: Colors.black),
                    ): null,
                  },
                );
              });

              Navigator.pushReplacementNamed(context, gameFlowAnswerRoute,
                  arguments: false);
            }
            setState(() {
              timer = timer;
            });
          });
      return SliverAppBarComponent(
        currentPlayerStatus: currentUserInfo,
        game: game,
        middleWidget:
            GameDurationTimer(timer: _timer, totalSeconds: _totalTime),
        rowLeftTitle: appLocale().game_flow__question__q_duration,
        rowRightTitle: appLocale().game_flow__question__your_score,
        rowLeftContent: '${_totalTime.toStringAsFixed(0)}s',
        rowRightContent: currentUserInfo.gamePlayer.score.toString(),
        showProgress: true,
        title: game.matchName,
      );
    });
  }

  @override
  String title() => appLocale().game_flow__question__title;

  Widget buildAnswerButtons(int questionNumber) {
    Game game =
        Provider.of<CurrentGameProvider>(context, listen: false).getGame();
    var question = game.questions[questionNumber];

    List<String> availableAnswers = [];
    availableAnswers.add(question.answer1);
    availableAnswers.add(question.answer2);
    availableAnswers.add(question.answer3);

    List<Widget> answerButtons = [];

    for (var i = 0; i < availableAnswers.length; i++) {
      answerButtons.add(FadeInBTTAnimation(
        child: AnswerButton(
          text: availableAnswers[i],
          onPressed: () async {
            if (i == (question.correctAnswer - 1)) {
              debugPrint('Pressed correct answer');
              _timer.cancel();
              final timeSpent = _timer.tick;

              updateWithNewGameRound(2, timeSpent + 0.0).then((v) {
                Navigator.pushReplacementNamed(context, gameFlowAnswerRoute,
                    arguments: true);
              }).catchError((error) async {
                debugPrint("Updating gameround" + error.toString());

                if (error == "Token invalid") {
                  showPopupDialog(
                    context,
                    'You have been logged out',
                    'Your login has been expired, please login again',
                    {
                      Text(
                        "Ok",
                        style: TextStyle(color: Colors.black),
                      ): () {
                        RemoteHelper().emptyProvider(context).then(
                          (v) {
                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                introRoute,
                                ModalRoute.withName(
                                    Navigator.defaultRouteName));
                          },
                        );
                      },
                    },
                  );
                }

                showPopupDialog(
                  context,
                  'An error occured',
                  'Could not connect to the backend.\n${error.toString()}',
                  {
                    Text(
                      "Ok",
                      style: TextStyle(color: Colors.black),
                    ): null,
                  },
                );
              });
            } else {
              debugPrint('Pressed wrong answer');
              _timer.cancel();
              final timeSpent = _timer.tick;

              updateWithNewGameRound(0, timeSpent + 0.0).then((v) {
                Navigator.pushReplacementNamed(context, gameFlowAnswerRoute,
                    arguments: false);
              }).catchError((error) async {
                debugPrint("Updating gameround" + error.toString());

                if (error == "Token invalid") {
                  showPopupDialog(
                    context,
                    'You have been logged out',
                    'Your login has been expired, please login again',
                    {
                      Text(
                        "Ok",
                        style: TextStyle(color: Colors.black),
                      ): () {
                        RemoteHelper().emptyProvider(context).then(
                          (v) {
                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                introRoute,
                                ModalRoute.withName(
                                    Navigator.defaultRouteName));
                          },
                        );
                      },
                    },
                  );
                }

                showPopupDialog(
                  context,
                  'An error occured',
                  'Could not connect to the backend.\n${error.toString()}',
                  {
                    Text(
                      "Ok",
                      style: TextStyle(color: Colors.black),
                    ): null,
                  },
                );
              });
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

  Future updateWithNewGameRound(int score, double timeSpent) async {
    MeProvider meProvider = Provider.of<MeProvider>(context, listen: false);
    CurrentGameProvider currentGameProvider =
        Provider.of<CurrentGameProvider>(context, listen: false);

    Player currentPlayer = meProvider.getPlayer;

    PlayerStatus currentPlayerStatus = GameFlowHelper.determinePlayerStatus(
        currentPlayer.id, currentGameProvider.getGame());

    currentPlayerStatus.gameRound
        .add(GameRound(score: score, timeSpent: timeSpent));

    currentPlayerStatus.gamePlayer.gameProgress =
        currentPlayerStatus.gameRound.length;

    currentPlayerStatus.gamePlayer.score += score;

    Game currentGame = currentGameProvider.getGame();

    await RemoteHelper()
        .updateGameInGameListProvider(context, currentGame, currentPlayer);

    await Provider.of<CurrentGameProvider>(context, listen: false)
        .updateCurrentGameFromRemote(context);
  }
}
