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
import 'package:golfquiz_dtu/providers/me__provider.dart';
import 'package:provider/provider.dart';

class RemoteHelper {
  Future<void> fillProviders(BuildContext context, Player player) async {
    await updateMyMeProvider(context, player.id);

    await updateFriendProvider(context, player);

    await updateInviteProvider(context, player);

    await updateGameListProvider(context, player);

    return Future.value(true);
  }

  Future<void> updateMyMeProvider(BuildContext context, int playerId) async {
    // Set MeProvider
    Player newCurrentPlayer = await PlayerService.fetchSinglePlayer(playerId);
    Provider.of<MeProvider>(context, listen: false).setUser(newCurrentPlayer);
    return Future.value(true);
  }

  Future<void> updateFriendProvider(BuildContext context, Player player) async {
    // Set FriendProvider
    List<Player> playerlist = await PlayerService.fetchPlayers(player);
    Provider.of<FriendProvider>(context, listen: false)
        .setFriendList(playerlist);
    return Future.value(true);
  }

  Future<void> updateInviteProvider(BuildContext context, Player player) async {
    // Set InviteProvider
    Map<String, List<Invite>> allInvitelist =
        await InviteService.fetchInvites(player);

    Provider.of<InviteListProvider>(context, listen: false)
        .setInviteList(allInvitelist);
    return Future.value(true);
  }

  Future<void> updateGameListProvider(
      BuildContext context, Player player) async {
    // Set GamesProvider
    List<Game> games = await GameService.fetchGames(player);
    Provider.of<GameListProvider>(context, listen: false).setGameList(games);
    return Future.value(true);
  }

  Future<void> updateSingleGameInGameListProvider(
      BuildContext context, Player player, int gameId) async {
    // Set GamesProvider
    Game game = await GameService.fetchSingleGame(player, gameId);
    Provider.of<GameListProvider>(context, listen: false).addOrUpdateGame(game);
    return Future.value(true);
  }

  Future<void> updateGameInGameListProvider(
      BuildContext context, Game game, Player player) async {
    Game newGame = await GameService.addGameRoundToGame(game, player);

    Provider.of<GameListProvider>(context, listen: false)
        .addOrUpdateGame(newGame);
    return Future.value(true);
  }

  Future<void> emptyProvider(BuildContext context) {
    // Remove User
    Provider.of<MeProvider>(context, listen: false).remove();

    // Remove Friends
    Provider.of<FriendProvider>(context, listen: false).removeFriends();

    // Remove Invites
    Provider.of<InviteListProvider>(context, listen: false).removeInviteList();

    // Remove Games
    Provider.of<GameListProvider>(context, listen: false).removeGameList();

    return Future.value(true);
  }
}
