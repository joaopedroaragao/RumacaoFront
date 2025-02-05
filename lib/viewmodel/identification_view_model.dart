import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rumacao_front/constants/environment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IdentificationViewModel extends GetxController {
  var name = ''.obs;
  var email = ''.obs;

  var nameError = RxnString();
  var emailError = RxnString();
  var hasSubmitted = false.obs;

  // Variáveis para os checkboxes:
  var acceptTerms = false.obs;
  var acceptNewsletter = false.obs;

  var isSubmitting = false.obs; // Para mostrar o loading no botão

  void setName(String value) {
    name.value = value;
    if (hasSubmitted.value) validateName();
  }

  void setEmail(String value) {
    email.value = value;
    if (hasSubmitted.value) validateEmail();
  }

  void validateName() {
    nameError.value = name.value.isEmpty ? 'O campo de nome não pode estar vazio' : null;
  }

  void validateEmail() {
    emailError.value = isValidEmail(email.value) ? null : 'Formato de e-mail inválido';
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  Future<bool> validateForm() async {
    hasSubmitted.value = true;
    validateName();
    validateEmail();

    // Bloqueia o envio caso o usuário não aceite os termos
    if (!acceptTerms.value) return false;

    if (nameError.value == null && emailError.value == null) {
      await submit();
      return true;
    }
    return false;
  }

  /// Implementa o submit para enviar os dados para a API e salvar o userId no cache.
  Future<void> submit() async {
    isSubmitting.value = true;
    try {
      final url = "${Environment.baseUrl}/user";
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name.value,
          "email": email.value,
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        final userId = jsonResponse["userId"];
        // Salva o userId no cache (SharedPreferences)
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("userId", userId);
        print("Usuário identificado com userId: $userId");
      } else {
        print("Erro no submit: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro na requisição: $e");
    } finally {
      isSubmitting.value = false;
    }
  }
}
