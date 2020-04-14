import 'package:golfquiz/models/user.dart';

class GameHistory {
  int progress;
  int timeSpent;
  int score;
  User player;
  double handicap;

  GameHistory({this.progress, this.timeSpent, this.score, this.player, this.handicap});
}