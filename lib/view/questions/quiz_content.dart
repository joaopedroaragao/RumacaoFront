import 'dart:math';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rumacao_front/constants/app_constants.dart';
import 'package:rumacao_front/constants/font_family.dart';
import 'package:rumacao_front/constants/font_size.dart';
import 'package:rumacao_front/view/global/action_button.dart';
import 'package:rumacao_front/view/questions/carousel_item_widget.dart';
import 'package:rumacao_front/view/questions/option_selector.dart';
import 'package:rumacao_front/view/questions/questions_carousel.dart';
import 'package:rumacao_front/view/questions/questions_progress_bar.dart';
import 'package:rumacao_front/model/answer_option.dart';
import 'package:rumacao_front/viewmodel/questions_view_model.dart';
import 'option_button_builder.dart';

class QuizContent extends StatefulWidget {
  final QuestionViewModel viewModel;
  final CarouselSliderController carouselController;
  final List<AnswerOption> answerOptions;
  final List<String> images;
  final List<String> animations;
  final AnimationController animationController;
  final Animation<double> bounceAnimation;
  final Animation<double> expandAnimation;
  final Animation<double> currentAnimation;
  final int? animateIndex;
  final void Function(int index, Animation<double> animation) onAnimate;

  const QuizContent({
    Key? key,
    required this.viewModel,
    required this.carouselController,
    required this.answerOptions,
    required this.images,
    required this.animations,
    required this.animationController,
    required this.bounceAnimation,
    required this.expandAnimation,
    required this.currentAnimation,
    required this.animateIndex,
    required this.onAnimate,
  }) : super(key: key);

  @override
  _QuizContentState createState() => _QuizContentState();
}

class _QuizContentState extends State<QuizContent> {
  int? lastCurrentIndex;

  @override
  void initState() {
    super.initState();
  }

  Widget _questionText() {
    final double fixedHeight = Get.height * 0.13;
    if (widget.viewModel.questions.isEmpty) return SizedBox(height: fixedHeight);
    final currentQuestion =
    widget.viewModel.questions[widget.viewModel.currentQuestionIndex.value];
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

  @override
  Widget build(BuildContext context) {
    int lastAnswered = widget.viewModel.selectedAnswers.isEmpty
        ? -1
        : widget.viewModel.selectedAnswers.keys.reduce(max);
    lastCurrentIndex ??= lastAnswered;
    return Column(
      children: [
        const Spacer(),
        Obx(() => _questionText()),
        // widget.carouselController.nextPage();
        Expanded(
          flex: 30,
          child: Obx(() {
            // las
            return QuestionsCarousel(
              controller: widget.carouselController,
              length: widget.viewModel.questions.length,
              initialPage: max(0, min(lastAnswered + 1, widget.viewModel.questions.length - 1)),
              lastAnsweredIndex: lastAnswered,
              onSwipeForwardBlocked: () {
                if (widget.viewModel.selectedAnswers[
                widget.viewModel.currentQuestionIndex.value] ==
                    null) {
                  widget.onAnimate(
                      widget.viewModel.currentQuestionIndex.value,
                      widget.expandAnimation);
                  widget.viewModel.preSelectAnswer(2);
                }
              },
              itemBuilder: (context, index, realIndex) {
                final preselected = index == widget.viewModel.currentQuestionIndex.value
                    ? widget.viewModel.preselected.value
                    : null;
                final int? answerIndex =
                    preselected ?? widget.viewModel.currentAnswer(index);
                final String lottieAsset = answerIndex != null
                    ? widget.animations[answerIndex]
                    : AppAnimations.neutral;
                return CarouselItemWidget(
                  lottieAsset: lottieAsset,
                  animate: widget.animateIndex != null &&
                      index == widget.animateIndex,
                  isNeutralItem: widget.viewModel.preselected.value == 2,
                );
              },
              onPageChanged: (index) => widget.viewModel.onPageChanged(index),
              onInstantlyPageChange: (index) =>
                  widget.viewModel.onPageChanged(index),
            );
          }),
        ),
        const Spacer(),
        Expanded(
          flex: 10,
          child: Obx(() {
            final currentIndex = widget.viewModel.currentQuestionIndex.value;
            if (widget.viewModel.questions.isEmpty) return Container();
            final int? selectedAnswerId =
            widget.viewModel.selectedAnswers[currentIndex];
            final selectedOptionIndex = widget.answerOptions
                .indexWhere((option) => option.id == selectedAnswerId);
            final int? selectedIndex =
            selectedOptionIndex >= 0 ? selectedOptionIndex : null;
            return Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 10,
                  child: OptionSelector(
                    options:
                    widget.answerOptions.map(buildOptionButton).toList(),
                    selectedIndex: selectedIndex,
                    onSelected: (optionIndex) {
                      final option = widget.answerOptions[optionIndex];
                      widget.viewModel.preSelectAnswer(option.id);
                      widget.onAnimate(widget.viewModel.currentQuestionIndex.value,
                          widget.expandAnimation);
                      Future.delayed(const Duration(milliseconds: 800), () {
                        widget.viewModel.selectAnswer(option.id);
                      });
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
          final bool allAnswered = widget.viewModel.questions.isNotEmpty &&
              widget.viewModel.selectedAnswers.length ==
                  widget.viewModel.questions.length;
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
                widget.viewModel.submitResponses("cXNZNJc3HOu7N2faYqgo");
              },
            ),
          );
        }),
        const Spacer(flex: 2),
        Obx(() {
          double progress = 0.0;
          if (widget.viewModel.questions.length > 1) {
            final current = widget.viewModel.currentQuestionIndex.value;
            final total = widget.viewModel.questions.length - 1;
            final offset = sqrt(total) / 100;
            progress = min(current / total + offset, 1);
          } else if (widget.viewModel.questions.isNotEmpty) {
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
}
