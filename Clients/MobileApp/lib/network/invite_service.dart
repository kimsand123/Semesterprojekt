import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:golfquiz_dtu/models/invite.dart';
import 'package:golfquiz_dtu/models/player.dart';
import 'package:golfquiz_dtu/network/service_constants.dart';
import 'package:retry/retry.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class InviteService {
  static Future<Map<String, List<Invite>>> fetchInvites(Player player) async {
    String apiPath = "/invites/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");

    Map<String, String> headers = {
      HttpHeaders.acceptEncodingHeader: "application/json",
      "Authorization": token
    };

    Map<String, String> queryParams = {"player_id": player.id.toString()};

    Uri uri = Uri.http(ServiceConstants.baseGameUrl, apiPath, queryParams);

    debugPrint("InviteService - All invites: " + uri.toString());

    return retry(
        () => http
                .get(uri, headers: headers)
                .timeout(Duration(seconds: 5))
                .then((response) {
              var body = utf8.decode(response.bodyBytes);
              Map<String, dynamic> responseMap = jsonDecode(body);

              if (responseMap.containsKey("invites_as_sender") &&
                  responseMap.containsKey("invites_as_receiver") &&
                  response.statusCode == 200) {
                List<Invite> invitesSender = List();
                for (var invite in responseMap['invites_as_sender']) {
                  if (invite["accepted"] != true) {
                    invitesSender.add(Invite.fromJson(invite));
                  }
                }

                List<Invite> invitesReceiver = List();
                for (var invite in responseMap['invites_as_receiver']) {
                  if (invite["accepted"] != true) {
                    invitesSender.add(Invite.fromJson(invite));
                  }
                }
                return {
                  "invites_as_sender": invitesSender,
                  "invites_as_receiver": invitesReceiver
                };
              } else if (response.statusCode == 403) {
                return Future.error("Unauthorized");
              } else {
                debugPrint("Server error - INVITESERVICE (get all invites): " +
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

  static Future<void> acceptInvite(Invite invite) async {
    String apiPath = "/invites/${invite.id.toString()}/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");

    Map<String, String> headers = {
      HttpHeaders.acceptEncodingHeader: "application/json",
      "Authorization": token,
    };

    Uri uri = Uri.http(
      ServiceConstants.baseGameUrl,
      apiPath,
    );

    debugPrint("InviteService - Accept invite: " + uri.toString());

    invite.accepted = true;

    var jsonMap = {"invite": invite.toJson()};

    String json = jsonEncode(jsonMap);

    return retry(
        () => http
                .put(uri, headers: headers, body: json)
                .timeout(Duration(seconds: 5))
                .then((response) {
              var body = utf8.decode(response.bodyBytes);
              Map<String, dynamic> responseMap = jsonDecode(body);

              if (responseMap.containsKey("game")) {
                debugPrint("Invite accepted, new game:" +
                    responseMap['game'].toString());
              } else if (response.statusCode == 403) {
                return Future.error("Unauthorized");
              } else {
                debugPrint("Server error - INVITESERVICE (accept invites): " +
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

  static Future<Invite> deleteInvite(Invite invite) async {
    String apiPath = "/invites/${invite.id.toString()}/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");

    Map<String, String> headers = {
      HttpHeaders.acceptEncodingHeader: "application/json",
      "Authorization": token
    };

    Uri uri = Uri.http(
      ServiceConstants.baseGameUrl,
      apiPath,
    );

    debugPrint("InviteService - Delete invite: " + uri.toString());

    return retry(
        () => http
                .delete(uri, headers: headers)
                .timeout(Duration(seconds: 5))
                .then((response) {
              var body = utf8.decode(response.bodyBytes);
              Map<String, dynamic> responseMap = jsonDecode(body);

              if (responseMap.containsKey("deleted_invite")) {
                return Invite.fromJson(responseMap['deleted_invite']);
              } else if (response.statusCode == 403) {
                return Future.error("Unauthorized");
              } else {
                debugPrint("Server error - INVITESERVICE (delete invite): " +
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

  static Future<Invite> createInvite(Invite invite) async {
    String apiPath = "/invites/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");

    Map<String, String> headers = {
      HttpHeaders.acceptEncodingHeader: "application/json",
      "Authorization": token
    };

    var jsonMap = {"invite": invite.toJson()};

    String json = jsonEncode(jsonMap);

    Uri uri = Uri.http(ServiceConstants.baseGameUrl, apiPath);

    debugPrint("InviteService - Create invite: " + uri.toString());

    return retry(
        () => http
                .post(uri, headers: headers, body: json)
                .timeout(Duration(seconds: 5))
                .then((response) {
              var body = utf8.decode(response.bodyBytes);
              Map<String, dynamic> responseMap = jsonDecode(body);

              if (responseMap.containsKey("invite")) {
                return Invite.fromJson(responseMap['invite']);
              } else if (response.statusCode == 403) {
                return Future.error("Unauthorized");
              } else {
                debugPrint("Server error - INVITESERVICE (create invite): " +
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
