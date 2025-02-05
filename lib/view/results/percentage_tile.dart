// lib/view/results/percentage_tile.dart
import 'package:flutter/material.dart';
import 'package:rumacao_front/constants/app_constants.dart';

class PercentageTile extends StatelessWidget {
  final String title;
  final String percentage;
  final Color color;
  const PercentageTile({
    Key? key,
    required this.title,
    required this.percentage,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              percentage,
              style: AppStyles.percentageTextStyle,
            ),
            Text(
              title,
              style: AppStyles.percentageTitleStyle,
            ),
          ],
        ),
      ),
    );
  }
}
