import 'package:flutter/foundation.dart';

class NotificationProviderObject {
  bool menuNotification;
  bool friendsNotification;
  bool groupsNotification;
  bool clubsNotification;

  NotificationProviderObject({
    @required bool menuNotification,
    @required bool friendsNotification,
    @required bool groupsNotification,
    @required bool clubsNotification,
  })  : this.menuNotification = menuNotification,
        this.friendsNotification = friendsNotification,
        this.groupsNotification = groupsNotification,
        this.clubsNotification = clubsNotification;
}
