import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:golfquiz/models/game.dart';
import 'package:golfquiz/models/player.dart';
import 'package:golfquiz/network/service_constants.dart';
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

    Map<String, String> queryParams = {"player_id": player.username};

    Uri uri = Uri.http(ServiceConstants.baseGameUrl, apiPath, queryParams);

    debugPrint("GameService - All games: " + uri.toString());

    return retry(
        () => http
                .get(uri, headers: headers)
                .timeout(Duration(seconds: 5))
                .then((response) {
              var body = utf8.decode(response.bodyBytes);
              Map<String, dynamic> responseMap = jsonDecode(body);

              if (responseMap.containsKey("games") &&
                  response.statusCode == 200) {
                List<Game> games = List();
                for (var game in responseMap['games']) {
                  games.add(Game.fromJson(game));
                }
                return games;
              } else if (response.statusCode == 403) {
                return Future.error("Unauthorized");
              } else {
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
