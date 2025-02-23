import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumacao_front/constants/app_constants.dart';

class HeaderSection extends StatefulWidget {
  const HeaderSection({super.key});

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    setState(() {});
  }

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

    final aspectRatio = height / Get.width;
    print(aspectRatio);

    return Container(
      width: double.infinity,
      color: Colors.grey.shade300,
      child: Center(
        child: Image.asset(
          aspectRatio < 0.44
              ? (aspectRatio > 0.35 ? AppStrings.rumaSplashExpandedWidth : AppStrings.rumaSplashExtendedWidth)
              : AppStrings.rumaSplash,
          width: double.infinity,
          height: max(height, 125),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
