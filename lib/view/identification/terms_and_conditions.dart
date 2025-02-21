// lib/view/identification/terms_and_conditions.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumacao_front/constants/app_constants.dart';
import 'package:rumacao_front/view/terms/terms_page.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        text: AppStrings.termsDisclaimerPrefix,
        style: AppStyles.termsText,
        children: [
          WidgetSpan(
            child: MouseRegion(
              cursor: SystemMouseCursors.click, // Cursor de clique
              child: GestureDetector(
                onTap: () {
                  Get.dialog(
                    const TermsPage(),
                    barrierDismissible: true, // se quiser que o usuário feche ao clicar fora
                    transitionCurve: Curves.easeInOut,
                    transitionDuration: const Duration(milliseconds: 300),
                  );
                },
                child: Text(
                  AppStrings.termsAndConditionsAndPrivacyPolicy,
                  style: AppStyles.linkText, // Estilo do texto clicável
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
