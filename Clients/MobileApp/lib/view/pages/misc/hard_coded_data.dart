import 'package:golfquiz/misc/constants.dart';
import 'package:golfquiz/models/game.dart';
import 'package:golfquiz/models/game_player.dart';
import 'package:golfquiz/models/game_round.dart';
import 'package:golfquiz/models/player_status.dart';
import 'package:golfquiz/models/question.dart';
import 'package:golfquiz/models/rule.dart';
import 'package:golfquiz/models/player.dart';

class HardCodedData {
  static getHardCodedGameSolo() {
    return Game(questions: dummyListOfQuestions());
  }

  static getHardCodedGameMultiplayer() {
    return Game(questions: dummyListOfQuestions());
  }

  static getHardCodedGameGroup() {
    return Game(questions: dummyListOfQuestions());
  }

  static List<Player> getHardCodedFriends() {
    return [
      dummyUser(0),
      dummyUser(1),
      dummyUser(2),
      dummyUser(3),
      dummyUser(4),
      dummyUser(5),
      dummyUser(6),
      dummyUser(7),
      dummyUser(8),
      dummyUser(9),
      dummyUser(10),
      dummyUser(11),
      dummyUser(12),
    ];
  }

  static List<Player> getHardCodedSearchData() {
    List<Player> userList = [];

    for (int i = 0; i <= 25; i++) {
      userList.add(dummyUser(i));
    }
    return userList;
  }

  static PlayerStatus dummyUserSatus(bool gameOver) {
    if (gameOver) {
      return PlayerStatus(
        gamePlayer: GamePlayer(gameProgress: 18, score: 20),
        gameRound: [
          GameRound(timeSpent: 10, score: 4),
          GameRound(timeSpent: 13, score: 4),
          GameRound(timeSpent: 25, score: 4),
          GameRound(timeSpent: 7, score: 4),
          GameRound(timeSpent: 10, score: 4),
          GameRound(timeSpent: 13, score: 4),
          GameRound(timeSpent: 25, score: 4),
          GameRound(timeSpent: 7, score: 4),
          GameRound(timeSpent: 10, score: 4),
          GameRound(timeSpent: 13, score: 4),
          GameRound(timeSpent: 25, score: 4),
          GameRound(timeSpent: 7, score: 4),
          GameRound(timeSpent: 10, score: 4),
          GameRound(timeSpent: 13, score: 4),
          GameRound(timeSpent: 25, score: 4),
          GameRound(timeSpent: 7, score: 4),
          GameRound(timeSpent: 25, score: 4),
          GameRound(timeSpent: 7, score: 4),
        ],
      );
    } else {
      return PlayerStatus(
        gamePlayer: GamePlayer(
          gameProgress: 1,
          score: 10,
        ),
        gameRound: [
          GameRound(timeSpent: 10, score: 4),
        ],
      );
    }
  }

  static Question dummyQuestion(int id) {
    return Question(
        questionText:
            "During stroke play, your ball ends in a bunker. Before you play your ball, you feel the sand with your hand. What is the penalty. Question ${id + 1}",
        answer1: "No penalty",
        answer2: "2-stroke penalty",
        answer3: "1-stroke penalty",
        correctAnswer: 2);
  }

  static List<Question> dummyListOfQuestions() {
    List<Question> questions = [];

    for (int i = 0; i <= 18; i++) {
      questions.add(dummyQuestion(i));
    }
    return questions;
  }

  static Player dummyUser(int number) {
    switch (number) {
      case 0:
        return Player(
          id: 101,
          firstName: 'Torben',
        );
      case 1:
        return Player(
          id: 102,
          firstName: 'Adam',
        );
      case 2:
        return Player(
          id: 103,
          firstName: 'Josefine',
        );
      case 3:
        return Player(
          id: 104,
          firstName: 'Sofie',
        );
      case 4:
        return Player(
          id: 105,
          firstName: 'Janus',
        );
      case 5:
        return Player(
          id: 106,
          firstName: 'Karsten',
        );
      case 6:
        return Player(
          id: 107,
          firstName: 'Mads',
        );
      case 7:
        return Player(
          id: 108,
          firstName: 'Tim',
        );
      case 8:
        return Player(
          id: 109,
          firstName: 'Niels',
        );
      case 9:
        return Player(
          id: 110,
          firstName: 'Lena',
        );
      case 10:
        return Player(
          id: 111,
          firstName: 'Edith',
        );
      case 11:
        return Player(
          id: 112,
          firstName: 'Yvonne',
        );
      case 12:
        return Player(
          id: 113,
          firstName: 'Dorit',
        );
      case 13:
        return Player(
          id: 114,
          firstName: 'Jon',
        );
      case 14:
        return Player(
          id: 115,
          firstName: 'Bendt',
        );
      case 15:
        return Player(
          id: 116,
          firstName: 'Benny',
        );
      case 16:
        return Player(
          id: 117,
          firstName: 'Carl',
        );
      case 17:
        return Player(
          id: 118,
          firstName: 'Gunnar',
        );
      case 18:
        return Player(
          id: 119,
          firstName: 'Eskild',
        );
      case 19:
        return Player(
          id: 120,
          firstName: 'Mie',
        );
      case 20:
        return Player(
          id: 121,
          firstName: 'Jytte',
        );
      case 21:
        return Player(
          id: 122,
          firstName: 'Amalie',
        );
      case 22:
        return Player(
          id: 123,
          firstName: 'Sara',
        );
      case 23:
        return Player(
          id: 124,
          firstName: 'Regitze',
        );
      case 24:
        return Player(
          id: 125,
          firstName: 'Nikoline',
        );
      case 25:
        return Player(
          id: 126,
          firstName: 'Olivia',
        );
      default:
        return Player(
          id: 600,
          firstName: 'Default-user',
        );
    }
  }
}
