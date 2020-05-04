// To parse this JSON data, do
//
//     final invite = inviteFromJson(jsonString);

import 'dart:convert';
import 'player.dart';

class Invite {
  int id;
  Player senderPlayer;
  Player receiverPlayer;
  bool accepted;
  String matchName;
  double questionDuration;

  Invite(
      {this.id,
      this.senderPlayer,
      this.receiverPlayer,
      this.accepted,
      this.matchName,
      this.questionDuration});

  factory Invite.fromRawJson(String str) => Invite.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Invite.fromJson(Map<String, dynamic> json) => Invite(
        id: json["id"],
        senderPlayer: Player.fromJson(json["sender_player"]),
        receiverPlayer: Player.fromJson(json["receiver_player"]),
        matchName: json["game"]["match_name"],
        questionDuration: double.parse(json["game"]["question_duration"]),
        accepted: json["accepted"],
      );

  Map<String, dynamic> toJson() => {
        "sender_player_id": senderPlayer.id,
        "receiver_player_id": receiverPlayer.id,
        "match_name": matchName,
        "question_duration": questionDuration,
        "accepted": accepted,
      };

  @override
  String toString() {
    String returnString = "";

    returnString += "{" + id.toString() + " (${matchName.toString()}): ";
    returnString += "s: " + senderPlayer.id.toString();
    returnString += ", r: " + receiverPlayer.id.toString();
    returnString += ", duration: " + questionDuration.toString();
    returnString += "}";

    return returnString;
  }
}
