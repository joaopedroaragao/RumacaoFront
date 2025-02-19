import 'dart:convert';
import 'package:flutter/foundation.dart';
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
  var acceptTerms = false.obs;
  var acceptNewsletter = false.obs;
  var isSubmitting = false.obs; // Estado para mostrar loading no botão

  // Getter para utilizar como isLoading
  RxBool get isLoading => isSubmitting;

  void setName(String value) {
    name.value = value;
    if (hasSubmitted.value) validateName();
  }

  void setEmail(String value) {
    email.value = value;
    if (hasSubmitted.value) validateEmail();
  }

  void validateName() {
    nameError.value =
    name.value.isEmpty ? 'O campo de nome não pode estar vazio' : null;
  }

  void validateEmail() {
    emailError.value =
    isValidEmail(email.value) ? null : 'Formato de e-mail inválido';
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  Future<bool> validateForm() async {
    hasSubmitted.value = true;
    validateName();
    validateEmail();

    if (!acceptTerms.value) return false; // Se os termos não foram aceitos, retorna false

    if (nameError.value == null && emailError.value == null) {
      await submit();
      return true;
    }
    return false;
  }

  /// Envia os dados para a API e salva userId, name e email no cache.
  Future<void> submit() async {
    isSubmitting.value = true;
    try {
      const url = "${Environment.baseUrl}/user";
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name.value,
          "email": email.value,
        }),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonResponse = jsonDecode(response.body);
        final userId = jsonResponse["userId"];
        // Salva os dados no cache
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("userId", userId);
        await prefs.setString("name", name.value);
        await prefs.setString("email", email.value);
        debugPrint("Usuário identificado com userId: $userId");
      } else {
        debugPrint("Erro no submit: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Erro na requisição: $e");
    } finally {
      isSubmitting.value = false;
    }
  }
}
