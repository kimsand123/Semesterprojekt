import 'package:flutter/widgets.dart';
import 'package:golfquiz/models/player.dart';
import 'package:golfquiz/network/remote_helper.dart';

class GlobalPlayerProvider extends ChangeNotifier {
  List<Player> _globalPlayers = [];

  List<Player> get getSearchedGlobalPlayers => _globalPlayers;

  void resetGlobalPlayers() {
    if (this._globalPlayers.isNotEmpty) {
      _globalPlayers = [];
    }
    notifyListeners();
  }

  Future searchInList(String searchPattern) async {
    return RemoteHelper().searchForUsers(searchPattern).then((userList) {
      this._globalPlayers = userList;
      notifyListeners();
    });
  }
}
