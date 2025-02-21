import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumacao_front/constants/app_constants.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final double appBarHeight = Scaffold.of(context).appBarMaxHeight ?? 0;

    const double baseHeight = 620;
    const double minRatio = 2.0;
    const double maxRatio = 2.5;

    // Fator exponencial para aumentar a agressividade da interpolação
    const double exponent = 20;

    // Normaliza a altura da tela no intervalo [100, baseHeight]
    double normalized = (screenHeight - 100) / (baseHeight - 100);
    normalized = pow(normalized, exponent).toDouble().clamp(0.0, 1.0);

    // Aplica a interpolação agressiva
    final double ratio = minRatio + (maxRatio - minRatio) * (1 - normalized);
    final height = screenHeight / ratio - appBarHeight;

    return Container(
      width: double.infinity,
      color: Colors.grey.shade300,
      child: Center(
        child: Image.asset(
          width: double.infinity,
          AppStrings.rumaSplash,
          height:  max(height, 125),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
