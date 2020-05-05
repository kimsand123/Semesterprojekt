import 'package:flutter/widgets.dart';
import 'package:golfquiz_dtu/models/game.dart';
import 'package:golfquiz_dtu/models/game_player.dart';
import 'package:golfquiz_dtu/models/player_status.dart';
import 'package:golfquiz_dtu/models/player.dart';
import 'package:golfquiz_dtu/providers/game_list__provider.dart';
import 'package:provider/provider.dart';

class CurrentGameProvider extends ChangeNotifier {
  Game _game = Game();

  Game getGame() => _game;

  void setGame(Game game) {
    _game = game;
    notifyListeners();
  }

  void updateCurrentGameFromRemote(BuildContext context) {
    if (this._game.id != null) {
      this._game = Provider.of<GameListProvider>(context, listen: false)
          .findGameWithId(this._game.id);
    }
  }

  void incrementPlayerProgress(Player player) {
    List<PlayerStatus> playerStatusList = this._game.playerStatus;

    for (var status in playerStatusList) {
      if (status.gamePlayer.player.id == player.id) {
        status.gamePlayer.gameProgress += 1;
      }
    }
    notifyListeners();
  }

  int getPlayerProgress(Player player) {
    for (PlayerStatus status in this._game.playerStatus) {
      if (player.id == status.gamePlayer.player.id) {
        return status.gamePlayer.gameProgress;
      }
    }
    return -1;
  }

  void addPlayer(Player player) {
    List<PlayerStatus> listOfPlayerStatus = this._game.playerStatus;

    bool wasInList = false;

    for (PlayerStatus status in listOfPlayerStatus) {
      if (player.id == status.gamePlayer.player.id) {
        wasInList = true;
      }
    }

    if (!wasInList) {
      this._game.playerStatus.add(PlayerStatus(
          gamePlayer: GamePlayer(player: player, gameProgress: 0, score: 0),
          gameRound: []));
    }

    notifyListeners();
  }

  void removePlayer(Player player) {
    List<PlayerStatus> listOfPlayerStatus = this._game.playerStatus;

    PlayerStatus playerStatusToRemove;

    for (PlayerStatus status in listOfPlayerStatus) {
      if (player.id == status.gamePlayer.player.id) {
        playerStatusToRemove = status;
      }
    }

    if (playerStatusToRemove != null) {
      this._game.playerStatus.remove(playerStatusToRemove);
    }

    notifyListeners();
  }
}
