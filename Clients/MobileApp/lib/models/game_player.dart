import 'package:golfquiz_dtu/models/player.dart';

class GamePlayer {
  Player player;
  int gameProgress;
  int score;

  GamePlayer({
    this.player,
    this.gameProgress,
    this.score,
  });

  factory GamePlayer.fromJson(Map<String, dynamic> json) => GamePlayer(
        player: Player.fromJson(json["player"]),
        gameProgress: json["game_progress"],
        score: json["score"],
      );

  Map<String, dynamic> toJson() => {
        "player": player.toJson(),
        "game_progress": gameProgress,
        "score": score,
      };
}
