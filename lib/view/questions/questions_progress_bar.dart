import 'package:flutter/material.dart';

class QuestionsProgressBar extends StatelessWidget {
  final double progress;
  final double height;
  final double indicatorWidth;
  final Color themeColor;

  const QuestionsProgressBar({
    Key? key,
    required this.progress,
    required this.height,
    this.indicatorWidth = 32,
    required this.themeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int leftFlex = (progress * 1000).toInt();
    int rightFlex = ((1 - progress) * 1000).toInt();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: leftFlex,
          child: Container(
            height: height,
            color: themeColor,
          ),
        ),
        Container(
          height: height,
          width: indicatorWidth,
          color: Colors.white,
        ),
        Expanded(
          flex: rightFlex,
          child: Container(
            height: height,
            color: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }
}
