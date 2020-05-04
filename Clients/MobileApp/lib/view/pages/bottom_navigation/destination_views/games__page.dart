import 'package:flutter/material.dart';
import 'package:golfquiz_dtu/misc/constants.dart';
import 'package:golfquiz_dtu/models/game.dart';
import 'package:golfquiz_dtu/models/game_player.dart';
import 'package:golfquiz_dtu/models/player.dart';
import 'package:golfquiz_dtu/models/player_status.dart';
import 'package:golfquiz_dtu/providers/current_game__provider.dart';
import 'package:golfquiz_dtu/providers/user__provider.dart';
import 'package:golfquiz_dtu/routing/route_constants.dart';
import 'package:golfquiz_dtu/view/animations/fade_in_rtl__animation.dart';
import 'package:golfquiz_dtu/view/base_pages/base_page.dart';
import 'package:golfquiz_dtu/view/components/active_games_card__component.dart';
import 'package:golfquiz_dtu/view/components/standard_button__component.dart';
import 'package:golfquiz_dtu/view/mixins/basic_page__mixin.dart';
import 'package:golfquiz_dtu/view/pages/bottom_navigation/navigation__container.dart';
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
        Container(
          padding:
              EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 8.0),
          alignment: Alignment.centerLeft,
          child: Text(appLocale().games__start_new_match,
              style: Theme.of(context)
                  .textTheme
                  .headline
                  .copyWith(color: Theme.of(context).colorScheme.onPrimary)),
        ),
        Container(
            child: Column(
          children: <Widget>[
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
          ],
        )),
        SizedBox(height: BottomNavigationContainer.height + 20),
        FadeInRTLAnimation(
          child: ActiveGamesCardComponent(
            gameMode: appLocale().games__your_matches__two_player_matches,
            onPressed: () {
              Navigator.pushNamed(context, gameListRoute,
                  arguments: GameType.two_player_match);
            },
          ),
          delay: 0.7,
        ),
      ],
    );
  }

  void setCurrentGameProvider() {
    Player currentUser =
        Provider.of<PlayerProvider>(context, listen: false).getPlayer;

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
