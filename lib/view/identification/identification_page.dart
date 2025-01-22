// lib/view/identification/identification_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumacao_front/constants/app_constants.dart';
import 'package:rumacao_front/view/global/main_interaction_screen.dart';
import 'package:rumacao_front/view/identification/identification_form.dart';
import 'package:rumacao_front/view/identification/terms_and_conditions.dart';
import 'package:rumacao_front/view/questions/question_page.dart';
import 'package:rumacao_front/viewmodel/identification_view_model.dart';

class IdentificationPage extends StatelessWidget {
  const IdentificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = IdentificationViewModel();
    Get.put(viewModel);
    return MainInteractionScreen(
      headerText: AppStrings.identificationHeaderMessage,
      items: [
        const Spacer(),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: const IdentificationForm(),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            if (viewModel.validateForm()) {
              Get.to(() => const QuestionPage());
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.confirmButtonBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              AppStrings.confirmButtonText,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Texto de Termos e Condições
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: TermsAndConditions(),
        ),
        const Spacer(flex: 5),
      ],
    );
  }
}
