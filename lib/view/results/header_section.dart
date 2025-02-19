// lib/view/results/header_section.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumacao_front/viewmodel/results_view_model.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ResultsViewModel resultsVM = Get.find<ResultsViewModel>();

    return Obx(() {
      if (resultsVM.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (resultsVM.error.value != null) {
        return Center(
          child: Text(
            resultsVM.error.value!,
            style: const TextStyle(color: Colors.red),
          ),
        );
      } else if (resultsVM.scoreData.value == null) {
        return const Center(child: Text("Nenhum dado encontrado."));
      } else {
        final userName = resultsVM.userName.value;
        final quizTitle = resultsVM.quizTitle.value; // Maior(es) área(s)
        return Column(
          children: [
            Text(
              "Parabéns, $userName!\nSeu resultado foi",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF494C6B)
              ),
            ),
            const SizedBox(height: 12),
            Text(
              quizTitle, // Ex: "Educação Ambiental" ou "Educação Ambiental / Ciência"
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      }
    });
  }
}
