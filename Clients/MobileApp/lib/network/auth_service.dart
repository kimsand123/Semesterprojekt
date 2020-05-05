import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:golfquiz_dtu/models/player.dart';
import 'package:golfquiz_dtu/network/service_constants.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future login(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      HttpHeaders.acceptEncodingHeader: "application/json",
    };

    var jsonMap = {"username": username, "password": password};

    String json = jsonEncode(jsonMap);

    Uri uri = Uri.http(ServiceConstants.baseAuthUrl, "/login/");

    debugPrint("AuthService - Login: " + uri.toString());

    return retry(
        () => http
                .post(uri, headers: headers, body: json)
                .timeout(Duration(seconds: 5))
                .then((response) {
              Map<String, dynamic> responseMap = jsonDecode(response.body);

              if (responseMap.containsKey("player") &&
                  response.statusCode == 200) {
                String token = responseMap["user_token"];
                prefs.setString("token", token);

                debugPrint("Auth token $token");

                String game_service_ip = responseMap["game_service_ip"];

                String game_service_port = responseMap["game_service_port"];

                prefs.setString("token", token);
                prefs.setString("game_service_ip", game_service_ip);
                prefs.setString("game_service_port", game_service_port);

                if (responseMap.containsKey("game_service_ip") &&
                    responseMap.containsKey("game_service_port")) {
                  ServiceConstants.baseGameUrl =
                      game_service_ip + ":" + game_service_port;
                }

                return Player.fromJson(responseMap['player']);
              } else if (response.statusCode == 403) {
                return Future.error("Unauthorized");
              } else {
                debugPrint(
                    "Server error - AUTHSERVICE: " + responseMap.toString());
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
