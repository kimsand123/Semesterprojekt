import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:golfquiz_dtu/models/player.dart';
import 'package:golfquiz_dtu/network/service_constants.dart';
import 'package:retry/retry.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PlayerService {
  static Future<List<Player>> fetchPlayers(Player currentPlayer) async {
    const apiPath = "/players/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");

    Map<String, String> headers = {
      HttpHeaders.acceptEncodingHeader: "application/json",
      "Authorization": token
    };

    Uri uri = Uri.http(ServiceConstants.baseGameUrl, apiPath);

    debugPrint("UserService - All users: " + uri.toString());

    return retry(
        () => http
                .get(uri, headers: headers)
                .timeout(Duration(seconds: 5))
                .then((response) {
              var body = utf8.decode(response.bodyBytes);
              Map<String, dynamic> responseMap = jsonDecode(body);

              if (responseMap.containsKey("players") &&
                  response.statusCode == 200) {
                List<Player> users = List();
                for (var user in responseMap['players']) {
                  if (user['id'] != currentPlayer.id) {
                    users.add(Player.fromJson(user));
                  }
                }
                return users;
              } else if (response.statusCode == 403) {
                return Future.error("Unauthorized");
              } else {
                debugPrint("Server error - PLAYERSERVICE (all players): " +
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
