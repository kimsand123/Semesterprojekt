import 'package:flutter/widgets.dart';
import 'package:golfquiz/models/player.dart';

class PlayerProvider extends ChangeNotifier {
  Player _user = Player();

  Player get getPlayer => _user;

  void setUser(Player newUser) {
    _user = newUser;
    notifyListeners();
  }

  void remove() {
    _user = null;
    notifyListeners();
  }
}
