import 'package:flutter/material.dart';
import 'package:rumacao_front/constants/app_constants.dart';
import 'package:rumacao_front/view/global/main_interaction_screen.dart';
import 'package:rumacao_front/view/global/arc_slider.dart';
import 'package:rumacao_front/view/questions/question_card.dart';
import 'package:rumacao_front/view/questions/questions_progress_bar.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
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
        Expanded(
          flex: 10,
          child: QuestionCard()
        ),
        const Spacer(),
      ],
    );
  }
}
