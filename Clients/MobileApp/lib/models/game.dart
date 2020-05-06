import 'package:golfquiz_dtu/misc/constants.dart';
import 'package:golfquiz_dtu/models/player_status.dart';
import 'package:golfquiz_dtu/models/question.dart';

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
      if (status.gamePlayer.gameProgress == maxHoles) {
        return false;
      }
    }
    return true;
  }

  factory Game.fromJson(Map<String, dynamic> json) {
    List<Question> questions = List<Question>.from(json["questions"].map((x) {
      return Question.fromJson(x);
    }));

    if (questions.length < 18) {
      int numberOfQuestionsToAdd = 18 - questions.length;
      for (int i = 0; i < numberOfQuestionsToAdd; i++) {
        questions.add(
          Question(
            questionText: "Backup question, because question-list is too short",
            correctAnswer: 3,
            answer1: "Answer 1",
            answer2: "Answer 2",
            answer3: "Answer 3 (correct)",
          ),
        );
      }
    }

    return Game(
      id: json["id"],
      matchName: json["match_name"],
      questionDuration: double.parse(json["question_duration"]),
      questions: questions,
      playerStatus: List<PlayerStatus>.from(json["player_status"].map((x) {
        return PlayerStatus.fromJson(x);
      })),
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

  String toString() {
    String returnToString;

    returnToString += "Game: id : " + this.id.toString() + "\n";
    returnToString += "match_name : " + this.matchName + "\n";
    returnToString +=
        "question_duration : " + this.questionDuration.toString() + "\n";
    returnToString += "questions : " + this.questions.toString() + "\n";
    returnToString += "player_status : " + this.playerStatus.toString() + "\n";

    return returnToString;
  }
}
