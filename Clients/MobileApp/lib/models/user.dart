import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int id;
  String username;
  String email;
  String firstName;
  String lastName;
  String studyProgramme;
  int highScore;

  User({
    this.id,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.studyProgramme,
    this.highScore,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        studyProgramme: json["study_programme"],
        highScore: json["high_score"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "study_programme": studyProgramme,
        "high_score": highScore,
      };
}
