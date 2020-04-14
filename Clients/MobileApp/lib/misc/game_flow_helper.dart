import 'package:flutter/material.dart';
import 'package:golfquiz/models/game.dart';
import 'package:golfquiz/models/game_user_status.dart';
import 'package:golfquiz/models/user.dart';
import 'package:golfquiz/providers/user__provider.dart';

class GameFlowHelper {
  static Map<User, GameUserStatus> determineUser(
      UserProvider userProvider, gameProvider) {
    Game game = gameProvider.getGame();
    Map<User, GameUserStatus> gameUserStatus = game.gameUsers ?? {};

    var users = gameUserStatus.keys.toList();

    User playingUser;
    var playingUserInfo;

    users.forEach((user) {
      if (user.email == userProvider.getUser.email) {
        playingUser = user;
      }
    });

    playingUserInfo = game.gameUsers[playingUser];

    return {playingUser: playingUserInfo};
  }

  static Map<User, GameUserStatus> determineUserFromGameUsers(
      users, currentUser, game) {
    User playingUser;
    var playingUserInfo;

    users.forEach((user) {
      if (user.email == currentUser.email) {
        playingUser = user;
      }
    });

    playingUserInfo = game.gameUsers[playingUser];

    return {playingUser: playingUserInfo};
  }

  static Color setPopupTextColor(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    if(theme.brightness == Brightness.dark) {
      return Colors.white;
    } else {
      return Color(0xFF2D2D2D);
    }
  }
}
