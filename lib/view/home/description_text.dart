// widgets/description_text.dart
import 'package:flutter/material.dart';
import 'package:rumacao_front/constants/app_constants.dart';

class DescriptionText extends StatelessWidget {
  const DescriptionText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Text(
        AppStrings.description,
        textAlign: TextAlign.center,
        style: AppStyles.descriptionText,
      ),
    );
  }
}
