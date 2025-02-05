import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rumacao_front/constants/environment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultsViewModel extends GetxController {
  final String responseId;
  ResultsViewModel({required this.responseId});

  var isLoading = true.obs;
  var scoreData = {}.obs;
  var error = RxnString();

  /// Nome do usuário (carregado do cache)
  var userName = ''.obs;

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

  /// Faz a requisição GET para carregar os dados do resultado.
  Future<void> fetchScore() async {
    try {
      final url = "${Environment.baseUrl}/score/$responseId";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(response.body);
        scoreData.value = data;
        print(data);
      } else {
        error.value = "Erro ao carregar o resultado: ${response.statusCode}";
      }
    } catch (e) {
      error.value = "Erro na requisição: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
