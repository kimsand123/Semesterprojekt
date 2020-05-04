import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:golfquiz_dtu/models/game.dart';
import 'package:golfquiz_dtu/models/game_round.dart';
import 'package:golfquiz_dtu/models/player.dart';
import 'package:golfquiz_dtu/models/player_status.dart';
import 'package:golfquiz_dtu/network/service_constants.dart';
import 'package:retry/retry.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GameService {
  static Future<List<Game>> fetchGames(Player player) async {
    String apiPath = "/games/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");

    Map<String, String> headers = {
      HttpHeaders.acceptEncodingHeader: "application/json",
      "Authorization": token
    };

    Map<String, String> queryParams = {"player_id": player.id.toString()};

    Uri uri = Uri.http(ServiceConstants.baseGameUrl, apiPath, queryParams);

    debugPrint("GameService - All games: " + uri.toString());

    return retry(
        () => http
                .get(uri, headers: headers)
                .timeout(Duration(seconds: 5))
                .then((response) {
              var body = utf8.decode(response.bodyBytes);
              Map<String, dynamic> responseMap = jsonDecode(body);

              if (responseMap.containsKey("games")) {
                List<Game> games = List();
                for (var game in responseMap['games']) {
                  games.add(Game.fromJson(game));
                }
                return games;
              } else if (response.statusCode == 403) {
                return Future.error("Unauthorized");
              } else {
                debugPrint("Server error - GAMESERVICE (all games): " +
                    responseMap.toString());
                return Future.error("Server_error");
              }
            }),
        retryIf: (e) {
          if (e is SocketException || e is TimeoutException) {
            return true;
          } else {
            return false;
          }
        },
        onRetry: (e) => print(e.toString()));
  }

  static Future<Game> addGameRoundToGame(Game game, Player player) async {
    String apiPath = "/games/${game.id}/player-status/game-round/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");

    Map<String, String> headers = {
      HttpHeaders.acceptEncodingHeader: "application/json",
      "Authorization": token
    };

    PlayerStatus currentPlayerStatus;
    for (PlayerStatus status in game.playerStatus) {
      if (status.gamePlayer.player.id == player.id) {
        currentPlayerStatus = status;
      }
    }

    Map<String, String> queryParams = {"player_id": player.id.toString()};

    var jsonMap = {"game_round": currentPlayerStatus.gameRound};
    String json = jsonEncode(jsonMap);

    Uri uri = Uri.http(ServiceConstants.baseGameUrl, apiPath, queryParams);

    debugPrint("GameService - Add gameround: " + uri.toString());

    return retry(
        () => http
                .put(uri, headers: headers, body: json)
                .timeout(Duration(seconds: 5))
                .then((response) {
              var body = utf8.decode(response.bodyBytes);
              Map<String, dynamic> responseMap = jsonDecode(body);

              if (responseMap.containsKey("game")) {
                return Game.fromJson(responseMap["game"]);
              } else if (response.statusCode == 403) {
                return Future.error("Unauthorized");
              } else {
                debugPrint("Server error - GAMESERVICE (add gamerounds): " +
                    responseMap.toString());
                return Future.error("Server_error");
              }
            }),
        retryIf: (e) {
          if (e is SocketException || e is TimeoutException) {
            return true;
          } else {
            return false;
          }
        },
        onRetry: (e) => print(e.toString()));
  }
}
