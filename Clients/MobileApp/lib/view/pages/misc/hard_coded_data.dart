import 'package:golfquiz/misc/constants.dart';
import 'package:golfquiz/models/club.dart';
import 'package:golfquiz/models/game.dart';
import 'package:golfquiz/models/game_history.dart';
import 'package:golfquiz/models/game_user_status.dart';
import 'package:golfquiz/models/group.dart';
import 'package:golfquiz/models/question.dart';
import 'package:golfquiz/models/rule.dart';
import 'package:golfquiz/models/tournament.dart';
import 'package:golfquiz/models/user.dart';

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

  static List<User> getHardCodedFriends() {
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

  static List<Group> getHardCodedGroups(User currentUser) {
    return [
      Group(id: 0, name: "Galf 4 fun", groupAdmins: [
        dummyUser(0),
      ], groupMembers: [
        dummyUser(0),
        dummyUser(1),
        dummyUser(2),
        dummyUser(3),
        currentUser,
      ]),
      Group(id: 1, name: "GoGolf", groupAdmins: [
        dummyUser(4),
        currentUser,
      ], groupMembers: [
        dummyUser(4),
        dummyUser(5),
        dummyUser(6),
        dummyUser(7),
        currentUser,
      ]),
    ];
  }

  static Club getHardCodedClub(User currentUser) {
    return Club(
      name: 'Klub Birkerød',
      clubId: 20,
      clubAdmins: [
        dummyUser(7),
        currentUser,
      ],
      clubMembers: [
        dummyUser(7),
        dummyUser(8),
        dummyUser(9),
        dummyUser(10),
        dummyUser(11),
        dummyUser(12),
        currentUser,
      ],
    );
  }

  static List<Game> getHardCodedGames(User currentUser) {
    return [
      //Solo
      Game(
        matchName: "Solo match - 09.09.2020",
        questionDuration: 30.0,
        gameType: GameType.solo_match,
        questions: dummyListOfQuestions(),
        gameUsers: {
          currentUser: dummyUserSatus(false),
        },
        isActive: true,
      ),
      Game(
        matchName: "Solo-match - 01.01.2020",
        questionDuration: 30.0,
        gameType: GameType.solo_match,
        questions: dummyListOfQuestions(),
        gameUsers: {
          currentUser: dummyUserSatus(true),
        },
        isActive: false,
      ),
      Game(
        matchName: "Solo match - 10.09.2020",
        questionDuration: 30.0,
        gameType: GameType.solo_match,
        questions: dummyListOfQuestions(),
        gameUsers: {
          currentUser: dummyUserSatus(false),
        },
        isActive: true,
      ),

      //Two player
      Game(
        matchName: "BirkeBoyz match",
        gameType: GameType.two_player_match,
        questionDuration: 30.0,
        questions: dummyListOfQuestions(),
        gameUsers: {
          currentUser: dummyUserSatus(false),
          dummyUser(1): dummyUserSatus(false),
        },
        isActive: true,
        startDateTime: DateTime.parse("2020-01-01 13:27:00"),
        endDateTime: DateTime.parse("2020-06-06 13:27:00"),
      ),
      Game(
        matchName: "Test match",
        gameType: GameType.two_player_match,
        questionDuration: 30.0,
        questions: dummyListOfQuestions(),
        gameUsers: {
          currentUser: dummyUserSatus(true),
          dummyUser(2): dummyUserSatus(false),
        },
        isActive: false,
        startDateTime: DateTime.parse("2020-01-01 13:27:00"),
        endDateTime: DateTime.parse("2020-02-02 13:27:00"),
      ),
      Game(
        matchName: "Mantzius match",
        gameType: GameType.two_player_match,
        questionDuration: 30.0,
        questions: dummyListOfQuestions(),
        gameUsers: {
          currentUser: dummyUserSatus(false),
          dummyUser(3): dummyUserSatus(false),
        },
        isActive: true,
        startDateTime: DateTime.parse("2020-01-01 13:27:00"),
        endDateTime: DateTime.parse("2020-05-05 13:27:00"),
      ),

      //Group
      Game(
        matchName: "BirkeBoyz group match",
        gameType: GameType.group_match,
        questionDuration: 30.0,
        questions: dummyListOfQuestions(),
        gameUsers: {
          currentUser: dummyUserSatus(false),
          dummyUser(1): dummyUserSatus(true),
          dummyUser(2): dummyUserSatus(true),
        },
        isActive: true,
        startDateTime: DateTime.parse("2020-01-01 13:27:00"),
        endDateTime: DateTime.parse("2020-06-06 13:27:00"),
      ),
      Game(
        matchName: "Test match",
        gameType: GameType.group_match,
        questionDuration: 30.0,
        questions: dummyListOfQuestions(),
        gameUsers: {
          currentUser: dummyUserSatus(false),
          dummyUser(4): dummyUserSatus(false),
        },
        isActive: true,
        startDateTime: DateTime.parse("2020-01-01 13:27:00"),
        endDateTime: DateTime.parse("2020-08-08 13:27:00"),
      ),
      Game(
        matchName: "Test match 2",
        gameType: GameType.group_match,
        questionDuration: 30.0,
        questions: dummyListOfQuestions(),
        gameUsers: {
          currentUser: dummyUserSatus(true),
          dummyUser(0): dummyUserSatus(false),
          dummyUser(4): dummyUserSatus(false),
        },
        isActive: false,
        startDateTime: DateTime.parse("2020-01-01 13:27:00"),
        endDateTime: DateTime.parse("2020-05-05 13:27:00"),
      ),

      //Tournaments
      Game(
        matchName: "Roskilde Tournament",
        gameType: GameType.tournaments,
        questionDuration: 30.0,
        questions: dummyListOfQuestions(),
        gameUsers: {
          currentUser: dummyUserSatus(false),
          dummyUser(4): dummyUserSatus(false),
          dummyUser(0): dummyUserSatus(false),
        },
        isActive: true,
        startDateTime: DateTime.parse("2020-01-01 13:27:00"),
        endDateTime: DateTime.parse("2020-06-06 13:27:00"),
      ),
      Game(
        matchName: "Hillerød Tournament",
        gameType: GameType.tournaments,
        questionDuration: 30.0,
        questions: dummyListOfQuestions(),
        gameUsers: {
          currentUser: dummyUserSatus(true),
          dummyUser(1): dummyUserSatus(true),
          dummyUser(2): dummyUserSatus(true),
        },
        isActive: false,
        startDateTime: DateTime.parse("2020-01-01 13:27:00"),
        endDateTime: DateTime.parse("2020-02-02 13:27:00"),
      ),
      Game(
        matchName: "Birkerød Tournament",
        gameType: GameType.tournaments,
        questionDuration: 30.0,
        questions: dummyListOfQuestions(),
        gameUsers: {
          currentUser: dummyUserSatus(false),
          dummyUser(3): dummyUserSatus(false),
          dummyUser(4): dummyUserSatus(false),
        },
        isActive: true,
        startDateTime: DateTime.parse("2020-01-01 13:27:00"),
        endDateTime: DateTime.parse("2020-05-05 13:27:00"),
      ),
    ];
  }

  static List<User> getHardCodedSearchData() {
    List<User> userList = [];

    for (int i = 0; i <= 25; i++) {
      userList.add(dummyUser(i));
    }
    return userList;
  }

  static Tournament getHardCodedTournament() {
    return Tournament(
      title: 'Test tournament',
      description: 'This is a test tournament',
      game: Game(
        matchName: "Birkerød Tournament",
        gameType: GameType.tournaments,
        questionDuration: 30.0,
        questions: dummyListOfQuestions(),
        gameUsers: {
          dummyUser(20): dummyUserSatus(false),
          dummyUser(15): dummyUserSatus(false),
          dummyUser(16): dummyUserSatus(false),
          dummyUser(2): dummyUserSatus(false),
        },
        isActive: true,
        startDateTime: DateTime.parse("2020-01-01 13:27:00"),
        endDateTime: DateTime.parse("2020-05-05 13:27:00"),
      ),
    );
  }

  static List<Tournament> getHardCodedTournaments() {
    return [
      Tournament(
        title: "Roskilde Tournament",
        description: "Some description",
        game: Game(
          matchName: "Roskilde Tournament",
          gameType: GameType.tournaments,
          questionDuration: 30.0,
          questions: dummyListOfQuestions(),
          gameUsers: {
            dummyUser(4): dummyUserSatus(false),
            dummyUser(0): dummyUserSatus(false),
          },
          isActive: true,
          startDateTime: DateTime.parse("2020-01-01 13:27:00"),
          endDateTime: DateTime.parse("2020-06-06 13:27:00"),
        ),
      ),
      Tournament(
        title: "Hillerød Tournament",
        description: "Some description",
        game: Game(
          matchName: "Hillerød Tournament",
          gameType: GameType.tournaments,
          questionDuration: 30.0,
          questions: dummyListOfQuestions(),
          gameUsers: {
            dummyUser(1): dummyUserSatus(true),
            dummyUser(2): dummyUserSatus(true),
          },
          isActive: false,
          startDateTime: DateTime.parse("2020-01-01 13:27:00"),
          endDateTime: DateTime.parse("2020-03-26 18:42:00"),
        ),
      ),
      Tournament(
        title: "Birkerød Tournament",
        description: "Some description",
        game: Game(
          matchName: "Birkerød Tournament",
          gameType: GameType.tournaments,
          questionDuration: 30.0,
          questions: dummyListOfQuestions(),
          gameUsers: {
            dummyUser(3): dummyUserSatus(false),
            dummyUser(4): dummyUserSatus(false),
          },
          isActive: true,
          startDateTime: DateTime.parse("2020-01-01 13:27:00"),
          endDateTime: DateTime.parse("2020-05-05 13:27:00"),
        ),
      ),
      Tournament(
        title: "Test Tournament",
        description: "Some description",
        game: Game(
          matchName: "Test Tournament",
          gameType: GameType.tournaments,
          questionDuration: 30.0,
          questions: dummyListOfQuestions(),
          gameUsers: {
            dummyUser(3): dummyUserSatus(false),
            dummyUser(4): dummyUserSatus(false),
          },
          isActive: true,
          startDateTime: DateTime.parse("2020-05-05 13:27:00"),
          endDateTime: DateTime.parse("2020-08-25 13:27:00"),
        ),
      )
    ];
  }

  static GameUserStatus dummyUserSatus(bool gameOver) {
    if (gameOver) {
      return GameUserStatus(
        gameProgress: 18,
        score: 4,
        gameHistory: [
          GameHistory(progress: 1, timeSpent: 10, score: 4),
          GameHistory(progress: 2, timeSpent: 13, score: 4),
          GameHistory(progress: 3, timeSpent: 25, score: 4),
          GameHistory(progress: 4, timeSpent: 7, score: 4),
          GameHistory(progress: 5, timeSpent: 10, score: 4),
          GameHistory(progress: 6, timeSpent: 13, score: 4),
          GameHistory(progress: 7, timeSpent: 25, score: 4),
          GameHistory(progress: 8, timeSpent: 7, score: 4),
          GameHistory(progress: 9, timeSpent: 10, score: 4),
          GameHistory(progress: 10, timeSpent: 13, score: 4),
          GameHistory(progress: 11, timeSpent: 25, score: 4),
          GameHistory(progress: 12, timeSpent: 7, score: 4),
          GameHistory(progress: 13, timeSpent: 10, score: 4),
          GameHistory(progress: 14, timeSpent: 13, score: 4),
          GameHistory(progress: 15, timeSpent: 25, score: 4),
          GameHistory(progress: 16, timeSpent: 7, score: 4),
          GameHistory(progress: 17, timeSpent: 25, score: 4),
          GameHistory(progress: 18, timeSpent: 7, score: 4),
        ],
      );
    } else {
      return GameUserStatus(
        gameProgress: 1,
        score: 10,
        gameHistory: [
          GameHistory(progress: 1, timeSpent: 10, handicap: 3.2, score: 4),
        ],
      );
    }
  }

  static Question dummyQuestion(int id) {
    return Question(
        rule: Rule(id: '1.3b', title: 'Rule title', description: 'Rule description'),
        question: "During stroke play, your ball ends in a bunker. Before you play your ball, you feel the sand with your hand. What is the penalty. Question ${id+1}",
        answers: [
            "No penalty",
            "2-stroke penalty",
            "1-stroke penalty",
          ],
        correctAnswer: 2);
  }

  static List<Question> dummyListOfQuestions() {
    List<Question> questions = [];

    for (int i = 0; i <= 18; i++) {
      questions.add(dummyQuestion(i));
    }
    return questions;
  }

  static User dummyUser(int number) {
    switch (number) {
      case 0:
        return User.publicUser(
          id: 1,
          name: 'Torben',
          handicap: 10.0,
          bufferZone: [0, 22],
        );
      case 1:
        return User.publicUser(
          id: 2,
          name: 'Adam',
          handicap: 10.0,
          bufferZone: [0, 22],
        );
      case 2:
        return User.publicUser(
          id: 3,
          name: 'Josefine',
          handicap: 40.0,
          bufferZone: [0, 22],
        );
      case 3:
        return User.publicUser(
          id: 4,
          name: 'Sofie',
          handicap: 30.0,
          bufferZone: [0, 22],
        );
      case 4:
        return User.publicUser(
          id: 5,
          name: 'Janus',
          handicap: 20.0,
          bufferZone: [0, 22],
        );
      case 5:
        return User.publicUser(
          id: 6,
          name: 'Karsten',
          handicap: 10.0,
          bufferZone: [0, 22],
        );
      case 6:
        return User.publicUser(
          id: 7,
          name: 'Mads',
          handicap: 40.0,
          bufferZone: [0, 22],
        );
      case 7:
        return User.publicUser(
          id: 8,
          name: 'Tim',
          handicap: 30.0,
          bufferZone: [0, 22],
        );
      case 8:
        return User.publicUser(
          id: 9,
          name: 'Niels',
          handicap: 20.0,
          bufferZone: [0, 22],
        );
      case 9:
        return User.publicUser(
          id: 10,
          name: 'Lena',
          handicap: 50.0,
          bufferZone: [0, 22],
        );
      case 10:
        return User.publicUser(
          id: 11,
          name: 'Edith',
          handicap: 70.0,
          bufferZone: [0, 22],
        );
      case 11:
        return User.publicUser(
          id: 12,
          name: 'Yvonne',
          handicap: 12.0,
          bufferZone: [0, 22],
        );
      case 12:
        return User.publicUser(
          id: 13,
          name: 'Dorit',
          handicap: 13.0,
          bufferZone: [0, 22],
        );
      case 13:
        return User.publicUser(
          id: 14,
          name: 'Jon',
          handicap: 7.0,
          bufferZone: [0, 22],
        );
      case 14:
        return User.publicUser(
          id: 15,
          name: 'Bendt',
          handicap: 54.0,
          bufferZone: [0, 22],
        );
      case 15:
        return User.publicUser(
          id: 16,
          name: 'Benny',
          handicap: 10.0,
          bufferZone: [0, 22],
        );
      case 16:
        return User.publicUser(
          id: 17,
          name: 'Carl',
          handicap: 40.0,
          bufferZone: [0, 22],
        );
      case 17:
        return User.publicUser(
          id: 18,
          name: 'Gunnar',
          handicap: 30.0,
          bufferZone: [0, 22],
        );
      case 18:
        return User.publicUser(
          id: 19,
          name: 'Eskild',
          handicap: 20.0,
          bufferZone: [0, 22],
        );
      case 19:
        return User.publicUser(
          id: 20,
          name: 'Mie',
          handicap: 10.0,
          bufferZone: [0, 22],
        );
      case 20:
        return User.publicUser(
          id: 21,
          name: 'Jytte',
          handicap: 40.0,
          bufferZone: [0, 22],
        );
      case 21:
        return User.publicUser(
          id: 22,
          name: 'Amalie',
          handicap: 30.0,
          bufferZone: [0, 22],
        );
      case 22:
        return User.publicUser(
          id: 23,
          name: 'Sara',
          handicap: 20.0,
          bufferZone: [0, 22],
        );
      case 23:
        return User.publicUser(
          id: 24,
          name: 'Regitze',
          handicap: 20.0,
          bufferZone: [0, 22],
        );
      case 24:
        return User.publicUser(
          id: 25,
          name: 'Nikoline',
          handicap: 20.0,
          bufferZone: [0, 22],
        );
      case 25:
        return User.publicUser(
          id: 26,
          name: 'Olivia',
          handicap: 20.0,
          bufferZone: [0, 22],
        );
      default:
        return User.publicUser(
          id: 600,
          name: 'Default-user',
          handicap: 20.0,
          bufferZone: [0, 22],
        );
    }
  }
}
