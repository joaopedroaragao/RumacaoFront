import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumacao_front/constants/app_constants.dart';
import 'package:rumacao_front/view/global/action_button.dart';
import 'package:rumacao_front/view/global/footer.dart';
import 'package:rumacao_front/view/home/home_page.dart';
import 'package:rumacao_front/view/results/header_section.dart';
import 'package:rumacao_front/view/results/percentage_tile.dart';
import 'package:rumacao_front/view/results/result_section.dart';
import 'package:rumacao_front/viewmodel/results_view_model.dart';

class ResultsPage extends StatefulWidget {
  final String responseId;
  const ResultsPage({Key? key, required this.responseId}) : super(key: key);

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  late ResultsViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = Get.put(ResultsViewModel(responseId: widget.responseId));
  }

  @override
  Widget build(BuildContext context) {
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
          Expanded( // Garante que o ListView não cause overflow
            child: ListView(
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
                    return Column(children: [
                      PercentageTile(
                        title: "Educação Ambiental",
                        percentage: viewModel.scoreData["areaPercentages"]["Educação"]?.toString() ?? "0.0",
                        color: const Color(0xFFEA5EB5),
                      ),
                      const SizedBox(height: 16),
                      PercentageTile(
                        title: "Ciência",
                        percentage: viewModel.scoreData["areaPercentages"]["Ciência"]?.toString() ?? "0.0",
                        color: const Color(0xFFFE8F38),
                      ),
                      const SizedBox(height: 16),
                      PercentageTile(
                        title: "Cultura",
                        percentage: viewModel.scoreData["areaPercentages"]["Cultura"]?.toString() ?? "0.0",
                        color: const Color(0xFFFFDB4F),
                      ),
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
          ),
          const Footer(),
        ],
      ),
    );
  }
}
