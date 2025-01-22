import 'package:flutter/material.dart';

class QuestionsProgressBar extends StatelessWidget {
  final double progress; // Progresso de 0 a 1
  final Color themeColor; // Cor do progresso

  const QuestionsProgressBar({
    Key? key,
    required this.progress,
    required this.themeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Parte preenchida
        Expanded(
          flex: (progress * 1000).toInt(),
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: themeColor,
            ),
          ),
        ),
        const Spacer(flex: 5),
        Expanded(
          flex: ((1 - progress) * 1000).toInt(),
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              Container(
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey.shade300,
                ),
              ),
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: themeColor,
                  shape: BoxShape.circle,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
