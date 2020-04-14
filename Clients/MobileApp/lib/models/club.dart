import 'package:golfquiz/models/user.dart';

class Club {
  String name;
  int clubId;
  List<User> clubMembers;
  List<User> clubAdmins;

  Club({this.name, this.clubId, this.clubMembers, this.clubAdmins});
  Club.init() {
    this.name = '';
    this.clubId = -1;
    this.clubMembers = [];
    this.clubAdmins = [];
  }
}
