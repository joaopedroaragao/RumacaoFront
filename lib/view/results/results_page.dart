import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumacao_front/constants/app_constants.dart';
import 'package:rumacao_front/constants/font_family.dart';
import 'package:rumacao_front/view/global/action_button.dart';
import 'package:rumacao_front/view/global/footer.dart';
import 'package:rumacao_front/view/home/home_page.dart';
import 'package:rumacao_front/view/results/header_section.dart';
import 'package:rumacao_front/view/results/result_section.dart';
import 'package:rumacao_front/viewmodel/results_view_model.dart';

class ResultsPage extends StatefulWidget {
  final String responseId;
  const ResultsPage({super.key, required this.responseId});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> with WidgetsBindingObserver {
  late ResultsViewModel viewModel;

  // Define uma largura base ideal para o layout (por exemplo, 390)
  final double baseWidth = 410;

  @override
  void initState() {
    super.initState();
    viewModel = Get.put(ResultsViewModel(responseId: widget.responseId));
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    // Chamado sempre que as métricas (tamanho da tela, por exemplo) mudam.
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Calcula um fator de escala com base na largura atual comparada à base ideal.
    final double scale = Get.width / baseWidth;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(AppStrings.headerLogo),
        leading: const SizedBox.shrink(),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 16 * scale),
                  const HeaderSection(),
                  SizedBox(height: 16 * scale),
                  // Mascote: ajuste a altura proporcional à largura
                  Image.asset(
                    AppStrings.mascoteImages.neutral3,
                    height: max(Get.height / 3.5, Get.width / 4),
                    fit: BoxFit.fitHeight,
                  ),
                  SizedBox(height: 16 * scale),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width / 8),
                    child: Text(
                      "Parabéns por concluir o nosso quiz! 🎉\n"
                          "Esperamos que você tenha se divertido e feito descobertas "
                          "interessantes ao longo do caminho.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: FontFamily.inter.name,
                        fontSize: 16,
                        color: const Color(0xFF494C6B),
                        height: 1.4,
                      ),
                    ),
                  ),
                  SizedBox(height: 16 * scale),
                  Container(
                    color: Colors.white,
                    child: SizedBox(
                      width: max(320, Get.width / 3),
                      child: const ResultSection(),
                    ),
                  ),
                  SizedBox(height: 16 * scale),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ActionButton(
                      text: "VOLTAR À TELA INICIAL",
                      height: 51,
                      width: null,
                      onPressed: () {
                        Get.offAll(() => const HomePage());
                      },
                    ),
                  ),
                  SizedBox(height: 32 * scale),
                  const Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
