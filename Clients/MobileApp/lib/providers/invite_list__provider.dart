import 'package:flutter/widgets.dart';
import 'package:golfquiz_dtu/models/invite.dart';

class InviteListProvider extends ChangeNotifier {
  List<Invite> _inviteList = [];

  List<Invite> getInviteList() => _inviteList;

  /// **setInviteList():**
  /// Sets a new invite object, should not be used for other than first logon.
  ///
  void setInviteList(Map<String, List<Invite>> invites) {
    this._inviteList = List.from(invites["invites_as_sender"]) ?? [];
    this._inviteList.addAll(invites["invites_as_receiver"]);

    notifyListeners();
  }

  /// **removeInviteList():**
  /// Removes the list object, should not be used for other than logout.
  ///
  void removeInviteList() {
    this._inviteList = [];

    notifyListeners();
  }

  /// **addInvite():**
  /// Add invite to invite-list
  ///
  void addInvite(Invite inviteToAdd) {
    // Find if invite already exists
    bool inviteAlreadyExists = isInviteAlreadyInInviteList(inviteToAdd);

    if (!inviteAlreadyExists) {
      // Add invite to list
      this._inviteList.add(inviteToAdd);
    } else {
      // Exchange the already existing invite
      Invite invite = findInviteWithId(inviteToAdd.id);
      int index = this._inviteList.indexOf(invite);
      this._inviteList[index] = inviteToAdd;
    }

    notifyListeners();
  }

  /// **removeInvite():**
  /// Removes a invite from the list
  ///
  void removeInvite(Invite inviteToDelete) {
    List<Invite> inviteList =
        _removeInviteFromList(inviteToDelete, this._inviteList);

    // Override the inviteList
    this._inviteList = inviteList;

    notifyListeners();
  }

  /// **isInviteAlreadyInInviteList():**
  /// Returns true if invite already exits.
  ///
  bool isInviteAlreadyInInviteList(Invite inviteToFind) {
    for (Invite invite in this._inviteList) {
      if (inviteToFind.id == invite.id) {
        return true;
      }
    }

    return false;
  }

  /// **findInviteWithId():**
  /// Gets a invite from its id, and returns it.
  ///
  Invite findInviteWithId(int inviteId) {
    Invite returnInvite = Invite();

    for (Invite invite in this._inviteList) {
      if (invite.id == inviteId) {
        return invite;
      }
    }
    return returnInvite;
  }

  /// **_removeInviteFromList():**
  /// Removes the invite from the list and returns the list.
  ///
  /// The invite.id is used to find the invite.
  ///
  List<Invite> _removeInviteFromList(
      Invite inviteToRemove, List<Invite> inviteList) {
    List<Invite> returnList = [];

    for (Invite invite in inviteList) {
      if (invite.id != inviteToRemove.id) {
        returnList.add(invite);
      }
    }
    return returnList;
  }
}
