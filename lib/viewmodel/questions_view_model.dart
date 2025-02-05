import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rumacao_front/constants/environment.dart';
import 'package:rumacao_front/model/question.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visibility_detector/visibility_detector.dart';

class QuestionViewModel extends GetxController {
  /// Indica se o quiz está carregando.
  var isLoading = true.obs;

  /// Controla se o card introdutório (pré-quiz) deve ser exibido.
  var showIntroCard = true.obs;

  /// Índice da pergunta atual.
  var currentQuestionIndex = 0.obs;

  /// Lista de perguntas.
  var questions = <Question>[].obs;

  /// Mapa com as respostas selecionadas: key = índice da pergunta, value = id da opção (score).
  var selectedAnswers = <int, int>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _loadCachedAnswers();
    _loadCachedQuestions();
    _loadQuestions();
  }

  /// Carrega as respostas salvas do cache (SharedPreferences).
  Future<void> _loadCachedAnswers() async {
    final prefs = await SharedPreferences.getInstance();
    String? cached = prefs.getString('selectedAnswers');
    if (cached != null) {
      try {
        Map<String, dynamic> jsonMap = jsonDecode(cached);
        selectedAnswers.assignAll(
          jsonMap.map((key, value) => MapEntry(int.parse(key), value as int)),
        );
      } catch (e) {
        // Se ocorrer erro, ignora o cache.
        print("Erro ao carregar respostas do cache: $e");
      }
    }
  }

  /// Salva as respostas atuais no cache.
  Future<void> _saveAnswers() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> jsonMap =
    selectedAnswers.map((key, value) => MapEntry(key.toString(), value));
    prefs.setString('selectedAnswers', jsonEncode(jsonMap));
  }

  /// Carrega as questões salvas no cache.
  Future<void> _loadCachedQuestions() async {
    final prefs = await SharedPreferences.getInstance();
    String? cached = prefs.getString('questions');
    if (cached != null) {
      try {
        List<dynamic> jsonList = jsonDecode(cached);
        questions.assignAll(
          jsonList.map((json) => Question.fromJson(json)).toList(),
        );
      } catch (e) {
        // Em caso de erro, ignora o cache.
        print("Erro ao carregar questões do cache: $e");
      }
    }
  }

  /// Salva as questões atuais no cache.
  Future<void> _saveQuestions() async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> jsonList =
    questions.map((q) => q.toJson()).toList();
    prefs.setString('questions', jsonEncode(jsonList));
  }

  /// Consome as questões da API e as salva no cache (caso não tenham sido carregadas do cache).
  void _loadQuestions() async {
    final url = "${Environment.baseUrl}/quiz/cXNZNJc3HOu7N2faYqgo";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Supondo que a resposta tenha uma chave 'questions' com uma lista de questões:
        List<dynamic> questionsJson = data['questions'];
        questions.assignAll(
          questionsJson.map((json) => Question.fromJson(json)).toList(),
        );
        await _saveQuestions();
      } else {
        print("Erro ao buscar questões. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro na requisição: $e");
    }
    isLoading.value = false;
  }

  /// Remove o card introdutório e inicia o quiz.
  void startQuiz() {
    showIntroCard.value = false;
  }

  /// Atualiza o índice da pergunta atual, conforme a visibilidade.
  void onItemVisibilityChanged(VisibilityInfo info, int index) {
    if (info.visibleFraction == 1.0 && currentQuestionIndex.value != index) {
      currentQuestionIndex.value = index;
    }
  }

  /// Salva a resposta (score) selecionada para a pergunta atual e atualiza o cache.
  void selectAnswer(int answerId) {
    selectedAnswers[currentQuestionIndex.value] = answerId;
    selectedAnswers.refresh(); // Garante a atualização reativa.
    _saveAnswers();
  }

  /// Retorna o score (id) da resposta selecionada para a pergunta de índice [questionIndex].
  /// Retorna null se nenhuma resposta tiver sido selecionada.
  int? currentAnswer(int questionIndex) {
    return selectedAnswers[questionIndex];
  }
}
