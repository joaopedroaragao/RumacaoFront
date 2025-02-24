// lib/viewmodel/results_view_model.dart
import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rumacao_front/constants/environment.dart';
import 'package:rumacao_front/constants/app_constants.dart';
import 'package:rumacao_front/model/score_data.dart';

class ResultsViewModel extends GetxController {
  final String responseId;
  ResultsViewModel({required this.responseId});

  var isLoading = true.obs;
  var error = RxnString();

  // Armazena o model com os dados de score
  var scoreData = Rxn<ScoreData>();

  // Propriedades reativas solicitadas
  var userName = ''.obs;
  var quizTitle = ''.obs; // Maior(es) área(s) do areaPercentages
  var resultType = Rxn<ResultType>();

  // Propriedade para armazenar as áreas ordenadas (maior para menor)
  var orderedAreas = <MapEntry<String, double>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserName();
    fetchScore();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    userName.value = prefs.getString("name") ?? "(Nome)";
  }

  Future<void> fetchScore() async {
    try {
      isLoading.value = true;
      error.value = null;

      final url = "${Environment.baseUrl}/score/$responseId";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonMap = jsonDecode(response.body);
        final data = ScoreData.fromJson(jsonMap);
        scoreData.value = data;
        await _computeQuizTitleAndResultType(data.areaPercentages);
        await clearUserData();
      } else {
        error.value = "Erro ao carregar o resultado: ${response.statusCode}";
      }
    } catch (e) {
      error.value = "Erro na requisição: $e";
    } finally {
      isLoading.value = false;
    }
  }

  /// Calcula o título do quiz, o ResultType e ordena as áreas de acordo com a porcentagem.
  Future<void> _computeQuizTitleAndResultType(AreaPercentages areas) async {
    // Converte as porcentagens removendo o símbolo '%' para double
    double ed = double.tryParse(areas.educacao.replaceAll("%", "")) ?? 0.0;
    double cul = double.tryParse(areas.cultura.replaceAll("%", "")) ?? 0.0;
    double ci = double.tryParse(areas.ciencia.replaceAll("%", "")) ?? 0.0;

    // Armazena as áreas ordenadas (maior para menor)
    orderedAreas.assignAll([
      MapEntry("Educação", ed),
      MapEntry("Cultura", cul),
      MapEntry("Ciência", ci)
    ]..sort((a, b) => b.value.compareTo(a.value)));

    final maxValue = [ed, cul, ci].reduce(max);
    // Para cálculo do diff, é possível ordenar também uma cópia da lista
    final sorted = [ed, cul, ci]..sort((a, b) => b.compareTo(a));
    final diff = sorted[0] - sorted[1];
    final List<String> topAreas = [];
    final totalScore = (await SharedPreferences.getInstance()).getInt("totalScore");

    if (totalScore != null && totalScore == 0) {
      topAreas.add("Inconclusivo :(");
      resultType.value = ResultType.INCONCLUSIVE;
    } else if (sorted[0] != sorted[1]) {
      topAreas.addAll(_getTitles(sorted[0], maxValue, ed, cul, ci));
      resultType.value = ResultType.MAJOR;
    } else if (sorted[1] != sorted[2]) {
      topAreas.addAll(_getTitles(sorted[1], maxValue, ed, cul, ci));
      resultType.value = ResultType.MIXED;
    } else {
      topAreas.add("Equilibrado");
      resultType.value = ResultType.EQUIVALENT;
    }

    quizTitle.value = topAreas.join(" + ");
  }

  List<String> _getTitles(double value, double maxValue, double ed, double cul, double ci) {
    return [
      if (ed == maxValue) "Educação Ambiental",
      if (cul == maxValue) "Cultura",
      if (ci == maxValue) "Ciência"
    ];
  }

  /// Propriedade computada para retornar a imagem do mascote com base no ResultType.
  String get mascotImage {
    if (resultType.value == ResultType.INCONCLUSIVE) {
      return AppStrings.mascoteImages.totallyDisagree3;
    } else if (resultType.value == ResultType.MAJOR) {
      // Para MAJOR, utiliza a área de maior porcentagem.
      if (orderedAreas.isNotEmpty) {
        final topArea = orderedAreas.first.key;
        switch (topArea) {
          case "Educação":
            return AppStrings.mascoteImages.majorEd;
          case "Cultura":
            return AppStrings.mascoteImages.majorCul;
          case "Ciência":
            return AppStrings.mascoteImages.majorCi;
          default:
            return AppStrings.mascoteImages.neutral1;
        }
      }
      return AppStrings.mascoteImages.neutral1;
    } else if (resultType.value == ResultType.MIXED) {
      // Para MIXED, utiliza as duas áreas de maior porcentagem.
      if (orderedAreas.length >= 2) {
        final first = orderedAreas[0].key;
        final second = orderedAreas[1].key;
        if ((first == "Ciência" && second == "Cultura") ||
            (first == "Cultura" && second == "Ciência")) {
          return AppStrings.mascoteImages.mixedCiCul;
        } else if ((first == "Ciência" && second == "Educação") ||
            (first == "Educação" && second == "Ciência")) {
          return AppStrings.mascoteImages.mixedCiEd;
        } else if ((first == "Cultura" && second == "Educação") ||
            (first == "Educação" && second == "Cultura")) {
          return AppStrings.mascoteImages.mixedCulEd;
        }
      }
      return AppStrings.mascoteImages.neutral1;
    } else if (resultType.value == ResultType.EQUIVALENT) {
      return AppStrings.mascoteImages.equivalent;
    } else {
      return AppStrings.mascoteImages.neutral1;
    }
  }

  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('name');
    await prefs.remove('email');
    await prefs.remove('questions');
    await prefs.remove('selectedAnswers');
    await prefs.remove('responseId');
  }
}

enum ResultType {
  MAJOR, MIXED, EQUIVALENT, INCONCLUSIVE
}
