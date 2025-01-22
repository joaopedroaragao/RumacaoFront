// lib/view/identification/identification_header.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumacao_front/constants/app_constants.dart';

class IdentificationHeader extends StatelessWidget {
  const IdentificationHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(width: 16),
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        const Spacer(),
        Expanded(
          flex: 4,
          child: Text(
            AppStrings.identificationHeaderMessage, // Usando a string do AppStrings
            textAlign: TextAlign.center,
            style: AppStyles.headerText, // Usando estilo centralizado no AppStyles
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
