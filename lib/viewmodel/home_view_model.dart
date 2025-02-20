import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rumacao_front/view/identification/identification_page.dart';
import 'package:rumacao_front/view/questions/questions_page.dart';

class HomeViewModel extends GetxController {
  Future<void> onStartButtonPressed() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString("userId");
    if (userId != null && userId.isNotEmpty) {
      // Se já existe um usuário identificado, vai direto para as perguntas.
      Get.to(() => const QuestionsPage());
    } else {
      // Caso contrário, vai para a tela de identificação.
      Get.to(() => IdentificationPage());
    }
  }
}
