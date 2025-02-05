// lib/view/results/header_section.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumacao_front/constants/app_constants.dart';
import 'package:rumacao_front/viewmodel/results_view_model.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ResultsViewModel resultsVM = Get.find<ResultsViewModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Obx(() {
        if (resultsVM.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (resultsVM.error.value != null) {
          return Center(
            child: Text(
              resultsVM.error.value!,
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          final data = resultsVM.scoreData;
          final userName = data['userName'] ?? "(Nome)";
          final quizTitle = data['quizTitle'] ?? "";
          return Column(
            children: [
              Text(
                "Parabéns, $userName!",
                style: AppStyles.titleStyle,
              ),
              const SizedBox(height: 8),
              Text(
                "Seu resultado foi",
                style: AppStyles.subtitleStyle,
              ),
              const SizedBox(height: 12),
              Text(
                quizTitle,
                style: AppStyles.resultTitleStyle,
              ),
            ],
          );
        }
      }),
    );
  }
}
