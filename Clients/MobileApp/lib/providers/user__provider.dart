import 'package:flutter/widgets.dart';
import 'package:golfquiz/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User();

  User get getUser => _user;

  void setUser(User newUser) {
    _user = newUser;
    notifyListeners();
  }

  void remove() {
    _user = null;
    notifyListeners();
  }
}
