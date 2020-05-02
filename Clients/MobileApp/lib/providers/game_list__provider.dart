import 'package:flutter/widgets.dart';
import 'package:golfquiz/models/game.dart';

class GameListProvider extends ChangeNotifier {
  List<Game> _gameList = [];

  List<Game> getGameList() => _gameList;

  /// **setGameList():**
  /// Sets a new game object, should not be used for other than first logon.
  ///
  void setGameList(List<Game> games) {
    this._gameList = games ?? [];

    notifyListeners();
  }

  /// **removeGameList():**
  /// Removes the list object, should not be used for other than logout.
  ///
  void removeGameList() {
    this._gameList = [];

    notifyListeners();
  }

  /// **addGame():**
  /// Add game to game-list
  ///
  void addGame(Game gameToAdd) {
    // Find if game already exists
    bool gameAlreadyExists = isGameAlreadyInGameList(gameToAdd);

    if (!gameAlreadyExists) {
      // Add game to list
      this._gameList.add(gameToAdd);
    } else {
      // Exchange the already existing game
      Game game = findGameWithId(gameToAdd.id);
      int index = this._gameList.indexOf(game);
      this._gameList[index] = gameToAdd;
    }

    notifyListeners();
  }

  /// **removeGame():**
  /// Removes a game from the list
  ///
  void removeGame(Game gameToDelete) {
    List<Game> gameList = _removeGameFromList(gameToDelete, this._gameList);

    // Override the gameList
    this._gameList = gameList;

    notifyListeners();
  }

  /// **isGameAlreadyInGameList():**
  /// Returns true if game already exits.
  ///
  bool isGameAlreadyInGameList(Game gameToFind) {
    for (Game game in this._gameList) {
      if (gameToFind.id == game.id) {
        return true;
      }
    }

    return false;
  }

  /// **findGameWithId():**
  /// Gets a game from its id, and returns it.
  ///
  Game findGameWithId(int gameId) {
    Game returnGame = Game();

    for (Game game in this._gameList) {
      if (game.id == gameId) {
        return game;
      }
    }
    return returnGame;
  }

  /// **_removeGameFromList():**
  /// Removes the game from the list and returns the list.
  ///
  /// The game.id is used to find the game.
  ///
  List<Game> _removeGameFromList(Game gameToRemove, List<Game> gameList) {
    List<Game> returnList = [];

    for (Game game in gameList) {
      if (game.id != gameToRemove.id) {
        returnList.add(game);
      }
    }
    return returnList;
  }
}
