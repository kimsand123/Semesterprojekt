class Question {
  int id;
  String questionText;
  int correctAnswer;
  String answer1;
  String answer2;
  String answer3;

  Question({
    this.id,
    this.questionText,
    this.correctAnswer,
    this.answer1,
    this.answer2,
    this.answer3,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        questionText: json["question_text"],
        correctAnswer: json["correct_answer"],
        answer1: json["answer_1"],
        answer2: json["answer_2"],
        answer3: json["answer_3"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question_text": questionText,
        "correct_answer": correctAnswer,
        "answer_1": answer1,
        "answer_2": answer2,
        "answer_3": answer3,
      };
}
