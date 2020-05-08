import 'package:flutter/material.dart';
import 'package:golfquiz_dtu/misc/constants.dart';
import 'package:golfquiz_dtu/models/game.dart';
import 'package:golfquiz_dtu/models/game_player.dart';
import 'package:golfquiz_dtu/models/player.dart';
import 'package:golfquiz_dtu/models/player_status.dart';
import 'package:golfquiz_dtu/network/game_service.dart';
import 'package:golfquiz_dtu/network/invite_service.dart';
import 'package:golfquiz_dtu/network/remote_helper.dart';
import 'package:golfquiz_dtu/providers/current_game__provider.dart';
import 'package:golfquiz_dtu/providers/game_list__provider.dart';
import 'package:golfquiz_dtu/providers/invite_list__provider.dart';
import 'package:golfquiz_dtu/providers/me__provider.dart';
import 'package:golfquiz_dtu/routing/route_constants.dart';
import 'package:golfquiz_dtu/view/animations/fade_in_rtl__animation.dart';
import 'package:golfquiz_dtu/view/base_pages/base_page.dart';
import 'package:golfquiz_dtu/view/components/active_games_card__component.dart';
import 'package:golfquiz_dtu/view/components/popup__component.dart';
import 'package:golfquiz_dtu/view/components/standard_button__component.dart';
import 'package:golfquiz_dtu/view/mixins/basic_page__mixin.dart';
import 'package:provider/provider.dart';

class GamesPage extends BasePage {
  @override
  _GamesPageState createState() => _GamesPageState();
}

class _GamesPageState extends BasePageState<GamesPage>
    with BasicPage, SingleTickerProviderStateMixin {
  @override
  Widget body() {
    return Column(
      children: <Widget>[
        FadeInRTLAnimation(
          child: Container(
            padding: EdgeInsets.only(
                left: 20.0, right: 20.0, top: 20.0, bottom: 8.0),
            alignment: Alignment.centerLeft,
            child: Text("Start a new match",
                style: Theme.of(context)
                    .textTheme
                    .headline
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary)),
          ),
          delay: 0.3,
        ),
        FadeInRTLAnimation(
          child: StandardButtonComponent(
            text: appLocale().games__start_new_match__two_player_match,
            width: screenWidth() - 35,
            onPressed: () {
              setCurrentGameProvider();
              Navigator.pushNamed(context, twoPlayerCreateRoute);
            },
          ),
          delay: 0.4,
        ),
        SizedBox(height: 20),
        FadeInRTLAnimation(
          child: Container(
            padding: EdgeInsets.only(
                left: 20.0, right: 20.0, top: 20.0, bottom: 8.0),
            alignment: Alignment.centerLeft,
            child: Text("Your games",
                style: Theme.of(context)
                    .textTheme
                    .headline
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary)),
          ),
          delay: 0.5,
        ),
        FadeInRTLAnimation(
          child: ActiveGamesCardComponent(
            gameMode: appLocale().games__your_matches__two_player_matches,
            onPressed: () async {
              await enableProgressIndicator("Gathering your games...");

              Player currentPlayer =
                  Provider.of<MeProvider>(context, listen: false).getPlayer;

              GameService.fetchGames(currentPlayer).then((value) async {
                Provider.of<GameListProvider>(context, listen: false)
                    .setGameList(value);

                await disableProgressIndicator();

                Navigator.pushNamed(context, gameListRoute,
                    arguments: GameType.two_player_match);

                return Future.value(true);
              }).catchError((error) async {
                debugPrint("Fetching games error" + error.toString());
                await disableProgressIndicator();

                if (error == "Token invalid") {
                  showPopupDialog(
                    context,
                    'Your session has expired',
                    'The app will log out. \nPlease login again.',
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
                } else {
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
                }
              });
            },
          ),
          delay: 0.6,
        ),
        SizedBox(height: 20),
        FadeInRTLAnimation(
          child: Container(
            padding: EdgeInsets.only(
                left: 20.0, right: 20.0, top: 20.0, bottom: 8.0),
            alignment: Alignment.centerLeft,
            child: Text("Your invites",
                style: Theme.of(context)
                    .textTheme
                    .headline
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary)),
          ),
          delay: 0.7,
        ),
        FadeInRTLAnimation(
          child: ActiveGamesCardComponent(
            gameMode: "Invites",
            subTitle: "Show all invites",
            onPressed: () async {
              await enableProgressIndicator("Gathering invites...");

              Player currentPlayer =
                  Provider.of<MeProvider>(context, listen: false).getPlayer;

              InviteService.fetchInvites(currentPlayer).then((value) async {
                Provider.of<InviteListProvider>(context, listen: false)
                    .setInviteList(value);

                await disableProgressIndicator();

                Navigator.pushNamed(context, inviteListRoute);
                return Future.value(true);
              }).catchError((error) async {
                debugPrint("Fetching invites error" + error.toString());
                await disableProgressIndicator();

                if (error == "Token invalid") {
                  showPopupDialog(
                    context,
                    'Your session has expired',
                    'The app will log out. \nPlease login again.',
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
                } else {
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
                }
              });
            },
          ),
          delay: 0.8,
        ),
      ],
    );
  }

  void setCurrentGameProvider() {
    Player currentUser =
        Provider.of<MeProvider>(context, listen: false).getPlayer;

    Game game = Game.init();

    List<PlayerStatus> playerstatusList = [];

    playerstatusList.add(
      PlayerStatus(
        gamePlayer: GamePlayer(player: currentUser, gameProgress: 0, score: 0),
        gameRound: [],
      ),
    );

    game.playerStatus = playerstatusList;

    Provider.of<CurrentGameProvider>(context, listen: false).setGame(game);
  }

  @override
  String title() => appLocale().games__title;
}
