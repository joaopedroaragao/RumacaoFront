import 'package:get/get.dart';

class IdentificationViewModel extends GetxController {
  var name = ''.obs;
  var email = ''.obs;

  var nameError = RxnString();
  var emailError = RxnString();
  var hasSubmitted = false.obs; // Controla se o botão de submit foi pressionado

  // Define o nome e valida se necessário
  void setName(String value) {
    name.value = value;

    if (hasSubmitted.value) {
      validateName();
    }
  }

  // Define o e-mail e valida se necessário
  void setEmail(String value) {
    email.value = value;

    if (hasSubmitted.value) {
      validateEmail();
    }
  }

  // Validação do nome
  void validateName() {
    if (name.value.isEmpty) {
      nameError.value = 'O campo de nome não pode estar vazio';
    } else {
      nameError.value = null;
    }
  }

  // Validação do e-mail
  void validateEmail() {
    if (!isValidEmail(email.value)) {
      emailError.value = 'Formato de e-mail inválido';
    } else {
      emailError.value = null;
    }
  }

  // Verifica se o e-mail está em um formato válido
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  // Valida todo o formulário ao pressionar o botão de submit
  bool validateForm() {
    hasSubmitted.value = true; // Ativa a validação dos campos

    validateName();
    validateEmail();

    if (nameError.value == null && emailError.value == null) {
      submit();
      return true;
    } else {
      return false;
    }
  }

  // Simula o envio do formulário
  void submit() {
    // Lógica para enviar os dados (ex.: para uma API)
    print('Nome: ${name.value}, Email: ${email.value}');
  }
}
