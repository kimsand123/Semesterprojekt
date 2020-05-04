import 'package:flutter/widgets.dart';
import 'package:golfquiz_dtu/models/game.dart';
import 'package:golfquiz_dtu/models/invite.dart';
import 'package:golfquiz_dtu/models/player.dart';
import 'package:golfquiz_dtu/network/game_service.dart';
import 'package:golfquiz_dtu/network/invite_service.dart';
import 'package:golfquiz_dtu/network/player_service.dart';
import 'package:golfquiz_dtu/providers/friend__provider.dart';
import 'package:golfquiz_dtu/providers/game_list__provider.dart';
import 'package:golfquiz_dtu/providers/invite_list__provider.dart';
import 'package:golfquiz_dtu/providers/player__provider.dart';
import 'package:provider/provider.dart';

class RemoteHelper {
  Future<void> fillProviders(BuildContext context, Player player) async {
    // Set UserProvider
    Provider.of<PlayerProvider>(context, listen: false).setUser(player);

    // Set FriendProvider
    List<Player> playerlist = await PlayerService.fetchPlayers(player);
    Provider.of<FriendProvider>(context, listen: false)
        .setFriendList(playerlist);

    // Set InviteProvider
    Map<String, List<Invite>> allInvitelist =
        await InviteService.fetchInvites(player);

    Provider.of<InviteListProvider>(context, listen: false)
        .setInviteList(allInvitelist);

    // Set GamesProvider
    List<Game> games = await GameService.fetchGames(player);
    Provider.of<GameListProvider>(context, listen: false).setGameList(games);
  }

  Future<void> emptyProvider(BuildContext context) {
    // Remove User
    Provider.of<PlayerProvider>(context, listen: false).remove();

    // Remove Friends
    Provider.of<FriendProvider>(context, listen: false).removeFriends();

    // Remove Invites
    Provider.of<InviteListProvider>(context, listen: false).removeInviteList();

    // Remove Games
    Provider.of<GameListProvider>(context, listen: false).removeGameList();

    return Future.value(true);
  }
}
