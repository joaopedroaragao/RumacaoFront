// lib/view/results/results_page.dart
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:rumacao_front/constants/app_constants.dart';
import 'package:rumacao_front/constants/font_family.dart';
import 'package:rumacao_front/constants/font_size.dart';
import 'package:rumacao_front/view/global/action_button.dart';
import 'package:rumacao_front/view/global/footer.dart';
import 'package:rumacao_front/view/home/home_page.dart';
import 'package:rumacao_front/view/results/header_section.dart';
import 'package:rumacao_front/view/results/result_section.dart';
import 'package:rumacao_front/viewmodel/results_view_model.dart';
import 'package:rumacao_front/view/global/export_image.dart';

class ResultsPage extends StatefulWidget {
  final String responseId;
  const ResultsPage({Key? key, required this.responseId}) : super(key: key);

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> with WidgetsBindingObserver {
  late ResultsViewModel viewModel;
  // Largura base ideal para o layout
  final double baseWidth = 410;
  // Chave para capturar o conteúdo compartilhável (agora usando Opacity para que ele seja pintado)
  final GlobalKey _shareKey = GlobalKey();

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
    // Atualiza a tela quando as métricas mudam
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double scale = Get.width / baseWidth;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      // Utilizamos um Stack para manter o widget compartilhável "oculto" mas pintado
      body: Stack(
        children: [
          RepaintBoundary(
            key: _shareKey,
            child: ShareableView(viewModel: viewModel),
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 16 * scale),
                        const HeaderSection(),
                        SizedBox(height: 16 * scale),
                        // Imagem do mascote conforme o ResultType
                        Obx(() {
                          return Image.asset(
                            viewModel.mascotImage,
                            height: max(Get.height / 3, Get.width / 3.5),
                            fit: BoxFit.fitHeight,
                          );
                        }),
                        SizedBox(height: 16 * scale),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: Get.width / 8),
                          child: Text(
                            "Parabéns por concluir o nosso quiz! 🎉\n"
                                "Esperamos que você tenha se divertido e feito descobertas interessantes ao longo do caminho.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: FontFamily.inter.name,
                              fontSize: calculateFontSize(14),
                              color: const Color(0xFF494C6B),
                              height: 1.4,
                            ),
                          ),
                        ),
                        Obx(() {
                          final isInconclusive = viewModel.resultType.value == ResultType.INCONCLUSIVE;
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 16 * scale/(isInconclusive ? 1 : 2)),
                            color: Colors.white,
                            child: SizedBox(
                              width: min(max(420, Get.width / 3), Get.width - 32),
                              child: isInconclusive ? null : const ResultSection(),
                            ),
                          );
                        }),
                        // Botão para voltar à tela inicial (não faz parte da imagem compartilhada)
                        Obx(() {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ActionButton(
                                    text: "VOLTAR À TELA INICIAL",
                                    height: 51,
                                    width: null,
                                    onPressed: () {
                                      Get.offAll(() => const HomePage());
                                    },
                                  ),
                                  if (viewModel.resultType.value != null)...[
                                    const SizedBox(width: 4),
                                    SizedBox(
                                      width: 51,
                                      height: 51,
                                      child: IconButton(
                                        style: IconButton.styleFrom(
                                          backgroundColor: AppColors.startButton,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        onPressed: _share,
                                        icon: const Icon(Icons.download),
                                      ),
                                    )
                                  ]
                                ],
                              ),
                            );
                          }
                        ),
                      ],
                    ),
                  ),
                ),
                const Footer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Função que decide o método de compartilhamento com base na plataforma.
  Future<void> _share() async {
    await downloadShareableContent(_shareKey);
  }
}

/// Widget que reproduz o conteúdo compartilhável.
/// Ele inclui a app bar e o conteúdo (Header, imagem do mascote e mensagem),
/// disposto em um AspectRatio 16:9, sem a seção de resultados, footer e botão de voltar.
class ShareableView extends StatelessWidget {
  final ResultsViewModel viewModel;
  const ShareableView({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      // Garante aparência de uma tela inteira
      color: Colors.white,
      child: Column(
        children: [
          // Réplica da AppBar
          Container(
            height: kToolbarHeight,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  offset: const Offset(0, -1), // define o deslocamento da sombra
                  blurRadius: 6, // define o blur da sombra
                ),
              ],
            ),
            child: Image.asset(AppStrings.headerLogo),
          ),
          const Spacer(flex: 2),
          const HeaderSection(),
          const Spacer(),
          // Imagem do mascote conforme o ResultType
          Obx(() {
            return Image.asset(
              viewModel.mascotImage,
              height: max(Get.height / 3.5, Get.width / 4),
              fit: BoxFit.fitHeight,
            );
          }),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width / 8),
            child: Text(
              "Parabéns por concluir o nosso quiz! 🎉\n"
                  "Esperamos que você tenha se divertido e feito descobertas interessantes ao longo do caminho.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: FontFamily.inter.name,
                fontSize: calculateFontSize(14),
                color: const Color(0xFF494C6B),
                height: 1.4,
              ),
            ),
          ),
          const Spacer(flex: 4),
        ],
      ),
    );
  }
}