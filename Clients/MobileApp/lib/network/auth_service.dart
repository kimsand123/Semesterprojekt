import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:golfquiz/models/player.dart';
import 'package:golfquiz/network/service_constants.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future login(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      HttpHeaders.acceptEncodingHeader: "application/json",
    };

    var json_map = {"username": username, "password": password};

    String json = jsonEncode(json_map);

    Uri uri = Uri.http(ServiceConstants.baseAuthUrl, "/login/");

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

                return Player.fromJson(responseMap['player']);
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