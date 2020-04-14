import 'package:flutter/material.dart';
import 'package:golfquiz/misc/constants.dart';
import 'package:golfquiz/models/game.dart';
import 'package:golfquiz/models/game_user_status.dart';
import 'package:golfquiz/models/user.dart';
import 'package:golfquiz/providers/current_game__provider.dart';
import 'package:golfquiz/providers/user__provider.dart';
import 'package:golfquiz/routing/route_constants.dart';
import 'package:golfquiz/view/animations/fade_in_rtl__animation.dart';
import 'package:golfquiz/view/base_pages/base_page.dart';
import 'package:golfquiz/view/components/active_games_card__component.dart';
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
                text: appLocale().games__start_new_match__solo_match,
                width: screenWidth() - 35,
                onPressed: () {
                  setGameProvider(GameType.solo_match);

                  Navigator.pushNamed(context, soloCreateRoute);
                },
              ),
                delay: 0.2,
            ),
            SizedBox(height: 8.0),
            FadeInRTLAnimation(
              child: StandardButtonComponent(
                text: appLocale().games__start_new_match__two_player_match,
                width: screenWidth() - 35,
                onPressed: () {
                  setGameProvider(GameType.two_player_match);

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

  void setGameProvider(GameType gameType) {
    User currentUser =
        Provider.of<UserProvider>(context, listen: false).getUser;

    Game game;

    switch (gameType) {
      //TODO: Should not be hardcoded data, gather data
      case GameType.solo_match:
        {
          game = HardCodedData.getHardCodedGameSolo();
          break;
        }
      case GameType.two_player_match:
        {
          game = HardCodedData.getHardCodedGameSolo();
          break;
        }
      case GameType.group_match:
        {
          game = HardCodedData.getHardCodedGameGroup();
          break;
        }
      case GameType.tournaments:
        {
          game = HardCodedData.getHardCodedGameSolo();
          break;
        }
    }

    game.gameType = gameType;
    game.gameUsers = {currentUser: GameUserStatus.init()};

    Provider.of<CurrentGameProvider>(context, listen: false).setGame(game);
  }

  @override
  String title() => appLocale().games__title;
}
