import 'dart:math';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:visibility_detector/visibility_detector.dart';

class QuestionsCarousel extends StatefulWidget {
  final int length;
  final ExtendedIndexedWidgetBuilder itemBuilder;
  final Function(VisibilityInfo info, int index)? onVisibilityChanged;
  final CarouselOptions? options;
  final int currentIndex; // Índice da pergunta atual

  const QuestionsCarousel({
    super.key,
    required this.length,
    required this.itemBuilder,
    this.onVisibilityChanged,
    this.options,
    required this.currentIndex,
  });

  @override
  State<QuestionsCarousel> createState() => _QuestionsCarouselState();
}

class _QuestionsCarouselState extends State<QuestionsCarousel>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _bounceAnimation = Tween<double>(begin: 0, end: -20).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }

  void triggerJumpAnimation() {
    // _controller.forward(from: 0);
  }

  @override
  void didUpdateWidget(covariant QuestionsCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      triggerJumpAnimation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return carousel;
  }

  Widget get carousel {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: AnimatedBuilder(
            animation: _bounceAnimation,
            builder: (context, child) {
              return CarouselSlider.builder(
                itemCount: widget.length,
                itemBuilder: (context, index, realIndex) {
                  return Transform.translate(
                    offset: Offset(0, index == widget.currentIndex + 1 ? _bounceAnimation.value : 0),
                    child: VisibilityDetector(
                      key: Key("carouselIndex=$index"),
                      onVisibilityChanged: (info) =>
                          widget.onVisibilityChanged?.call(info, index),
                      child: widget.itemBuilder.call(context, index, realIndex),
                    ),
                  );
                },
                options: widget.options ??
                    CarouselOptions(
                      viewportFraction: 0.55,
                      initialPage: 0,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      scrollPhysics: const BouncingScrollPhysics(),
                    ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
