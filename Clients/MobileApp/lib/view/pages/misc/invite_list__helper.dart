import 'package:golfquiz_dtu/models/invite.dart';
import 'package:golfquiz_dtu/models/player.dart';

List<Invite> gatherAcceptedInvites(List<Invite> inviteList, Player player) {
  //Null safe
  if (inviteList == null || inviteList.isEmpty) {
    return inviteList;
  }

  List<Invite> returnList = [];

  inviteList.forEach((invite) {
    // Exclude invites that are not active
    if (invite.receiverPlayer.id == player.id) {
      returnList.add(invite);
    }
  });
  return returnList;
}

List<Invite> gatherNotAcceptedInvites(List<Invite> inviteList) {
  //Null safe
  if (inviteList == null || inviteList.isEmpty) {
    return inviteList;
  }

  List<Invite> returnList = [];

  inviteList.forEach((invite) {
    // Exclude invites that are active
    if (!invite.accepted) {
      returnList.add(invite);
    }
  });
  return returnList;
}

int sortInvitesListAfterReceiver(Invite a, Invite b, Player player) {
  if (a.receiverPlayer.id == player.id && b.receiverPlayer.id == player.id) {
    return 0;
  } else if (a.receiverPlayer.id == player.id) {
    return -1;
  } else {
    return 1;
  }
}
