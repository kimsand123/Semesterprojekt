import 'package:flutter/material.dart';
import 'package:golfquiz/models/game.dart';
import 'package:golfquiz/models/game_player.dart';
import 'package:golfquiz/models/player.dart';
import 'package:golfquiz/models/player_status.dart';
import 'package:golfquiz/providers/current_game__provider.dart';
import 'package:golfquiz/providers/user__provider.dart';
import 'package:golfquiz/routing/route_constants.dart';
import 'package:golfquiz/view/animations/fade_in_rtl__animation.dart';
import 'package:golfquiz/view/base_pages/base_page.dart';
import 'package:golfquiz/view/components/standard_button__component.dart';
import 'package:golfquiz/view/mixins/basic_page__mixin.dart';
import 'package:golfquiz/view/pages/bottom_navigation/navigation__container.dart';
import 'package:golfquiz/view/pages/misc/hard_coded_data.dart';
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
      ],
    );
  }

  void setCurrentGameProvider() {
    Player currentUser =
        Provider.of<UserProvider>(context, listen: false).getUser;

    Game game = Game.init();

    game.playerStatus.add(
      PlayerStatus(
        gamePlayer: GamePlayer(player: currentUser, gameProgress: 0, score: 0),
        gameRound: [],
      ),
    );

    Provider.of<CurrentGameProvider>(context, listen: false).setGame(game);
  }

  @override
  String title() => appLocale().games__title;
}
