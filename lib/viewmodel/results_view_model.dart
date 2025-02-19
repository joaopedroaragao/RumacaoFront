// lib/viewmodel/results_view_model.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rumacao_front/constants/environment.dart';
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

      // // Exemplo usando mock:
      // const mock = '''
      // {
      //   "responseId": "akOR7DWuTbHUrUmbPGTN",
      //   "quizId": "cXNZNJc3HOu7N2faYqgo",
      //   "areaPercentages": {
      //     "Educação": "34.29%",
      //     "Cultura": "31.43%",
      //     "Ciência": "34.29%"
      //   }
      // }
      // ''';
      // final jsonMap = jsonDecode(mock);
      // final data = ScoreData.fromJson(jsonMap);
      // scoreData.value = data;

      // Descomente o trecho abaixo para usar a API real:
      final url = "${Environment.baseUrl}/score/$responseId";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonMap = jsonDecode(response.body);
        final data = ScoreData.fromJson(jsonMap);
        scoreData.value = data;
        _computeQuizTitle(data.areaPercentages);
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

  /// Determina a(s) área(s) com a maior porcentagem.
  /// Em caso de empate, formata como "ÁreaA / ÁreaB".
  void _computeQuizTitle(AreaPercentages areas) {
    // Remove '%' e converte para double
    double ed = double.tryParse(areas.educacao.replaceAll("%", "")) ?? 0.0;
    double cul = double.tryParse(areas.cultura.replaceAll("%", "")) ?? 0.0;
    double ci = double.tryParse(areas.ciencia.replaceAll("%", "")) ?? 0.0;

    final maxValue = [ed, cul, ci].reduce((a, b) => a > b ? a : b);

    final List<String> topAreas = [];
    if (ed == maxValue) topAreas.add("Educação Ambiental");
    if (cul == maxValue) topAreas.add("Cultura");
    if (ci == maxValue) topAreas.add("Ciência");

    quizTitle.value = topAreas.join(" / ");
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
