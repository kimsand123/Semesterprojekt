import 'package:flutter/widgets.dart';
import 'package:golfquiz_dtu/models/game.dart';
import 'package:golfquiz_dtu/models/game_player.dart';
import 'package:golfquiz_dtu/models/player_status.dart';
import 'package:golfquiz_dtu/models/player.dart';
import 'package:golfquiz_dtu/network/remote_helper.dart';
import 'package:golfquiz_dtu/providers/game_list__provider.dart';
import 'package:provider/provider.dart';

import 'me__provider.dart';

class CurrentGameProvider extends ChangeNotifier {
  Game _game = Game();

  Game getGame() => _game;

  void setGame(Game game) {
    _game = game;
    notifyListeners();
  }

  Future<void> updateCurrentGameFromRemote(BuildContext context) async {
    if (this._game.id != null) {
      Player player = Provider.of<MeProvider>(context, listen: false).getPlayer;
      await RemoteHelper()
          .updateSingleGameInGameListProvider(context, player, this._game.id);

      this._game = Provider.of<GameListProvider>(context, listen: false)
          .findGameWithId(this._game.id);

      return Future.value(true);
    }
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
