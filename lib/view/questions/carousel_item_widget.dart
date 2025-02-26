import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CarouselItemWidget extends StatefulWidget {
  final String lottieAsset;
  final bool animate;
  final bool isNeutralItem;
  final Function()? onAnimationCompleted;

  const CarouselItemWidget({
    Key? key,
    required this.lottieAsset,
    required this.animate,
    this.isNeutralItem = false,
    this.onAnimationCompleted,
  }) : super(key: key);

  @override
  _CarouselItemWidgetState createState() => _CarouselItemWidgetState();
}

class _CarouselItemWidgetState extends State<CarouselItemWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late bool isReturning = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.1).chain(CurveTween(curve: Curves.easeOut)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.1, end: 1.0).chain(CurveTween(curve: Curves.easeIn)),
        weight: 1,
      ),
    ]).animate(_controller);

    if (widget.animate) {
      _controller.forward();
    }

    _controller.addStatusListener((status) {
      if (widget.isNeutralItem && status == AnimationStatus.completed) {
        _controller.reverse();
        isReturning = true;
      } else if (status == AnimationStatus.completed
          || (status == AnimationStatus.dismissed && isReturning)) {
        widget.onAnimationCompleted?.call();
        isReturning = false;
      }
    });
  }

  @override
  void didUpdateWidget(CarouselItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate && !oldWidget.animate) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final content = LottieBuilder.asset(
      widget.lottieAsset,
      controller: _controller,
      width: 350,
      height: 350,
      frameRate: FrameRate.composition,
    );

    if (widget.animate) {
      return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: widget.isNeutralItem ? 1 : _scaleAnimation.value,
            child: child,
          );
        },
        child: content,
      );
    }
    return content;
  }
}
