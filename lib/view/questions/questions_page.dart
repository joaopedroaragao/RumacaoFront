import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumacao_front/constants/app_constants.dart';
import 'package:rumacao_front/constants/font_family.dart';
import 'package:rumacao_front/model/answer_option.dart';
import 'package:rumacao_front/view/global/action_button.dart';
import 'package:rumacao_front/view/global/footer.dart';
import 'package:rumacao_front/view/home/home_page.dart';
import 'package:rumacao_front/view/questions/option_selector.dart';
import 'package:rumacao_front/view/questions/questions_carousel.dart';
import 'package:rumacao_front/view/questions/questions_progress_bar.dart';
import 'package:rumacao_front/viewmodel/questions_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key});

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  final answerOptions = [
    AnswerOption(id: 0, label: "Discordo"),
    AnswerOption(id: 1, label: ""),
    AnswerOption(id: 2, label: ""),
    AnswerOption(id: 3, label: ""),
    AnswerOption(id: 4, label: "Concordo"),
  ];

  final images = [
    AppStrings.mascoteImages.totallyDisagree3,
    AppStrings.mascoteImages.partiallyDisagree3,
    AppStrings.mascoteImages.neutral3,
    AppStrings.mascoteImages.partiallyAgree3,
    AppStrings.mascoteImages.totallyAgree3,
  ];

  // Mapeia um AnswerOption para um OptionButton (aspectos visuais)
  OptionButton buildOptionButton(AnswerOption option) {
    switch (option.id) {
      case 0:
        return OptionButton(
          borderWidth: 3,
          size: 55,
          borderColor: Colors.blue,
          backgroundColor: const Color(0xFFD9D9D9),
          selectedColor: Colors.blue,
          label: option.label,
        );
      case 1:
        return OptionButton(
          borderWidth: 3,
          size: 45,
          borderColor: Colors.blue.shade300,
          backgroundColor: const Color(0xFFD9D9D9),
          selectedColor: Colors.blue.shade300,
          label: option.label,
        );
      case 2:
        return OptionButton(
          borderWidth: 3,
          size: 40,
          borderColor: Colors.grey,
          backgroundColor: const Color(0xFFD9D9D9),
          selectedColor: Colors.grey,
          label: option.label,
        );
      case 3:
        return OptionButton(
          borderWidth: 3,
          size: 45,
          borderColor: Colors.pink.shade300,
          backgroundColor: const Color(0xFFD9D9D9),
          selectedColor: Colors.pink.shade300,
          label: option.label,
        );
      case 4:
        return OptionButton(
          borderWidth: 3,
          size: 55,
          borderColor: Colors.pink,
          backgroundColor: const Color(0xFFD9D9D9),
          selectedColor: Colors.pink,
          label: option.label,
        );
      default:
        return OptionButton(
          borderWidth: 3,
          size: 40,
          borderColor: Colors.grey,
          backgroundColor: const Color(0xFFD9D9D9),
          selectedColor: Colors.grey,
          label: option.label,
        );
    }
  }

  /// Card azul pré-quiz (exibe o nome do usuário vindo do QuestionViewModel)
  Widget _preQuizCard(BuildContext context, QuestionViewModel viewModel) {
    final double dialogWidth = MediaQuery.of(context).size.width * 0.8;
    final double dialogHeight = MediaQuery.of(context).size.height * 0.5;
    return Center(
      child: Container(
        width: dialogWidth,
        height: dialogHeight,
        decoration: BoxDecoration(
          color: const Color(0xFF90A8ED),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 3),
            _icon(),
            const Spacer(),
            _welcomeText(),
            const Spacer(),
            _instructionText(),
            const Spacer(flex: 2),
            Obx(() {
              if (viewModel.isLoading.value) {
                return const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                );
              } else {
                return ActionButton(
                  height: 51,
                  width: 159,
                  text: "INICIAR",
                  onPressed: () {
                    viewModel.startQuiz();
                  },
                );
              }
            }),
            const Spacer(flex: 2)
          ],
        ),
      ),
    );
  }

  Widget _icon() {
    return Image.asset(
      AppStrings.rumacaoIcon,
      height: 86,
      width: 67,
    );
  }

  /// _welcomeText_ utiliza o valor do nome vindo do view model.
  Widget _welcomeText() {
    return Obx(() {
      final name = Get.find<QuestionViewModel>().userName.value.isNotEmpty
          ? Get.find<QuestionViewModel>().userName.value
          : "(Nome)";
      return Text(
        "Parabéns, $name!",
        style: TextStyle(
          fontFamily: FontFamily.inter.name,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      );
    });
  }

  Widget _instructionText() {
    return Text(
      "Tudo pronto para começarmos a atividade",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: FontFamily.inter.name,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    );
  }

  /// Container com altura fixa para o texto da pergunta.
  Widget _questionText(QuestionViewModel viewModel) {
    const double fixedHeight = 80;
    if (viewModel.questions.isEmpty) return const SizedBox(height: fixedHeight);
    final currentQuestion = viewModel.questions[viewModel.currentQuestionIndex.value];
    return Container(
      height: fixedHeight,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: Get.width / 8),
      child: Text(
        currentQuestion.text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: FontFamily.inter.name,
          fontSize: Get.height * 0.025,
          fontWeight: FontWeight.w500,
        ),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  /// Conteúdo completo do quiz (sem o Footer) – exibido após tocar em INICIAR
  Widget _quizContent(BuildContext context, QuestionViewModel viewModel) {
    return Column(
      children: [
        const Spacer(),
        Obx(() => _questionText(viewModel)),
        const Spacer(),
        Expanded(
          flex: 20,
          child: Obx(() => QuestionsCarousel(
            length: viewModel.questions.length,
            currentIndex: viewModel.currentQuestionIndex.value, // Adicionado
            itemBuilder: (context, index, realIndex) {
              return Obx(
                    () => Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    viewModel.currentAnswer(index) != null
                        ? images[viewModel.currentAnswer(index)!]
                        : AppStrings.mascoteImages.neutral1,
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            onVisibilityChanged: (info, index) {
              viewModel.onItemVisibilityChanged(info, index);
            },
          )),
        ),
        const Spacer(),
        Expanded(
          flex: 6,
          child: Obx(() {
            final currentIndex = viewModel.currentQuestionIndex.value;
            if (viewModel.questions.isEmpty) return Container();
            final int? selectedAnswerId = viewModel.selectedAnswers[currentIndex];
            final selectedOptionIndex = answerOptions.indexWhere(
                  (option) => option.id == selectedAnswerId,
            );
            final int? selectedIndex = selectedOptionIndex >= 0 ? selectedOptionIndex : null;

            return OptionSelector(
              spacing: 32,
              options: answerOptions.map(buildOptionButton).toList(),
              selectedIndex: selectedIndex,
              onSelected: (optionIndex) {
                final option = answerOptions[optionIndex];
                viewModel.selectAnswer(option.id);
                setState(() {});
              },
            );
          }),
        ),
        const Spacer(),
        // Botão FINALIZAR sempre presente, visível somente se todas as questões tiverem resposta.
        Obx(() {
          final bool allAnswered = viewModel.questions.isNotEmpty &&
              viewModel.selectedAnswers.length == viewModel.questions.length;
          return Visibility(
            visible: allAnswered,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: ActionButton(
              height: 51,
              width: 159,
              text: "FINALIZAR",
              onPressed: () {
                viewModel.submitResponses("cXNZNJc3HOu7N2faYqgo");
              },
            ),
          );
        }),
        const Spacer(flex: 2),
        // Cálculo do progresso conforme a fórmula solicitada:
        Obx(() {
          double progress = 0.0;
          if (viewModel.questions.length > 1) {
            final current = viewModel.currentQuestionIndex.value;
            final total = viewModel.questions.length - 1;
            final offset = sqrt(total) / 100;
            progress = min(current / total + offset, 1);
          } else if (viewModel.questions.isNotEmpty) {
            progress = 1;
          }
          return QuestionsProgressBar(
            progress: progress,
            themeColor: Colors.orange,
            height: MediaQuery.of(context).size.height * 0.03,
          );
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final QuestionViewModel viewModel = Get.put(QuestionViewModel());
    return Obx(() {
      return Stack(
        children: [
          Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              backgroundColor: AppColors.white,
              elevation: 0,
              centerTitle: true,
              title: Image.asset(AppStrings.headerLogo),
              leading: Container(),
            ),
            body: Column(
              children: [
                Expanded(
                  child: viewModel.showIntroCard.value
                      ? _preQuizCard(context, viewModel)
                      : _quizContent(context, viewModel),
                ),
                // const Footer(),
              ],
            ),
          ),
          // Overlay de loading para bloquear a interação enquanto submete as respostas.
          if (viewModel.isSubmittingResponses.value)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}
