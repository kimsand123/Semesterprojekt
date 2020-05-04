import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:golfquiz_dtu/misc/constants.dart';
import 'package:golfquiz_dtu/models/game.dart';
import 'package:golfquiz_dtu/providers/game_list__provider.dart';
import 'package:golfquiz_dtu/routing/route_constants.dart';
import 'package:golfquiz_dtu/view/base_pages/base_page.dart';
import 'package:golfquiz_dtu/view/components/game_card__component.dart';
import 'package:golfquiz_dtu/view/mixins/basic_page__mixin.dart';
import 'package:provider/provider.dart';

import 'game_list__helper.dart';

class GameListPage extends BasePage {
  final GameType _gameListType;

  GameListPage({GameType gameListType})
      : this._gameListType = gameListType ?? GameType.two_player_match;

  @override
  _GameListPageState createState() => _GameListPageState();
}

class _GameListPageState extends BasePageState<GameListPage> with BasicPage {
  @override
  String title() {
    if (widget._gameListType == GameType.two_player_match) {
      return appLocale().game_list__two_player_matches;
    } else {
      return '';
    }
  }

  @override
  Widget body() {
    return Container(
      child: Consumer<GameListProvider>(
        builder: (context, provider, child) {
          // Gather the list of games
          List<Game> listOfGames = gatherGamesWithCorrectType(
              provider.getGameList(), widget._gameListType);

          // Sort by active games
          listOfGames.sort((a, b) {
            return sortGamesListAfterActive(a, b);
          });

          // Get number of active games for seperation
          int numberOfActiveGames = gatherActiveGames(listOfGames).length;

          return Container(
            height: contentHeight,
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemCount: listOfGames.length,
              itemBuilder: (BuildContext context, int index) {
                var gameItem = listOfGames[index];

                if (index == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(appLocale().game_list__active_matches),
                      ),
                      itemGenerator(gameItem),
                    ],
                  );
                } else if (index == numberOfActiveGames) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(appLocale().game_list__inactive_matches),
                      ),
                      itemGenerator(gameItem),
                    ],
                  );
                } else {
                  return itemGenerator(gameItem);
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget itemGenerator(Game gameItem) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
      child: GameCardComponent(
        title: gameItem.matchName,
        subTitle: generateSubtitle(gameItem),
        highscorePlace: 1,
        onPressed: () {
          Navigator.pushNamed(context, singleGameRoute, arguments: gameItem);
        },
      ),
    );
  }

  String generateSubtitle(Game game) {
    if (game.isActive) {
      return appLocale().game_list__your_turn;
    } else {
      //var enddate = DateFormat.yMMMd().format(game.endDateTime);
      return appLocale().game_list__date_ended_at("enddate");
    }
  }

  String _timeLeftSubTitle(DateTime startDateTime, DateTime endDateTime) {
    // Calculate days, hours, minutes and seconds left
    int daysLeft = startDateTime.difference(endDateTime).inDays;
    int hoursLeft = startDateTime.difference(endDateTime).inHours;
    int minutesLeft = startDateTime.difference(endDateTime).inMinutes;
    int secondsLeft = startDateTime.difference(endDateTime).inSeconds;

    // Expression to determine if it is the same day
    bool sameDay = (daysLeft == 0 && startDateTime.day == endDateTime.day);

    // Return correct string according to how much time left
    if (sameDay && (hoursLeft == 0) && (minutesLeft == 0)) {
      return appLocale().game_list__seconds_left(secondsLeft);
    } else if (sameDay && (hoursLeft == 0)) {
      return appLocale().game_list__minutes_left(minutesLeft);
    } else if (sameDay) {
      return appLocale().game_list__hours_left(hoursLeft);
    } else {
      return appLocale().game_list__days_left(daysLeft);
    }
  }
}
