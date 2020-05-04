import 'package:golfquiz_dtu/misc/constants.dart';
import 'package:golfquiz_dtu/models/game.dart';

List<Game> gatherActiveGames(List<Game> gameList) {
  //Null safe
  if (gameList == null || gameList.isEmpty) {
    return gameList;
  }

  List<Game> returnList = [];

  gameList.forEach((game) {
    // Exclude games that are not active
    if (game.isActive) {
      returnList.add(game);
    }
  });
  return returnList;
}

List<Game> gatherInactiveGames(List<Game> gameList) {
  //Null safe
  if (gameList == null || gameList.isEmpty) {
    return gameList;
  }

  List<Game> returnList = [];

  gameList.forEach((game) {
    // Exclude games that are active
    if (!game.isActive) {
      returnList.add(game);
    }
  });
  return returnList;
}

List<Game> gatherGamesWithCorrectType(
    List<Game> gameList, GameType targetType) {
  //Null safe
  if (gameList == null || gameList.isEmpty) {
    return gameList;
  }

  List<Game> returnList = [];

  gameList.forEach((game) {
    // Exclude games that do not have the correct game type
    if (game.gameType == targetType) {
      returnList.add(game);
    }
  });
  return returnList;
}

int sortGamesListAfterActive(Game a, Game b) {
  if (a.isActive && b.isActive) {
    return 0;
  } else if (a.isActive) {
    return -1;
  } else {
    return 1;
  }
}
