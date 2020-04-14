import 'package:flutter/widgets.dart';
import 'package:golfquiz/models/user.dart';
import 'package:golfquiz/network/remote_helper.dart';

class GlobalPlayerProvider extends ChangeNotifier {
  List<User> _globalPlayers = [];

  List<User> get getSearchedGlobalPlayers => _globalPlayers;

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
