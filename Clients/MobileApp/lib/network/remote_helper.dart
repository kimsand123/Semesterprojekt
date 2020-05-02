import 'package:flutter/widgets.dart';
import 'package:golfquiz/models/player.dart';
import 'package:golfquiz/providers/friend__provider.dart';
import 'package:golfquiz/providers/user__provider.dart';
import 'package:golfquiz/view/pages/misc/hard_coded_data.dart';
import 'package:provider/provider.dart';

class RemoteHelper {
  Future<List<Player>> searchForUsers(String searchPattern) async {
    if (searchPattern.isEmpty) {
      return [];
    }

    //TODO remote call
    List<Player> userList = HardCodedData.getHardCodedSearchData();
    List<Player> searchList = [];

    userList.forEach((user) {
      String name = user.username ?? '';
      if (name.contains(searchPattern)) {
        searchList.add(user);
      }
    });

    await Future.delayed(Duration(seconds: 1));

    return searchList;
  }

  // TODO: Remove when real data is introduced.
  void fakeFillProviders(BuildContext context, Player user) {
    // Set UserProvider
    Provider.of<UserProvider>(context, listen: false).setUser(user);

    // Set FriendProvider
    List<Player> friends = HardCodedData.getHardCodedFriends();
    Provider.of<FriendProvider>(context, listen: false).setFriendList(friends);
  }
}
