import 'package:flutter/widgets.dart';
import 'package:golfquiz/models/game.dart';
import 'package:golfquiz/models/player.dart';
import 'package:golfquiz/network/game_service.dart';
import 'package:golfquiz/network/player_service.dart';
import 'package:golfquiz/providers/friend__provider.dart';
import 'package:golfquiz/providers/game_list__provider.dart';
import 'package:golfquiz/providers/user__provider.dart';
import 'package:provider/provider.dart';

class RemoteHelper {
  Future<void> fillProviders(BuildContext context, Player player) async {
    // Set UserProvider
    Provider.of<PlayerProvider>(context, listen: false).setUser(player);

    // Set FriendProvider
    List<Player> userlist = await PlayerService.fetchUsers();
    Provider.of<FriendProvider>(context, listen: false).setFriendList(userlist);

    // Set GamesProvider
    List<Game> games = await GameService.fetchGames(player);
    Provider.of<GameListProvider>(context, listen: false).setGameList(games);
  }
}
