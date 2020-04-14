import 'package:flutter/widgets.dart';
import 'package:golfquiz/models/game.dart';
import 'package:golfquiz/models/game_user_status.dart';
import 'package:golfquiz/models/user.dart';

class CurrentGameProvider extends ChangeNotifier {
  Game _game = Game();

  Game getGame() => _game;

  void setGame(Game game) {
    _game = game;
    notifyListeners();
  }

  void setGameHistory(
      GameUserStatus userStatus, int progress, int timeSpent, int score) {
    userStatus.setGameHistory(progress, timeSpent, score);
    notifyListeners();
  }

  void incrementPlayerProgress(GameUserStatus userStatus) {
    userStatus.gameProgress += 1;
    notifyListeners();
  }

  void addPlayer(User user) {
    Map gameUsersMap = _game.gameUsers ?? {};

    gameUsersMap.putIfAbsent(user, () => GameUserStatus.init());

    notifyListeners();
  }

  void removePlayer(User user) {
    Map gameUsersMap = _game.gameUsers ?? {};

    User removeUser =
        _findPlayerinGameUserList(user, gameUsersMap.keys.toList());

    gameUsersMap.remove(removeUser);

    notifyListeners();
  }

  void addMultiplePlayers(List<User> users) {
    Map gameUsersMap = _game.gameUsers ?? {};

    users.forEach((user) {
      gameUsersMap.putIfAbsent(user, () => GameUserStatus.init());
    });

    notifyListeners();
  }

  int getPlayerProgress(GameUserStatus userStatus) => userStatus.gameProgress;

  User _findPlayerinGameUserList(User player, List<User> userList) {
    User foundUser;

    for (User userInList in userList) {
      if (player.id == userInList.id) {
        foundUser = userInList;
        break;
      }
    }
    return foundUser;
  }
}
