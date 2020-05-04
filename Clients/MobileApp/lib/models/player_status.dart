import 'package:golfquiz_dtu/models/game_player.dart';
import 'package:golfquiz_dtu/models/game_round.dart';

class PlayerStatus {
  GamePlayer gamePlayer;
  List<GameRound> gameRound;

  PlayerStatus({
    this.gamePlayer,
    this.gameRound,
  });

  factory PlayerStatus.fromJson(Map<String, dynamic> json) => PlayerStatus(
        gamePlayer: GamePlayer.fromJson(json["game_player"]),
        gameRound: List<GameRound>.from(
            json["game_round"].map((x) => GameRound.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "game_player": gamePlayer.toJson(),
        "game_round": List<dynamic>.from(gameRound.map((x) => x.toJson())),
      };
}
