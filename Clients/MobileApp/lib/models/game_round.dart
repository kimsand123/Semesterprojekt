class GameRound {
  double timeSpent;
  int score;

  GameRound({
    this.timeSpent,
    this.score,
  });

  factory GameRound.fromJson(Map<String, dynamic> json) => GameRound(
        timeSpent: double.parse(json["time_spent"]),
        score: json["score"],
      );

  Map<String, dynamic> toJson() => {
        "time_spent": timeSpent,
        "score": score,
      };
}
