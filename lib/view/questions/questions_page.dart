import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:rumacao_front/constants/app_constants.dart';
import 'package:rumacao_front/model/answer_option.dart';
import 'package:rumacao_front/view/global/footer.dart';
import 'package:rumacao_front/viewmodel/questions_view_model.dart';

// Componentes criados
import './pre_quiz_card.dart';
import './quiz_content.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({Key? key}) : super(key: key);

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> with SingleTickerProviderStateMixin {
  late final CarouselSliderController _carouselController = CarouselSliderController();

  late AnimationController _animationController;
  late Animation<double> _bounceAnimation;
  late Animation<double> _expandAnimation;
  int? _animateIndex;
  late Animation<double> _animation; // animação atualmente em uso

  bool imagesPreloaded = false;

  // Dados fixos
  final answerOptions = [
    AnswerOption(id: 0, label: "Discordo"),
    AnswerOption(id: 1, label: ""),
    AnswerOption(id: 2, label: ""),
    AnswerOption(id: 3, label: ""),
    AnswerOption(id: 4, label: "Concordo"),
  ];

  final images = [
    AppImages.mascoteImages.totallyDisagree3,
    AppImages.mascoteImages.partiallyDisagree3,
    AppImages.mascoteImages.neutral3,
    AppImages.mascoteImages.partiallyAgree3,
    AppImages.mascoteImages.totallyAgree3,
  ];

  final animations = [
    AppAnimations.totallyDisagree,
    AppAnimations.partiallyDisagree,
    AppAnimations.neutral,
    AppAnimations.partiallyAgree,
    AppAnimations.totallyAgree
  ];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _bounceAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: -45).chain(CurveTween(curve: Curves.easeOut)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: -45, end: 0).chain(CurveTween(curve: Curves.easeIn)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: -30).chain(CurveTween(curve: Curves.easeOut)),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: -30, end: 0).chain(CurveTween(curve: Curves.easeIn)),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: -15).chain(CurveTween(curve: Curves.easeOut)),
        weight: 10,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: -15, end: 0).chain(CurveTween(curve: Curves.easeIn)),
        weight: 10,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: -7).chain(CurveTween(curve: Curves.easeOut)),
        weight: 5,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: -7, end: 0).chain(CurveTween(curve: Curves.easeIn)),
        weight: 5,
      ),
    ]).animate(_animationController);

    _expandAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1, end: 1.1).chain(CurveTween(curve: Curves.easeOut)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.1, end: 1).chain(CurveTween(curve: Curves.easeIn)),
        weight: 20,
      ),
    ]).animate(_animationController);

    _animation = _bounceAnimation;

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _animateIndex = null;
          _animation = _bounceAnimation;
        });
      }
    });
  }

  // Pré-carrega as imagens (para evitar _jank_)
  void _preloadImages() {
    if (imagesPreloaded) return;
    for (final image in images) {
      Image.asset(image);
    }
    imagesPreloaded = true;
  }

  @override
  Widget build(BuildContext context) {
    _preloadImages();
    final QuestionViewModel viewModel = Get.put(QuestionViewModel());
    return Obx(() {
      final bool blockInteractions = _animationController.isAnimating;
      return Stack(
        children: [
          Scaffold(
            backgroundColor: AppColors.white,
            appBar: appBar, // supondo que appBar esteja definido globalmente
            body: Column(
              children: [
                Expanded(
                  child: viewModel.showIntroCard.value
                      ? PreQuizCard(
                    viewModel: viewModel,
                    onStart: () => viewModel.startQuiz(),
                  )
                      : QuizContent(
                    viewModel: viewModel,
                    carouselController: _carouselController,
                    answerOptions: answerOptions,
                    images: images,
                    animations: animations,
                    animationController: _animationController,
                    bounceAnimation: _bounceAnimation,
                    expandAnimation: _expandAnimation,
                    currentAnimation: _animation,
                    animateIndex: _animateIndex,
                    onAnimate: (index, newAnimation) {
                      setState(() {
                        _animateIndex = index;
                        _animation = newAnimation;
                      });
                      _animationController.reset();
                      _animationController.forward();
                    },
                  ),
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
                child: Container(color: Colors.transparent),
              ),
            ),
        ],
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
