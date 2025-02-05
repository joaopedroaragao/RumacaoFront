import 'package:flutter/material.dart';
import 'package:rumacao_front/constants/app_constants.dart';

class ActionButton extends StatelessWidget {
  final Color? color;
  final VoidCallback? onPressed;
  final String? text;
  final double? width;
  final double? height;

  const ActionButton({
    Key? key,
    this.text,
    this.color,
    this.onPressed,
    this.width = 147,
    this.height = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColors.startButton,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text ?? AppStrings.startButtonText,
          style: AppStyles.startButtonText,
        ),
      ),
    );
  }
}
