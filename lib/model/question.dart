class Question {
  final String questionId;
  final String text;

  Question({
    required this.questionId,
    required this.text,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionId: json["questionId"],
      text: json["text"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "questionId": questionId,
      "text": text
    };
  }
}
