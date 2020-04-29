import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:golfquiz/localization/appLocalizations.dart';
import 'package:golfquiz/misc/constants.dart';
import 'package:golfquiz/models/game.dart';
import 'package:golfquiz/models/user.dart';
import 'package:golfquiz/providers/current_game__provider.dart';
import 'package:golfquiz/view/components/popup__component.dart';
import 'package:provider/provider.dart';

void addPlayerToGame(User addPlayer, BuildContext context) {
  Game game =
      Provider.of<CurrentGameProvider>(context, listen: false).getGame();

  List<User> gameUsers = game.gameUsers.keys.toList();

  bool chosenPlayerIsInList = isPlayerinGameUserList(addPlayer, gameUsers);

  bool isTwoPlayerMatch = game.gameType == GameType.two_player_match;
  bool isMaxTwoPlayerReached = gameUsers.length == maxPlayersTwoPlayerMatch;
  bool isGroupMatch = game.gameType == GameType.group_match;
  bool isMaxGroupReached = gameUsers.length == maxPlayersGroupMatch;

  if (chosenPlayerIsInList) {
    // Player already in match
    Provider.of<CurrentGameProvider>(context, listen: false)
        .removePlayer(addPlayer);
  } else if (isTwoPlayerMatch && isMaxTwoPlayerReached) {
    _showTwoPlayerMaxPopup(context, gameUsers);
  } else if (isGroupMatch && isMaxGroupReached) {
    _showGroupMaxPopup(context, gameUsers);
  } else {
    // Add player
    Provider.of<CurrentGameProvider>(context, listen: false)
        .addPlayer(addPlayer);
  }
}

void addAllPlayersFromListToGame(List<User> users, BuildContext context) {
  Game game =
      Provider.of<CurrentGameProvider>(context, listen: false).getGame();

  List<User> gameUsers = game.gameUsers.keys.toList();

  bool isTwoPlayerMatch = game.gameType == GameType.two_player_match;
  bool isGroupMatch = game.gameType == GameType.group_match;

  for (User addPlayer in users) {
    bool isMaxTwoPlayerReached = gameUsers.length == maxPlayersTwoPlayerMatch;
    bool isMaxGroupReached = gameUsers.length == maxPlayersGroupMatch;

    bool chosenPlayerIsInList = isPlayerinGameUserList(addPlayer, gameUsers);

    if (isTwoPlayerMatch && isMaxTwoPlayerReached) {
      // Max reached for a group, show popup and break for-each
      _showTwoPlayerMaxPopup(context, gameUsers);
      debugPrint(
          'trying to add ${addPlayer.firstName}, and max two players is reached');

      break;
    } else if (isGroupMatch && isMaxGroupReached) {
      // Max reached for a group, show popup and break for-each
      _showGroupMaxPopup(context, gameUsers);
      debugPrint(
          'trying to add ${addPlayer.firstName}, and max group players is reached');

      break;
    } else if (!chosenPlayerIsInList) {
      // Player not already in match
      // Add player
      gameUsers.add(addPlayer);
    } else {}
  }

  // Add all players
  Provider.of<CurrentGameProvider>(context, listen: false)
      .addMultiplePlayers(gameUsers);
}

bool isMaxPlayersInvited(Game game, List<User> gamePlayers) {
  if (game.gameType == GameType.two_player_match) {
    // Do not show icon if gametype is two-player match, and list length is maxPlayersTwoPlayerMatch
    return (gamePlayers.length == maxPlayersTwoPlayerMatch);
  } else {
    // Do not show icon if gametype is group-player match, and list length is maxPlayersGroupMatch
    return (gamePlayers.length == maxPlayersGroupMatch);
  }
}

bool shouldShowInviteButton(
    bool isCurrentPlayer, bool isMaxPlayersReached, isPlayerInList) {
  if (isCurrentPlayer) {
    return false;
  } else if (!isMaxPlayersReached) {
    return true;
  } else {
    return !isMaxPlayersReached || isPlayerInList;
  }
}

bool isPlayerinGameUserList(User player, List<User> userList) {
  bool isInTheList = false;

  for (User userInList in userList) {
    if (player.id == userInList.id) {
      isInTheList = true;
      break;
    }
  }
  return isInTheList;
}

String _playersToAStringList(List<User> players) {
  String returnString = '';

  players.forEach((player) {
    returnString += '\n- ${player.firstName}';
  });

  return returnString;
}

void _showTwoPlayerMaxPopup(BuildContext context, gameUsers) {
  // Two-player max
  showPopupDialog(
    context,
    AppLocalization.of(context)
        .invite_helper__max_players(maxPlayersTwoPlayerMatch),
    AppLocalization.of(context)
        .invite_helper__two_player__dialog_text(gameUsers[1].name),
    {
      Text(AppLocalization.of(context).ok,
          style: Theme.of(context)
              .textTheme
              .button
              .copyWith(color: Colors.black)): () {},
    },
  );
}

void _showGroupMaxPopup(BuildContext context, List<User> gameUsers) {
  // Group max
  showPopupDialog(
    context,
    AppLocalization.of(context)
        .invite_helper__max_players(maxPlayersGroupMatch),
    AppLocalization.of(context)
        .invite_helper__group__dialog_text(_playersToAStringList(gameUsers)),
    {
      Text(AppLocalization.of(context).ok,
          style: Theme.of(context)
              .textTheme
              .button
              .copyWith(color: Colors.black)): () {},
    },
  );
}
