import 'package:flutter/material.dart';
import 'package:golfquiz_dtu/localization/appLocalizations.dart';
import 'package:golfquiz_dtu/misc/constants.dart';
import 'package:golfquiz_dtu/misc/game_flow_helper.dart';
import 'package:golfquiz_dtu/models/game.dart';
import 'package:golfquiz_dtu/models/game_round.dart';
import 'package:golfquiz_dtu/models/player_status.dart';
import 'package:golfquiz_dtu/providers/current_game__provider.dart';
import 'package:golfquiz_dtu/providers/player__provider.dart';
import 'package:golfquiz_dtu/routing/route_constants.dart';
import 'package:golfquiz_dtu/view/base_pages/base_page.dart';
import 'package:golfquiz_dtu/view/components/popup__component.dart';
import 'package:golfquiz_dtu/view/components/sliver_app_bar__component.dart';
import 'package:golfquiz_dtu/view/components/standard_button__component.dart';
import 'package:golfquiz_dtu/view/mixins/sliver_page_overlay__mixin.dart';
import 'package:provider/provider.dart';

class GameFlowScoreboardPage extends BasePage {
  @override
  _GameFlowScoreboardPageState createState() => _GameFlowScoreboardPageState();
}

class _GameFlowScoreboardPageState extends BasePageState<GameFlowScoreboardPage>
    with SliverPageOverlay {
  @override
  double sliverAppBarHeight() => screenHeight() * 0.3;

  @override
  Widget appBarContainer() {
    return Consumer<CurrentGameProvider>(
      builder: (context, provider, child) {
        Game game = provider.getGame();
        var currentUserInfo = GameFlowHelper.determineUser(
            Provider.of<PlayerProvider>(context),
            Provider.of<CurrentGameProvider>(context));

        return SliverAppBarComponent(
          currentPlayerStatus: currentUserInfo,
          game: game,
          middleWidget:
              Icon(Icons.account_circle, size: 65, color: Color(0xCCFFFFFF)),
          rowLeftTitle: appLocale().game_flow__scoreboard__q_duration,
          rowLeftContent: game.questionDuration.toStringAsFixed(0) + 's',
          rowRightTitle: appLocale().game_flow__scoreboard__your_score,
          rowRightContent: currentUserInfo.gamePlayer.score.toString(),
          showProgress: true,
        );
      },
    );
  }

  @override
  Widget body() {
    return Consumer<CurrentGameProvider>(
      builder: (context, provider, child) {
        Game game = provider.getGame();
        var player = GameFlowHelper.determineUser(
            Provider.of<PlayerProvider>(context),
            Provider.of<CurrentGameProvider>(context));
        return Padding(
          padding: EdgeInsets.only(bottom: screenHeight() * 0.15),
          child: Column(
            children: generateList(player, game, context),
          ),
        );
      },
    );
  }

  @override
  Widget bottomBar() {
    Color color = GameFlowHelper.setPopupTextColor(context);

    return Positioned(
      top: screenHeight() - screenHeight() * 0.12,
      child: Container(
        height: screenHeight() * 0.12,
        width: screenWidth(),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Consumer<CurrentGameProvider>(
              builder: (context, provider, child) {
                Game game = provider.getGame();
                var playerStatus = GameFlowHelper.determineUser(
                    Provider.of<PlayerProvider>(context),
                    Provider.of<CurrentGameProvider>(context));

                return StandardButtonComponent(
                  text: appLocale().game_flow__scoreboard__end_game,
                  onPressed: () {
                    showPopupDialog(context,
                        appLocale().game_flow__scoreboard__pause_dialog, null, {
                      Text(appLocale().yes,
                          style: appTheme()
                              .textTheme
                              .button
                              .copyWith(color: color)): () {
                        Provider.of<CurrentGameProvider>(context, listen: false)
                            .incrementPlayerProgress(
                                playerStatus.gamePlayer.player);
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
                  width: screenWidth() * 0.3,
                  color: appTheme().highlightColor,
                  borderColor: Color(0x90FFFFFF),
                  height: 35.0,
                );
              },
            ),
            Consumer<CurrentGameProvider>(
              builder: (context, provider, child) {
                Game game = provider.getGame();
                var player = GameFlowHelper.determineUser(
                    Provider.of<PlayerProvider>(context),
                    Provider.of<CurrentGameProvider>(context));

                return StandardButtonComponent(
                  text: appLocale().game_flow__scoreboard__resume,
                  onPressed: () {
                    if (provider.getPlayerProgress(player.gamePlayer.player) >=
                        18) {
                      var donePlayers = 0;
                      if (game.gameType == GameType.two_player_match) {
                        Provider.of<CurrentGameProvider>(context, listen: false)
                            .setGame(game);
                        Navigator.pushNamedAndRemoveUntil(context, gameRoute,
                            ModalRoute.withName(Navigator.defaultRouteName));
                      } else if (game.gameType == GameType.group_match ||
                          game.gameType == GameType.tournaments) {
                        for (var i = 0; i < game.playerStatus.length; i++) {
                          if (game.playerStatus[i].gamePlayer.gameProgress ==
                              18) {
                            donePlayers++;
                          }
                        }

                        if (donePlayers == game.playerStatus.length) {
                          Provider.of<CurrentGameProvider>(context,
                                  listen: false)
                              .setGame(game);
                          Navigator.pushNamedAndRemoveUntil(context, gameRoute,
                              ModalRoute.withName(Navigator.defaultRouteName));
                        } else {
                          Provider.of<CurrentGameProvider>(context,
                                  listen: false)
                              .setGame(game);
                          Navigator.pushNamedAndRemoveUntil(context, gameRoute,
                              ModalRoute.withName(Navigator.defaultRouteName));
                        }
                      } else {
                        Provider.of<CurrentGameProvider>(context, listen: false)
                            .setGame(game);
                        Navigator.pushNamedAndRemoveUntil(context, gameRoute,
                            ModalRoute.withName(Navigator.defaultRouteName));
                      }
                    } else {
                      if (game.gameType == GameType.two_player_match) {
                        provider
                            .incrementPlayerProgress(player.gamePlayer.player);
                        Provider.of<CurrentGameProvider>(context, listen: false)
                            .setGame(game);

                        Navigator.pushNamedAndRemoveUntil(
                            context,
                            gameFlowQuestionRoute,
                            ModalRoute.withName(Navigator.defaultRouteName));
                      }
                    }
                  },
                  width: screenWidth() * 0.3,
                  height: 35.0,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

generateList(PlayerStatus player, Game game, BuildContext context) {
  List<Widget> gameHistory = List();
  final history = player.gameRound;
  double screenWidth = MediaQuery.of(context).size.width;

  gameHistory = multiPlayerGameHistory(gameHistory, context, screenWidth);
  gameHistory =
      multiPlayerHistory(history, gameHistory, context, screenWidth, game);

  return gameHistory;
}

List<Widget> multiPlayerGameHistory(
    List<Widget> gameHistory, BuildContext context, double screenWidth) {
  gameHistory.add(
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
              child: textTitle(context,
                  AppLocalization.of(context).game_flow__scoreboard__player),
            ),
            Container(
              width: ((screenWidth / 3)) - (10 * 2),
              alignment: Alignment.center,
              child: textTitle(context,
                  AppLocalization.of(context).game_flow__scoreboard__handicap),
            ),
            Container(
              width: ((screenWidth / 3)) - (10 * 2),
              alignment: Alignment.centerRight,
              child: textTitle(context,
                  AppLocalization.of(context).game_flow__scoreboard__points),
            ),
          ],
        ),
      ),
    ),
  );
  return gameHistory;
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
    if (Provider.of<PlayerProvider>(context, listen: false).getPlayer.id ==
        status[i].gamePlayer.player.id) {
      color = Color(0xFFBEFCD3);
      playerName = AppLocalization.of(context).you;
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
                child: numberText(
                    context, '${game.playerStatus[i].gamePlayer.score}'),
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
