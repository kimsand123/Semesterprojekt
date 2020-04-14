import 'package:golfquiz/models/user.dart';

class Group {
  int id;
  String name;
  List<User> groupMembers;
  List<User> groupAdmins;

  Group({this.id, this.name, this.groupMembers, this.groupAdmins});

  Group.init() {
    this.id = -1;
    this.name = '';
    this.groupMembers = [];
    this.groupAdmins = [];
  }
}
