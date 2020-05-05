import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:golfquiz_dtu/misc/constants.dart';
import 'package:golfquiz_dtu/misc/game_flow_helper.dart';
import 'package:golfquiz_dtu/models/game.dart';
import 'package:golfquiz_dtu/models/question.dart';
import 'package:golfquiz_dtu/providers/current_game__provider.dart';
import 'package:golfquiz_dtu/providers/me__provider.dart';
import 'package:golfquiz_dtu/routing/route_constants.dart';
import 'package:golfquiz_dtu/view/base_pages/base_page.dart';
import 'package:golfquiz_dtu/view/components/popup__component.dart';
import 'package:golfquiz_dtu/view/components/round_button__component.dart';
import 'package:golfquiz_dtu/view/components/sliver_app_bar__component.dart';
import 'package:golfquiz_dtu/view/mixins/sliver_page_overlay__mixin.dart';
import 'package:provider/provider.dart';

class GameFlowResultPage extends BasePage {
  final bool _wasQuestionCorrect;

  GameFlowResultPage({wasQuestionCorrect})
      : this._wasQuestionCorrect = wasQuestionCorrect;

  @override
  _GameFlowResultPageState createState() => _GameFlowResultPageState();
}

class _GameFlowResultPageState extends BasePageState<GameFlowResultPage>
    with SliverPageOverlay {
  double top = 1000;
  double opacity = 0;
  bool visible = false;
  bool _isContinuePressed = true;
  String animationStatePause = 'pause';
  String animationStateContinue = '';
  String overlayTitle = '';
  Duration duration = Duration(milliseconds: 250);

  @override
  Widget body() {
    return Consumer<CurrentGameProvider>(
      builder: (context, provider, child) {
        Game game = provider.getGame();
        var currentUserInfo = GameFlowHelper.determinePlayerStatus(
            Provider.of<MeProvider>(context, listen: false).getPlayer.id,
            provider.getGame());

        int gameProgress = currentUserInfo.gamePlayer.gameProgress;
        Question currentQuestion = game.questions[gameProgress];
        String answerText = "";

        if (currentQuestion.correctAnswer == 1) {
          answerText = currentQuestion.answer1;
        } else if (currentQuestion.correctAnswer == 2) {
          answerText = currentQuestion.answer2;
        } else {
          answerText = currentQuestion.answer3;
        }

        return Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 20.0, bottom: 10),
              alignment: Alignment.bottomLeft,
              child: Text(
                  appLocale().game_flow__result__hole(gameProgress) +
                      " out of 18",
                  style: appTheme()
                      .textTheme
                      .subhead
                      .copyWith(fontSize: 25, color: Color(0xFF2D2D2D))),
            ),
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              alignment: Alignment.bottomLeft,
              child: Text("Question",
                  style: appTheme()
                      .textTheme
                      .subhead
                      .copyWith(color: Color(0xFF2D2D2D))),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
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
                    text: '${currentQuestion.questionText}'),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
              alignment: Alignment.bottomLeft,
              child: Text("Answer",
                  style: appTheme()
                      .textTheme
                      .subhead
                      .copyWith(color: Color(0xFF2D2D2D))),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
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
                    text: '$answerText'),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget bottomBar() {
    Color color = GameFlowHelper.setPopupTextColor(context);

    return Positioned(
        top: screenHeight() - screenHeight() * 0.15,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0)),
              gradient: LinearGradient(
                  begin: FractionalOffset.centerLeft,
                  end: FractionalOffset.centerRight,
                  colors: [
                    appTheme().colorScheme.primary,
                    appTheme().colorScheme.secondary
                  ])),
          width: screenWidth(),
          height: screenHeight() * 0.2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RoundButtonComponent(
                isPaused: true,
                animationState: '',
                icon: 'assets/animations/scoreboard.flr',
                onPressed: () {
                  Navigator.pushNamed(context, gameFlowScoreboard);
                },
                text: appLocale().game_flow__result__scoreboard,
              ),
              Consumer<CurrentGameProvider>(
                  builder: (context, gameProvider, child) {
                Game game = gameProvider.getGame();
                var currentPlayerStatus = GameFlowHelper.determinePlayerStatus(
                    Provider.of<MeProvider>(context, listen: false)
                        .getPlayer
                        .id,
                    gameProvider.getGame());
                return RoundButtonComponent(
                  isPaused: true,
                  icon: 'assets/animations/pause_play.flr',
                  text: 'Pause',
                  animationState: '',
                  onPressed: () {
                    showPopupDialog(context,
                        appLocale().game_flow__result__pause_dialog, null, {
                      Text(appLocale().yes,
                          style: appTheme()
                              .textTheme
                              .button
                              .copyWith(color: color)): () {
                        Provider.of<CurrentGameProvider>(context, listen: false)
                            .incrementPlayerProgress(
                                currentPlayerStatus.gamePlayer.player);
                        Provider.of<CurrentGameProvider>(context, listen: false)
                            .setGame(game);
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
                );
              }),
              Consumer<CurrentGameProvider>(
                builder: (context, provider, child) {
                  Game game = provider.getGame();
                  var playerStatus = GameFlowHelper.determinePlayerStatus(
                      Provider.of<MeProvider>(context, listen: false)
                          .getPlayer
                          .id,
                      provider.getGame());

                  return RoundButtonComponent(
                    isPaused: _isContinuePressed,
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    animationState: animationStateContinue,
                    icon: 'assets/animations/continue.flr',
                    text: appLocale().game_flow__result__continue,
                    onPressed: () {
                      setState(() {
                        _isContinuePressed = false;
                        animationStateContinue = 'continue';
                      });
                      if (provider.getPlayerProgress(
                              playerStatus.gamePlayer.player) >=
                          18) {
                        var donePlayers = 0;
                        if (game.gameType == GameType.two_player_match) {
                          Provider.of<CurrentGameProvider>(context,
                                  listen: false)
                              .setGame(game);
                          Navigator.pushReplacementNamed(context, gameRoute);
                        } else {
                          Provider.of<CurrentGameProvider>(context,
                                  listen: false)
                              .setGame(game);
                          Navigator.pushReplacementNamed(context, gameRoute);
                        }
                      } else {
                        if (game.gameType == GameType.two_player_match) {
                          provider.incrementPlayerProgress(
                              playerStatus.gamePlayer.player);
                          Provider.of<CurrentGameProvider>(context,
                                  listen: false)
                              .setGame(game);
                          Navigator.pushReplacementNamed(
                              context, gameFlowQuestionRoute);
                        } else if (game.gameType == GameType.group_match ||
                            game.gameType == GameType.tournaments) {
                          provider.incrementPlayerProgress(
                              playerStatus.gamePlayer.player);
                          Provider.of<CurrentGameProvider>(context,
                                  listen: false)
                              .setGame(game);
                          Navigator.pushReplacementNamed(
                              context, gameFlowQuestionRoute);
                        } else {
                          provider.incrementPlayerProgress(
                              playerStatus.gamePlayer.player);
                          Provider.of<CurrentGameProvider>(context,
                                  listen: false)
                              .setGame(game);
                          Navigator.pushReplacementNamed(
                              context, gameFlowQuestionRoute);
                        }
                      }
                    },
                  );
                },
              )
            ],
          ),
        ));
  }

  @override
  Widget appBarContainer() {
    String title = widget._wasQuestionCorrect
        ? appLocale().game_flow__result__correct
        : appLocale().game_flow__result__wrong;
    String flare = widget._wasQuestionCorrect
        ? 'assets/animations/correct.flr'
        : 'assets/animations/wrong.flr';
    String animation = widget._wasQuestionCorrect ? 'check' : 'Error';

    return Consumer<CurrentGameProvider>(builder: (context, provider, child) {
      Game game = provider.getGame();
      var currentUserInfo = GameFlowHelper.determinePlayerStatus(
          Provider.of<MeProvider>(context, listen: false).getPlayer.id,
          provider.getGame());

      return SliverAppBarComponent(
        fontSize: 30.0,
        currentPlayerStatus: currentUserInfo,
        game: game,
        middleWidget: Container(
            width: screenWidth() * 0.2,
            height: screenHeight() * 0.1,
            child: FlareActor(
              flare,
              alignment: Alignment.center,
              animation: animation,
              fit: BoxFit.cover,
            )),
        showProgress: true,
        title: title,
      );
    });
  }

  @override
  Widget backdrop() {
    return GestureDetector(
      onTap: () {
        setState(() {
          top = screenHeight();
          opacity = 0;
          visible = false;
        });
      },
      child: Visibility(
        maintainState: true,
        maintainAnimation: true,
        visible: visible,
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 250),
          opacity: opacity,
          child: Container(
            width: screenWidth(),
            height: screenHeight(),
            color: Color(0x50000000),
          ),
        ),
      ),
    );
  }

  @override
  Widget overlay() {
    return AnimatedPositioned(
      duration: duration,
      top: top,
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          GestureDetector(
            onPanEnd: (details) {
              setState(() {
                if (top > screenHeight() * 0.3) {
                  top = screenHeight();
                  visible = false;
                  opacity = 0;
                  duration = Duration(milliseconds: 250);
                } else {
                  top = screenHeight() * 0.15;
                  duration = Duration(milliseconds: 250);
                }
              });
            },
            onPanUpdate: (details) {
              duration = Duration(milliseconds: 100);
              setState(() {
                top = details.globalPosition.dy;
                if (opacity <= 0) {
                  opacity = 0;
                } else {
                  opacity = (screenHeight() - details.globalPosition.dy) / 1000;
                }
                if (top < screenHeight() * 0.15) {
                  top = screenHeight() * 0.15;
                }
              });
            },
            child: Consumer<CurrentGameProvider>(
                builder: (context, provider, child) {
              return Container(
                margin: EdgeInsets.only(top: 10),
                height: screenHeight(),
                width: screenWidth(),
                alignment: Alignment.topCenter,
                child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Column(children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: pill(),
                        ),
                        Text(appLocale().game_flow__result__rule("0"),
                            style: Theme.of(context)
                                .textTheme
                                .headline
                                .copyWith(color: Color(0xFF2D2D2D))),
                        Container(
                            padding: EdgeInsets.symmetric(vertical: 20.0),
                            height: screenHeight(),
                            child: Text(
                                '${"Cannot be gathered in this version"}',
                                style: appTheme()
                                    .textTheme
                                    .subhead
                                    .copyWith(color: Color(0xFF2D2D2D))))
                      ]),
                    ]),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0)),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, -5),
                          blurRadius: 3,
                          color: Color(0x20000000))
                    ]),
              );
            }),
          ),
        ]),
      ),
    );
  }

  pill() {
    return Container(
      width: 50,
      height: 5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0), color: Color(0x50000000)),
    );
  }
}
