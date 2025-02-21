// lib/view/results/shareable_content.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumacao_front/constants/font_family.dart';
import 'package:rumacao_front/constants/font_size.dart';
import 'package:rumacao_front/view/results/header_section.dart';
import 'package:rumacao_front/viewmodel/results_view_model.dart';

class ShareableContent extends StatelessWidget {
  final ResultsViewModel viewModel;
  const ShareableContent({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // AspectRatio 16:9 com conteúdo centralizado verticalmente
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const HeaderSection(),
              const SizedBox(height: 16),
              Image.asset(
                viewModel.mascotImage,
                height: max(Get.height / 3.5, Get.width / 4),
                fit: BoxFit.fitHeight,
              ),
              const SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width / 8),
                child: Text(
                  "Parabéns por concluir o nosso quiz! 🎉\n"
                      "Esperamos que você tenha se divertido e feito descobertas interessantes ao longo do caminho.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: FontFamily.inter.name,
                    fontSize: calculateFontSize(16),
                    color: const Color(0xFF494C6B),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
