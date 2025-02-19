import 'package:flutter/material.dart';
import 'description_text.dart';
import '../global/action_button.dart';
import 'package:get/get.dart';
import 'package:rumacao_front/viewmodel/home_view_model.dart';

class MiddleSection extends StatelessWidget {
  const MiddleSection({super.key});

  @override
  Widget build(BuildContext context) {
    final homeVM = Get.find<HomeViewModel>();
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const DescriptionText(),
          const SizedBox(height: 20),
          ActionButton(
            onPressed: () {
              homeVM.onStartButtonPressed();
            },
          ),
        ],
      ),
    );
  }
}
