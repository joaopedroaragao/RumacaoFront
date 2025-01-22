import 'package:flutter/material.dart';
import 'package:rumacao_front/constants/app_constants.dart';
import 'package:rumacao_front/view/global/main_interaction_screen.dart';
import 'package:rumacao_front/view/questions/questions_progress_bar.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int red = 255;
  int green = 0;
  int blue = 0;

  double progress = 0.0; // Progresso do pan (0.0 a 1.0)

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return MainInteractionScreen(
      headerText: "A escola é o principal caminho para combater desigualdades",
      items: [
        const SizedBox(height: 32),
        SizedBox(
          width: screenWidth * 0.92,
          child: const QuestionsProgressBar(
            progress: 0.1,
            themeColor: AppColors.startButton,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              // Atualiza o progresso com base no movimento horizontal
              progress = (progress + details.delta.dx / (screenWidth / 2)).clamp(0.0, 1.0);
              updateColor(progress);
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Color.fromRGBO(red, green, blue, 1),
            ),
            height: 400,
            width: screenWidth * 0.75,
          ),
        ),
        const Spacer(),
      ],
    );
  }

  /// Atualiza a cor do container com base no progresso
  void updateColor(double progress) {
    if (progress < 0.2) {
      // Vermelho para laranja
      red = 255;
      green = (progress / 0.2 * 165).toInt();
      blue = 0;
    } else if (progress < 0.4) {
      // Laranja para amarelo
      red = 255;
      green = 165 + ((progress - 0.2) / 0.2 * 90).toInt();
      blue = 0;
    } else if (progress < 0.6) {
      // Amarelo para verde claro
      red = 255 - ((progress - 0.4) / 0.2 * 255).toInt();
      green = 255;
      blue = 0;
    } else if (progress < 0.8) {
      // Verde claro para verde médio
      red = 0;
      green = 255;
      blue = ((progress - 0.6) / 0.2 * 128).toInt();
    } else {
      // Verde médio para verde escuro
      red = 0;
      green = 255 - ((progress - 0.8) / 0.2 * 100).toInt();
      blue = ((progress - 0.8) / 0.2 * 50).toInt();
    }
  }
}
