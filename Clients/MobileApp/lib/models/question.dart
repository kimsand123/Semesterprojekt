import 'package:golfquiz/models/rule.dart';

class Question {

  String question;
  List<String> answers;
  int correctAnswer;
  Rule rule;

  Question({this.question, this.answers, this.correctAnswer, this.rule});
}