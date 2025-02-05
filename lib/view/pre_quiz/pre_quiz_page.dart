import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumacao_front/constants/app_constants.dart';
import 'package:rumacao_front/constants/font_family.dart';
import 'package:rumacao_front/view/global/action_button.dart';
import 'package:rumacao_front/view/global/footer.dart';
import 'package:rumacao_front/view/questions/questions_page.dart';

class PreQuizPage extends StatelessWidget {
  const PreQuizPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double dialogWidth = MediaQuery.of(context).size.width * 0.8;
    final double dialogHeight = MediaQuery.of(context).size.height * 0.5;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          const Spacer(),
          _popupDialog(dialogWidth, dialogHeight),
          const Spacer(),
          const Footer(),
        ],
      ),
    );
  }

  Widget _popupDialog(double width, double height) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: const Color(0xFF90A8ED), // Cor de fundo azul claro
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              _icon(),
              const SizedBox(height: 12),
              _welcomeText(),
              const SizedBox(height: 8),
              _instructionText(),
              const Spacer(),
              _startButton(),
              const SizedBox(height: 16),
            ],
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: _closeButton(),
        ),
      ],
    );
  }

  Widget _icon() {
    return const Text(
      "R", // Ícone estilizado da Rumação (substituir por um asset se necessário)
      style: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _welcomeText() {
    return Text(
      "Parabéns, (Nome)!",
      style: TextStyle(
        fontFamily: FontFamily.inter.name,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }

  Widget _instructionText() {
    return Text(
      "Tudo pronto para começarmos a atividade",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: FontFamily.inter.name,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    );
  }

  Widget _startButton() {
    return ActionButton(
      height: 40,
      width: 120,
      text: "INICIAR",
      onPressed: () {
        Get.to(() => QuestionsPage());
      },
    );
  }

  Widget _closeButton() {
    return GestureDetector(
      onTap: () {
        Get.back(); // Fecha o pop-up e volta para a tela anterior
      },
      child: const Icon(
        Icons.close,
        color: Colors.white,
        size: 24,
      ),
    );
  }
}
