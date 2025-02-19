import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rumacao_front/constants/environment.dart';
import 'package:rumacao_front/model/question.dart';
import 'package:rumacao_front/view/results/results_page.dart';
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

  /// Nome do usuário (recuperado do cache).
  var userName = ''.obs;

  /// Flag para bloquear a tela enquanto submete as respostas.
  var isSubmittingResponses = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadCachedAnswers();
    _loadCachedQuestions();
    _loadUserName(); // Carrega o nome do usuário do cache
    _loadQuestions();
  }

  /// Carrega o nome do usuário do cache.
  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    userName.value = prefs.getString("name") ?? "";
  }

  /// Carrega as respostas salvas do cache.
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

  /// Carrega as questões salvas do cache.
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

  /// Consome as questões da API e as salva no cache.
  /// Consome as questões da API e as salva no cache.
  void _loadQuestions() async {
    final url = "${Environment.baseUrl}/quiz/cXNZNJc3HOu7N2faYqgo";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Supondo que a resposta possua uma chave 'questions' com uma lista de questões:
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

    // Ajusta o currentQuestionIndex para a primeira pergunta não respondida,
    // ou, se todas já estiverem respondidas, para a última.
    if (questions.isNotEmpty) {
      final unansweredEntry = questions.asMap().entries.firstWhere(
            (entry) => !selectedAnswers.containsKey(entry.key),
        orElse: () => MapEntry(questions.length - 1, questions.last),
      );
      currentQuestionIndex.value = unansweredEntry.key;
    }

    isLoading.value = false;
  }

  /// Remove o card introdutório e inicia o quiz.
  void startQuiz() {
    showIntroCard.value = false;
  }

  /// Atualiza o índice da pergunta atual conforme a visibilidade.
  void onPageChanged(int index) {
    if (currentQuestionIndex.value != index) {
      currentQuestionIndex.value = index;
    }
  }

  /// Salva a resposta (score) selecionada para a pergunta atual e atualiza o cache.
  void selectAnswer(int answerId) {
    selectedAnswers[currentQuestionIndex.value] = answerId;
    selectedAnswers.refresh();
    _saveAnswers();
  }

  /// Retorna o score (id) da resposta selecionada para a pergunta de índice [questionIndex].
  /// Retorna null se nenhuma resposta tiver sido selecionada.
  int? currentAnswer(int questionIndex) {
    return selectedAnswers[questionIndex];
  }

  /// Submete as respostas do quiz.
  /// Os dados são enviados via POST para o endpoint /response no formato:
  ///
  /// {
  ///   "quizId": "string",
  ///   "userId": "string",
  ///   "answers": [
  ///     { "questionId": "string", "value": 0 }
  ///   ]
  /// }
  ///
  /// Se a resposta for bem-sucedida (status entre 200 e 299),
  /// o responseId é salvo no cache e a navegação é feita para a página de resultados,
  /// que deverá carregar os dados do endpoint /score/{responseId}.
  Future<void> submitResponses(String quizId) async {
    isSubmittingResponses.value = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString("userId");
      if (userId == null) {
        throw Exception("Usuário não identificado");
      }
      // Constrói a lista de respostas. (Assumindo que cada Question possui um campo 'id' do tipo String)
      final List<Map<String, dynamic>> answers = [];
      for (int i = 0; i < questions.length; i++) {
        final question = questions[i];
        final answerValue = selectedAnswers[i] ?? 0;
        answers.add({
          "questionId": question.questionId,
          "value": answerValue,
        });
      }
      final body = jsonEncode({
        "quizId": quizId,
        "userId": userId,
        "answers": answers,
      });
      final response = await http.post(
        Uri.parse("${Environment.baseUrl}/response"),
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonResponse = jsonDecode(response.body);
        final responseId = jsonResponse["responseId"];
        // Salva o responseId no cache.
        await prefs.setString("responseId", responseId);
        // Navega para a página de resultados, que deverá carregar o resultado pelo endpoint /score/{responseId}.
        Get.to(() => ResultsPage(responseId: responseId));
      } else {
        Get.defaultDialog(
            title: "Erro", middleText: "Erro ao enviar as respostas.");
      }
    } catch (e) {
      Get.defaultDialog(
          title: "Erro", middleText: "Erro ao enviar as respostas.");
    } finally {
      isSubmittingResponses.value = false;
    }
  }
}
