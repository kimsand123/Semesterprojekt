import 'package:flutter/widgets.dart';
import 'package:golfquiz_dtu/models/game.dart';
import 'package:golfquiz_dtu/models/game_round.dart';
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
    updateMyMeProvider(context, player.id);

    updateFriendProvider(context, player);

    updateInviteProvider(context, player);

    updateGameListProvider(context, player);
  }

  Future<void> updateMyMeProvider(BuildContext context, int playerId) async {
    // Set MeProvider
    Player newCurrentPlayer = await PlayerService.fetchSinglePlayer(playerId);
    Provider.of<MeProvider>(context, listen: false).setUser(newCurrentPlayer);
  }

  Future<void> updateFriendProvider(BuildContext context, Player player) async {
    // Set FriendProvider
    List<Player> playerlist = await PlayerService.fetchPlayers(player);
    Provider.of<FriendProvider>(context, listen: false)
        .setFriendList(playerlist);
  }

  Future<void> updateInviteProvider(BuildContext context, Player player) async {
    // Set InviteProvider
    Map<String, List<Invite>> allInvitelist =
        await InviteService.fetchInvites(player);

    Provider.of<InviteListProvider>(context, listen: false)
        .setInviteList(allInvitelist);
  }

  Future<void> updateGameListProvider(
      BuildContext context, Player player) async {
    // Set GamesProvider
    List<Game> games = await GameService.fetchGames(player);
    Provider.of<GameListProvider>(context, listen: false).setGameList(games);
  }

  Future<void> updateSingleGameInGameListProvider(
      BuildContext context, Player player, int gameId) async {
    // Set GamesProvider
    Game game = await GameService.fetchSingleGame(player, gameId);
    Provider.of<GameListProvider>(context, listen: false).addOrUpdateGame(game);
  }

  Future<void> updateGameInGameListProvider(
      BuildContext context, Game game, Player player) async {
    Game newGame = await GameService.addGameRoundToGame(game, player);

    Provider.of<GameListProvider>(context, listen: false)
        .addOrUpdateGame(newGame);
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
