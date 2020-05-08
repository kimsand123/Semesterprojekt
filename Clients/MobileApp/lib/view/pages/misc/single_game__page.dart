import 'package:flutter/material.dart';
import 'package:golfquiz_dtu/misc/constants.dart';
import 'package:golfquiz_dtu/misc/game_flow_helper.dart';
import 'package:golfquiz_dtu/models/game.dart';
import 'package:golfquiz_dtu/models/game_round.dart';
import 'package:golfquiz_dtu/models/player_status.dart';
import 'package:golfquiz_dtu/providers/current_game__provider.dart';
import 'package:golfquiz_dtu/providers/me__provider.dart';
import 'package:golfquiz_dtu/routing/route_constants.dart';
import 'package:golfquiz_dtu/view/base_pages/base_page.dart';
import 'package:golfquiz_dtu/view/components/sliver_app_bar__component.dart';
import 'package:golfquiz_dtu/view/components/standard_button__component.dart';
import 'package:golfquiz_dtu/view/mixins/sliver_page_overlay__mixin.dart';
import 'package:provider/provider.dart';

class SingleGamePage extends BasePage {
  final Game gameItem;

  SingleGamePage({this.gameItem});

  @override
  _SingleGamePageState createState() => _SingleGamePageState();
}

class _SingleGamePageState extends BasePageState<SingleGamePage>
    with SliverPageOverlay {
  @override
  double sliverAppBarHeight() => screenHeight() * 0.3;

  @override
  Widget appBarContainer() {
    return Consumer<CurrentGameProvider>(
      builder: (context, provider, child) {
        MeProvider playerProvider =
            Provider.of<MeProvider>(context, listen: false);
        CurrentGameProvider gameProvider =
            Provider.of<CurrentGameProvider>(context, listen: false);

        PlayerStatus currentPlayerStatus = GameFlowHelper.determinePlayerStatus(
            playerProvider.getPlayer.id, gameProvider.getGame());

        return SliverAppBarComponent(
          currentPlayerStatus: currentPlayerStatus,
          game: widget.gameItem,
          middleWidget:
              Icon(Icons.account_circle, size: 65, color: Color(0xCCFFFFFF)),
          rowLeftTitle: appLocale().game_appbar__question_duration,
          rowLeftContent:
              widget.gameItem.questionDuration.toStringAsFixed(0) + 's',
          rowRightTitle: appLocale().game_appbar__your_score,
          rowRightContent: currentPlayerStatus.gamePlayer.score.toString(),
          showProgress: true,
        );
      },
    );
  }

  @override
  Widget body() {
    Game _safeUnwrappedGame = widget.gameItem;

    if (_safeUnwrappedGame == null) {
      _safeUnwrappedGame = Game.init();
      Provider.of<CurrentGameProvider>(context, listen: false)
          .setGame(_safeUnwrappedGame);
    }

    MeProvider playerProvider = Provider.of<MeProvider>(context, listen: false);

    PlayerStatus currentPlayerStatus = GameFlowHelper.determinePlayerStatus(
        playerProvider.getPlayer.id, _safeUnwrappedGame);

    return Padding(
      padding: EdgeInsets.only(bottom: screenHeight() * 0.15),
      child: Column(
        children:
            generateList(currentPlayerStatus, _safeUnwrappedGame, context),
      ),
    );
  }

  @override
  Widget bottomBar() {
    // Safe unwrapping of object to make sure if it should be opened
    Game game = widget.gameItem ?? Game();
    MeProvider playerProvider = Provider.of<MeProvider>(context, listen: false);

    PlayerStatus currentPlayerStatus =
        GameFlowHelper.determinePlayerStatus(playerProvider.getPlayer.id, game);

    int userProgress = currentPlayerStatus.gamePlayer.gameProgress ?? maxHoles;

    bool isGameOver = !game.isActive && userProgress == maxHoles;

    return Visibility(
      visible: !isGameOver,
      child: Positioned(
        top: screenHeight() - screenHeight() * 0.12,
        child: Container(
          height: screenHeight() * 0.12,
          width: screenWidth(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            gradient: LinearGradient(
              begin: FractionalOffset.centerLeft,
              end: FractionalOffset.centerRight,
              colors: [
                appTheme().colorScheme.primary,
                appTheme().colorScheme.secondary
              ],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              StandardButtonComponent(
                text: appLocale().exit,
                onPressed: () {
                  Navigator.pop(context);
                },
                width: screenWidth() * 0.3,
                color: appTheme().highlightColor,
                borderColor: Color(0x90FFFFFF),
                height: 35.0,
              ),
              Consumer<CurrentGameProvider>(
                builder: (context, provider, child) {
                  return determineButtonToShow(game, userProgress);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  determineButtonToShow(Game game, int userProgress) {
    return StandardButtonComponent(
      text: appLocale().resume,
      onPressed: () {
        Navigator.pushNamedAndRemoveUntil(context, gameFlowQuestionRoute,
            ModalRoute.withName(Navigator.defaultRouteName));
      },
      width: screenWidth() * 0.3,
      height: 35.0,
    );
  }

  generateList(PlayerStatus player, Game game, BuildContext context) {
    List<Widget> gameHistory = List();
    final history = player.gameRound ?? [];
    double screenWidth = MediaQuery.of(context).size.width;

    gameHistory = multiPlayerGameHistory(gameHistory, context, screenWidth);
    gameHistory =
        multiPlayerHistory(history, gameHistory, context, screenWidth, game);

    return gameHistory;
  }

  List<Widget> multiPlayerGameHistory(
      List<Widget> gameRounds, BuildContext context, double screenWidth) {
    gameRounds.add(
      Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Color(0x502D2D2D),
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: ((screenWidth / 3)) - (10 * 2),
                alignment: Alignment.centerLeft,
                child: textTitle(context, appLocale().player),
              ),
              Container(
                width: ((screenWidth / 3)) - (10 * 2),
                alignment: Alignment.center,
                child: textTitle(context, appLocale().points),
              ),
              Container(
                width: ((screenWidth / 3)) - (10 * 2),
                alignment: Alignment.centerRight,
                child: textTitle(context, "Highscore"),
              ),
            ],
          ),
        ),
      ),
    );
    return gameRounds;
  }

  List<Widget> multiPlayerHistory(
      List<GameRound> history,
      List<Widget> gameHistory,
      BuildContext context,
      double screenWidth,
      Game game) {
    List<PlayerStatus> status = game.playerStatus;
    for (var i = 0; i < status.length; i++) {
      Color color;
      String playerName;
      if (Provider.of<MeProvider>(context, listen: false).getPlayer.id ==
          status[i].gamePlayer.player.id) {
        color = Color(0xFFBEFCD3);
        playerName = appLocale().you;
      } else {
        color = Colors.white;
        playerName = '${status[i].gamePlayer.player.firstName}';
      }
      gameHistory.add(
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
            color: color,
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: Color(0x502D2D2D),
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: ((screenWidth / 3)) - (10 * 2),
                  alignment: Alignment.centerLeft,
                  child: playerText(context, playerName),
                ),
                Container(
                  width: ((screenWidth / 3)) - (10 * 2),
                  alignment: Alignment.center,
                  child: numberText(context, '${status[i].gamePlayer.score}'),
                ),
                Container(
                  width: ((screenWidth / 3)) - (10 * 2),
                  alignment: Alignment.centerRight,
                  child: numberText(context,
                      '${game.playerStatus[i].gamePlayer.player.highScore}'),
                )
              ],
            ),
          ),
        ),
      );
    }
    return gameHistory;
  }

  Widget textTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.body2.copyWith(
            color: Color(0xFF2D2D2D),
          ),
    );
  }

  Widget numberText(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.body2.copyWith(
            color: Color(0x502D2D2D),
          ),
    );
  }

  Widget playerText(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.body2.copyWith(
            color: Color(0xBB2D2D2D),
          ),
    );
  }

  Widget bubbleContainer(BuildContext context, String title) {
    return Container(
      height: 25,
      width: 25,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: Theme.of(context).colorScheme.primary),
      child: Text(
        title,
        style: Theme.of(context).textTheme.body2,
      ),
    );
  }
}
