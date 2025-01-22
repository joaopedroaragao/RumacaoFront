// lib/view/home/start_button.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumacao_front/constants/app_constants.dart';
import 'package:rumacao_front/view/identification/identification_page.dart';

class StartButton extends StatelessWidget {
  const StartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Get.to(() => const IdentificationPage());
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.startButton,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        AppStrings.startButtonText,
        style: AppStyles.startButtonText,
      ),
    );
  }
}
