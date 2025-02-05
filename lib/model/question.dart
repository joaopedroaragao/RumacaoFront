class Question {
  final String text;

  Question({
    required this.text,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(text: json["text"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "text": text
    };
  }
}
