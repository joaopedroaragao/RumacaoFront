// lib/view/results/results_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumacao_front/constants/app_constants.dart';
import 'package:rumacao_front/view/global/action_button.dart';
import 'package:rumacao_front/view/global/footer.dart';
import 'package:rumacao_front/view/home/home_page.dart';
import 'package:rumacao_front/view/results/header_section.dart';
import 'package:rumacao_front/view/results/result_section.dart';
import 'package:rumacao_front/viewmodel/results_view_model.dart';

class ResultsPage extends StatelessWidget {
  final String responseId;
  const ResultsPage({Key? key, required this.responseId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Instancia o ResultsViewModel passando o responseId
    final viewModel = ResultsViewModel(responseId: responseId);
    Get.put(viewModel);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(AppStrings.headerLogo),
        leading: Container(),
      ),
      body: Column(
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(height: 16),
              Obx(() {
                if (viewModel.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (viewModel.error.value != null) {
                  return Center(
                    child: Text(
                      viewModel.error.value!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else {
                  return const Column(children: [
                    HeaderSection(),
                    ResultSection(),
                  ]);
                }
              }),
              const SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ActionButton(
                    text: "VOLTAR À TELA INICIAL",
                    height: 51,
                    width: null,
                    onPressed: () {
                      Get.to(() => const HomePage());
                    },
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          const Footer(),
        ],
      ),
    );
  }
}
