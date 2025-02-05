// widgets/middle_section.dart
import 'package:flutter/material.dart';
import 'package:rumacao_front/view/identification/identification_page.dart';
import 'description_text.dart';
import '../global/action_button.dart';
import 'package:get/get.dart';

class MiddleSection extends StatelessWidget {
  const MiddleSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const DescriptionText(),
          const SizedBox(height: 20),
          ActionButton(
            onPressed: () {
              Get.to(() => const IdentificationPage());
            },
          ),
        ],
      ),
    );
  }
}
