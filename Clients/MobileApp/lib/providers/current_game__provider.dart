import 'package:flutter/widgets.dart';
import 'package:golfquiz/models/game.dart';
import 'package:golfquiz/models/game_player.dart';
import 'package:golfquiz/models/game_round.dart';
import 'package:golfquiz/models/player_status.dart';
import 'package:golfquiz/models/player.dart';

class CurrentGameProvider extends ChangeNotifier {
  Game _game = Game();

  Game getGame() => _game;

  void setGame(Game game) {
    _game = game;
    notifyListeners();
  }

  void addGameRound(
      PlayerStatus playerStatus, int progress, double timeSpent, int score) {
    List<PlayerStatus> playerStatusList = this._game.playerStatus;

    for (var status in playerStatusList) {
      if (status.gamePlayer.player.id == playerStatus.gamePlayer.player.id) {
        status.gameRound.add(GameRound(score: score, timeSpent: timeSpent));
      }
    }
    notifyListeners();
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
  }

  void removePlayer(Player player) {
    List<PlayerStatus> listOfPlayerStatus = this._game.playerStatus;

    for (PlayerStatus status in listOfPlayerStatus) {
      if (player.id == status.gamePlayer.player.id) {
        this._game.playerStatus.remove(status);
      }
    }
  }

  /*
  Player _findPlayerinGameUserList(Player player, List<Player> userList) {
    Player foundUser;

    for (Player userInList in userList) {
      if (player.id == userInList.id) {
        foundUser = userInList;
        break;
      }
    }
    return foundUser;
  }
  */
}
