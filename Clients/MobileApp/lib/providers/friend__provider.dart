import 'package:flutter/widgets.dart';
import 'package:golfquiz/models/user.dart';

class FriendProvider extends ChangeNotifier {
  List<User> _friendList = [];

  List<User> getFriends() => _friendList;

  /// **setFriendList():**
  /// Sets a new club object, should not be used for other than first logon.
  ///
  void setFriendList(List<User> friends) {
    this._friendList = friends ?? [];

    notifyListeners();
  }

  /// **removeFriends():**
  /// Removes the list object, should not be used for other than logout.
  ///
  void removeFriends() {
    this._friendList = [];

    notifyListeners();
  }

  /// **addFriend():**
  /// Add friend to friend-list
  ///
  void addFriend(User userToAdd) {
    // Find if user already exists
    bool userAlreadyExists = isUserAFriend(userToAdd);

    if (!userAlreadyExists) {
      // Change the club in the list
      this._friendList.add(userToAdd);
    }

    notifyListeners();
  }

  /// **removeFriend():**
  /// Remove a friend
  ///
  void removeFriend(User userToDelete) {
    // Update club members and admins
    List<User> newFriendList =
        _removeUserFromList(userToDelete, this._friendList);

    // Override the members
    this._friendList = newFriendList;

    notifyListeners();
  }

  /// **isUserAFriend():**
  /// Returns true if user is a friend.
  ///
  bool isUserAFriend(User userToFind) {
    for (User friend in this._friendList) {
      if (userToFind.id == friend.id) {
        return true;
      }
    }

    return false;
  }

  /// **_removeUserFromList():**
  /// Removes the user from the list and returns the list.
  ///
  /// The userToRemove.id is used to find the user.
  ///
  List<User> _removeUserFromList(User userToRemove, List<User> userList) {
    List<User> returnList = [];

    for (User user in userList) {
      if (user.id != userToRemove.id) {
        returnList.add(user);
      }
    }
    return returnList;
  }
}
