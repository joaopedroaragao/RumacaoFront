class AreaPercentages {
  final String educacao;
  final String cultura;
  final String ciencia;

  AreaPercentages({
    required this.educacao,
    required this.cultura,
    required this.ciencia,
  });

  factory AreaPercentages.fromJson(Map<String, dynamic> json) {
    return AreaPercentages(
      educacao: json["Educação"]?.toString() ?? "0.0",
      cultura: json["Cultura"]?.toString() ?? "0.0",
      ciencia: json["Ciência"]?.toString() ?? "0.0",
    );
  }
}

class ScoreData {
  final String responseId;
  final String quizId;
  final AreaPercentages areaPercentages;

  ScoreData({
    required this.responseId,
    required this.quizId,
    required this.areaPercentages,
  });

  factory ScoreData.fromJson(Map<String, dynamic> json) {
    return ScoreData(
      responseId: json["responseId"] as String,
      quizId: json["quizId"] as String,
      areaPercentages: AreaPercentages.fromJson(json["areaPercentages"] as Map<String, dynamic>),
    );
  }
}
