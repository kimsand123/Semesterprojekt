import 'package:golfquiz/misc/constants.dart';
import 'package:golfquiz/models/game_user_status.dart';
import 'package:golfquiz/models/question.dart';
import 'package:golfquiz/models/user.dart';

class Game {
  String id;
  List<Question> questions;
  String matchName;
  int rounds;
  int playerResponseTime;
  double questionDuration;
  Map<User, GameUserStatus> gameUsers;
  bool handicap;
  bool isActive;
  GameType gameType;
  DateTime startDateTime;
  DateTime endDateTime;
  bool isItFirstPlayer;

  Game({
    this.id,
    this.questions,
    this.matchName = '',
    this.rounds = 1,
    this.playerResponseTime = 3,
    this.questionDuration,
    this.gameUsers,
    this.handicap = true,
    this.isActive,
    this.gameType,
    this.startDateTime,
    this.endDateTime,
    this.isItFirstPlayer = true,
  });

  @override
  String toString() {
    return "*** ${this.id}:'${this.matchName},' " +
        "rounds: ${this.rounds}, " +
        "playerResponseTime: ${this.playerResponseTime}, " +
        "questionDuration: ${this.questionDuration}, " +
        "users: ${this.gameUsers}, " +
        "handicap: ${this.handicap}, " +
        "isActive: ${this.isActive}, " +
        "gameType: ${this.gameType}, " +
        "questions: ${this.questions}" +
        "startDateTime: ${this.startDateTime}" +
        "endDateTime: ${this.endDateTime}";
  }
}
