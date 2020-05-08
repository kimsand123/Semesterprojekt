import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:golfquiz_dtu/localization/appLocalizations.dart';
import 'package:golfquiz_dtu/misc/constants.dart';
import 'package:golfquiz_dtu/models/game.dart';
import 'package:golfquiz_dtu/models/player.dart';
import 'package:golfquiz_dtu/models/player_status.dart';
import 'package:golfquiz_dtu/providers/current_game__provider.dart';
import 'package:golfquiz_dtu/view/components/popup__component.dart';
import 'package:provider/provider.dart';

void addPlayerToGame(Player addPlayer, BuildContext context) {
  Game game =
      Provider.of<CurrentGameProvider>(context, listen: false).getGame();

  List<PlayerStatus> gamePlayerStatus = game.playerStatus;

  bool chosenPlayerIsInList =
      isPlayerinGamePlayerStatusList(addPlayer, gamePlayerStatus);

  bool isTwoPlayerMatch = game.gameType == GameType.two_player_match;
  bool isMaxTwoPlayerReached =
      gamePlayerStatus.length == maxPlayersTwoPlayerMatch;

  if (chosenPlayerIsInList) {
    // Player already in match
    Provider.of<CurrentGameProvider>(context, listen: false)
        .removePlayer(addPlayer);
  } else if (isTwoPlayerMatch && isMaxTwoPlayerReached) {
    _showTwoPlayerMaxPopup(context, gamePlayerStatus.last.gamePlayer.player);
  } else {
    // Add player
    Provider.of<CurrentGameProvider>(context, listen: false)
        .addPlayer(addPlayer);
  }
}

bool isMaxPlayersInvited(Game game, List<PlayerStatus> gamePlayerStatus) {
  return (gamePlayerStatus.length == maxPlayersTwoPlayerMatch);
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

bool isPlayerinGamePlayerStatusList(
    Player player, List<PlayerStatus> playerStatusList) {
  bool isInTheList = false;

  for (PlayerStatus status in playerStatusList) {
    if (player.id == status.gamePlayer.player.id) {
      isInTheList = true;
      break;
    }
  }
  return isInTheList;
}

void _showTwoPlayerMaxPopup(BuildContext context, Player player) {
  // Two-player max
  showPopupDialog(
    context,
    AppLocalization.of(context)
        .invite_helper__max_players(maxPlayersTwoPlayerMatch),
    AppLocalization.of(context)
        .invite_helper__two_player__dialog_text(player.firstName),
    {
      Text(AppLocalization.of(context).ok,
          style: Theme.of(context)
              .textTheme
              .button
              .copyWith(color: Colors.black)): () {},
    },
  );
}
