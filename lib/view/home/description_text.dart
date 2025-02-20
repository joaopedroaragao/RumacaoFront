import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumacao_front/constants/app_constants.dart';
import 'package:rumacao_front/constants/font_size.dart';

class DescriptionText extends StatefulWidget {
  const DescriptionText({super.key});

  @override
  State<DescriptionText> createState() => _DescriptionTextState();
}

class _DescriptionTextState extends State<DescriptionText> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.75,
      child: Text(
        AppStrings.description,
        textAlign: TextAlign.center,
        style: AppStyles.descriptionText.copyWith(
          fontSize: calculateFontSize(13),
        ),
      ),
    );
  }
}