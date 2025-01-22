// lib/view/identification/identification_header.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumacao_front/constants/app_constants.dart';

class BaseInteractionScreenHeader extends StatelessWidget {
  final String text;

  const BaseInteractionScreenHeader({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(),
            Expanded(
              flex: 4,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: AppStyles.headerText, // Usando estilo centralizado no AppStyles
              ),
            ),
            const Spacer(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ],
    );
  }
}
