import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:golfquiz/models/player.dart';
import 'package:golfquiz/network/service_constants.dart';
import 'package:retry/retry.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static Future<List<Player>> fetchUsers() async {
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

              print(responseMap.toString());

              if (responseMap.containsKey("players") &&
                  response.statusCode == 200) {
                List<Player> users = List();
                for (var user in responseMap['players']) {
                  users.add(Player.fromJson(user));
                }
                return users;
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

  /*

  static Future<User> fetchUser(userId) async {
    var apiPath = "/api/v1/users/$userId";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");

    Map<String, String> headers = {
      HttpHeaders.acceptEncodingHeader: "application/json",
      "Authorization": token
    };

    Uri uri = Uri.http(ServiceConstants.baseUrl, apiPath);

    return retry(
        () => http
                .get(uri, headers: headers)
                .timeout(Duration(seconds: 5))
                .then((response) {
              Map<String, dynamic> responseMap = jsonDecode(response.body);

              if (responseMap.containsKey("data") &&
                  response.statusCode == 200) {
                return User.fromJson(responseMap['data']);
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

  static Future<List<User>> findPlayer(keyword) async {
    var apiPath = "/api/v1/users/filter/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");

    Map<String, String> headers = {
      HttpHeaders.acceptEncodingHeader: "application/json",
      "Authorization": token
    };

    Map<String, String> filterParams = {
      "where": '{"name.first": {"contains": "$keyword"}}'
    };

    Uri uri = Uri.http(ServiceConstants.baseUrl, apiPath, filterParams);

    return retry(
        () => http
                .get(uri, headers: headers)
                .timeout(Duration(seconds: 5))
                .then((response) {
              Map<String, dynamic> responseMap = jsonDecode(response.body);

              if (responseMap.containsKey("data") &&
                  response.statusCode == 200) {
                List<User> users = List();
                for (var user in responseMap['data']) {
                  users.add(User.fromJson(user));
                }

                return users;
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
  */
}
