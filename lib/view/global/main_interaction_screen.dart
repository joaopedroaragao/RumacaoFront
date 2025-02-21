import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumacao_front/constants/app_constants.dart';
import 'package:rumacao_front/view/global/base_interaction_screen_header.dart';
import 'package:rumacao_front/view/global/footer.dart';

class MainInteractionScreen extends StatefulWidget {
  final String headerText;
  final List<Widget> items;

  const MainInteractionScreen({
    super.key,
    required this.headerText,
    required this.items,
  });

  @override
  State<MainInteractionScreen> createState() => _MainInteractionScreenState();
}

class _MainInteractionScreenState extends State<MainInteractionScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    // Adiciona o observer para detectar mudanças nas métricas
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    // Força o rebuild quando as dimensões mudam (ex.: redimensionamento do navegador)
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: appBar,
      body: Column(
        children: [
          SizedBox(height: Get.height * 48/(800 * 3)),
          BaseInteractionScreenHeader(text: widget.headerText),
          ...widget.items,
          const Footer(),
        ],
      ),
    );
  }
}
