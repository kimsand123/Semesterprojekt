import 'package:golfquiz/models/game_history.dart';

class GameUserStatus {
  int gameProgress;
  int score;
  List<GameHistory> gameHistory;

  GameUserStatus({this.gameProgress, this.score, this.gameHistory});

  GameUserStatus.init() {
    this.gameProgress = 1;
    this.score = 0;
    this.gameHistory = [];
  }

  void setGameHistory(progress, timeSpent, score) {
    gameHistory.add(
        GameHistory(progress: progress, score: score, timeSpent: timeSpent));
  }

  @override
  String toString() {
    return 'GameUserStatus{' +
        'gameProgress: $gameProgress,' +
        'score: $score,' +
        'gameHistory: $gameHistory,' +
        ' }';
  }
}
