import 'package:flutter/material.dart';
import 'package:golfquiz_dtu/models/game.dart';
import 'package:golfquiz_dtu/models/player_status.dart';

class GameFlowHelper {
  static PlayerStatus determinePlayerStatus(int playerId, Game game) {
    List<PlayerStatus> playerStatus = game.playerStatus ?? [];

    PlayerStatus targetPlayerStatus;

    playerStatus.forEach((pstatus) {
      if (pstatus.gamePlayer.player.id == playerId) {
        targetPlayerStatus = pstatus;
      }
    });

    return targetPlayerStatus;
  }
  /*
  static PlayerStatus determineCurrentPlayerStatus(
      Player currentPlayer, Game game) {
    PlayerStatus currentPlayerStatus;

    List<PlayerStatus> playerStatusList = game.playerStatus;

    for (PlayerStatus status in playerStatusList) {
      if (status.gamePlayer.player.id == currentPlayer.id) {
        currentPlayerStatus = status;
      }
    }

    return currentPlayerStatus;
  }
  */

  static Color setPopupTextColor(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    if (theme.brightness == Brightness.dark) {
      return Colors.white;
    } else {
      return Color(0xFF2D2D2D);
    }
  }
}
