import 'package:golfquiz/misc/constants.dart';
import 'package:golfquiz/models/player_status.dart';
import 'package:golfquiz/models/question.dart';

class Game {
  int id;
  String matchName;
  double questionDuration;
  List<Question> questions;
  List<PlayerStatus> playerStatus;
  GameType gameType = GameType.two_player_match;

  Game({
    this.id,
    this.matchName,
    this.questionDuration,
    this.questions,
    this.playerStatus,
  });

  Game.init({
    this.matchName = "",
    this.questionDuration = 0.0,
    this.questions,
    this.playerStatus,
  });

  bool get isActive {
    for (PlayerStatus status in this.playerStatus) {
      if (status.gamePlayer.gameProgress != maxHoles) {
        return false;
      }
    }
    return true;
  }

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json["id"],
      matchName: json["match_name"],
      questionDuration: double.parse(json["question_duration"]),
      questions: List<Question>.from(
          json["questions"].map((x) => Question.fromJson(x))),
      playerStatus: List<PlayerStatus>.from(
          json["player_status"].map((x) => PlayerStatus.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "match_name": matchName,
        "question_duration": questionDuration,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
        "player_status":
            List<dynamic>.from(playerStatus.map((x) => x.toJson())),
      };
}
