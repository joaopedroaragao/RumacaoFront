import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumacao_front/constants/app_constants.dart';
import 'package:rumacao_front/constants/font_family.dart';
import 'package:rumacao_front/constants/font_size.dart'; // Importa a função calculateFontSize
import 'package:rumacao_front/model/answer_option.dart';
import 'package:rumacao_front/view/global/action_button.dart';
import 'package:rumacao_front/view/global/footer.dart';
import 'package:rumacao_front/view/questions/option_selector.dart';
import 'package:rumacao_front/view/questions/questions_carousel.dart';
import 'package:rumacao_front/view/questions/questions_progress_bar.dart';
import 'package:rumacao_front/viewmodel/questions_view_model.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key});

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;
  late Animation<double> _expandAnimation;

  int? _animateIndex; // Índice do item do carousel que deve animar
  late Animation<double> _animation = _bounceAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // TweenSequence para simular uma bola quicando com "pulsos" decrescentes.
    _bounceAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: -60)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: -60, end: 0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: -30)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: -30, end: 0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: -15)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 10,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: -15, end: 0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 10,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: -7)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 5,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: -7, end: 0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 5,
      ),
    ]).animate(_controller);

    _expandAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1, end: 1.1)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.1, end: 1)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 20,
      ),
    ]).animate(_controller);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _animateIndex = null;
          _animation = _bounceAnimation;
        });
      }
    });
  }

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

  OptionButton buildOptionButton(AnswerOption option) {
    switch (option.id) {
      case 0:
        return OptionButton(
          size: 55,
          backgroundColor: const Color(0xFF7E96EC).withOpacity(0.45),
          selectedColor: const Color(0xFF7E96EC),
          label: option.label,
        );
      case 1:
        return OptionButton(
          size: 45,
          backgroundColor: const Color(0xFFA98EED).withOpacity(0.45),
          selectedColor: const Color(0xFFA98EED),
          label: option.label,
        );
      case 2:
        return OptionButton(
          size: 40,
          backgroundColor: const Color(0xFFC591ED).withOpacity(0.45),
          selectedColor: const Color(0xFFC591ED),
          label: option.label,
        );
      case 3:
        return OptionButton(
          size: 45,
          backgroundColor: const Color(0xFFCE73EA).withOpacity(0.45),
          selectedColor: const Color(0xFFCE73EA),
          label: option.label,
        );
      case 4:
        return OptionButton(
          size: 55,
          backgroundColor: const Color(0xFFEA5EB5).withOpacity(0.45),
          selectedColor: const Color(0xFFEA5EB5),
          label: option.label,
        );
      default:
        return OptionButton(
          size: 40,
          backgroundColor: const Color(0xFFD9D9D9),
          selectedColor: Colors.grey,
          label: option.label,
        );
    }
  }

  Widget _preQuizCard(BuildContext context, QuestionViewModel viewModel) {
    final double dialogWidth = MediaQuery.of(context).size.width * 0.8;
    final double dialogHeight = MediaQuery.of(context).size.height * 0.5;
    return Center(
      child: Container(
        width: dialogWidth,
        height: dialogHeight,
        padding: const EdgeInsets.all(16),
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
            const Spacer(flex: 2),
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

  Widget _welcomeText() {
    return Obx(() {
      final name = Get.find<QuestionViewModel>().userName.value.isNotEmpty
          ? Get.find<QuestionViewModel>().userName.value
          : "(Nome)";
      return Text(
        "Parabéns, $name!",
        style: TextStyle(
          fontFamily: FontFamily.inter.name,
          fontSize: calculateFontSize(18).roundToDouble(),
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
        fontSize: calculateFontSize(15).roundToDouble(),
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    );
  }

  Widget _questionText(QuestionViewModel viewModel) {
    final double fixedHeight = Get.height * 0.13;
    if (viewModel.questions.isEmpty) return SizedBox(height: fixedHeight);
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
          fontSize: calculateFontSize(16).roundToDouble(),
          fontWeight: FontWeight.w500,
        ),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _quizContent(BuildContext context, QuestionViewModel viewModel) {
    // Calcula o índice da última pergunta respondida (se nenhum, -1)
    int lastAnswered = viewModel.selectedAnswers.isEmpty
        ? -1
        : viewModel.selectedAnswers.keys.reduce(max);

    return Column(
      children: [
        const Spacer(flex: 2),
        Obx(() => _questionText(viewModel)),
        const Spacer(),
        Expanded(
          flex: 15,
          child: Obx(() => QuestionsCarousel(
            length: viewModel.questions.length,
            initialPage: max(0, min(lastAnswered + 1, viewModel.questions.length - 1)),
            lastAnsweredIndex: lastAnswered,
            onSwipeForwardBlocked: () {
              if (viewModel.selectedAnswers[viewModel.currentQuestionIndex.value] == null) {
                setState(() {
                  _animateIndex = viewModel.currentQuestionIndex.value;
                  _animation = _expandAnimation;
                });
                _controller.reset();
                _controller.forward();
              }
            },
            itemBuilder: (context, index, realIndex) {
              Widget imageWidget = Image.asset(
                viewModel.currentAnswer(index) != null
                    ? images[viewModel.currentAnswer(index)!]
                    : AppStrings.mascoteImages.neutral1,
                width: 350,
                height: 350,
                fit: BoxFit.cover,
              );
              Widget animatedImage = AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: imageWidget
              );
              if (_animateIndex != null && index == _animateIndex) {
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return _animation == _expandAnimation
                        ? Transform.scale(
                      scale: _expandAnimation.value,
                      child: child,
                    )
                        : Transform.translate(
                      offset: Offset(0, _bounceAnimation.value),
                      child: child,
                    );
                  },
                  child: animatedImage,
                );
              }
              return animatedImage;
            },
            onPageChanged: (index) => viewModel.onPageChanged(index),
            onInstantlyPageChange: (index) => viewModel.onPageChanged(index),
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
            return Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 10,
                  child: OptionSelector(
                    options: answerOptions.map(buildOptionButton).toList(),
                    selectedIndex: selectedIndex,
                    onSelected: (optionIndex) {
                      final option = answerOptions[optionIndex];
                      if (viewModel.currentQuestionIndex.value == 0 &&
                          viewModel.selectedAnswers[0] == null) {
                        setState(() {
                          _animateIndex = viewModel.currentQuestionIndex.value + 1;
                          _animation = _bounceAnimation;
                        });
                        _controller.reset();
                        _controller.forward();
                      }
                      viewModel.selectAnswer(option.id);
                    },
                  ),
                ),
                const Spacer(),
              ],
            );
          }),
        ),
        const Spacer(),
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
      bool blockInteractions = _controller.isAnimating;
      return Stack(
        children: [
          Scaffold(
            backgroundColor: AppColors.white,
            appBar: appBar,
            body: Column(
              children: [
                Expanded(
                  child: viewModel.showIntroCard.value
                      ? _preQuizCard(context, viewModel)
                      : _quizContent(context, viewModel),
                ),
                if (viewModel.showIntroCard.value) const Footer(),
              ],
            ),
          ),
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
          if (blockInteractions)
            Positioned.fill(
              child: AbsorbPointer(
                absorbing: true,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
        ],
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
