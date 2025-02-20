import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumacao_front/constants/app_constants.dart';
import 'package:rumacao_front/constants/font_size.dart';
import 'package:rumacao_front/view/global/main_interaction_screen.dart';
import 'package:rumacao_front/view/identification/identification_form.dart';
import 'package:rumacao_front/view/identification/terms_and_conditions.dart';
import 'package:rumacao_front/view/questions/questions_page.dart';
import 'package:rumacao_front/viewmodel/identification_view_model.dart';

class IdentificationPage extends StatelessWidget {
  final viewModel = IdentificationViewModel();

  IdentificationPage({super.key}) {
    Get.put(viewModel);
  }

  @override
  Widget build(BuildContext context) {
    // Calcula o fator de escala com base na altura da tela (base: 800)
    final double scale = MediaQuery.of(context).size.height / 800;

    return MainInteractionScreen(
      headerText: AppStrings.identificationHeaderMessage,
      items: [
        const Spacer(flex: 2),
        SizedBox(
          width: Get.width * 0.75,
          child: const IdentificationForm(),
        ),
        const Spacer(),
        SizedBox(
          width: Get.width * 0.75,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Checkbox para aceitar os Termos e Condições
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() => Checkbox(
                    value: viewModel.acceptTerms.value,
                    onChanged: (value) {
                      viewModel.acceptTerms.value = value ?? false;
                    },
                  )),
                  const SizedBox(width: 5),
                  const Flexible(flex: 3, child: TermsAndConditions()),
                ],
              ),
              // Exibe erro para os Termos (como placeholder dentro do layout, sem aumentar a altura)
              Obx(() {
                if (!viewModel.acceptTerms.value &&
                    viewModel.hasSubmitted.value) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Você deve aceitar os Termos e Condições para continuar",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: calculateFontSize(10),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }),
              // Checkbox para consentimento do newsletter
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() => Checkbox(
                    value: viewModel.acceptNewsletter.value,
                    onChanged: (value) {
                      viewModel.acceptNewsletter.value = value ?? false;
                    },
                  )),
                  const SizedBox(width: 5),
                  Flexible(
                    child: Text(
                      AppStrings.newsletterConsentMessage,
                      style: AppStyles.termsText,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        const Spacer(),
        // Botão ou loading com altura proporcional
        Obx(() => viewModel.isLoading.value
            ? Center(
          child: SizedBox(
            height: 51 * scale,
            width: 51 * scale,
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF7E97ED)),
            ),
          ),
        )
            : ElevatedButton(
          onPressed: () async {
            viewModel.isLoading.value = true;
            if (await viewModel.validateForm()) {
              Get.to(() => const QuestionsPage());
            }
            viewModel.isLoading.value = false;
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF7E97ED),
            minimumSize: Size(159 * scale, 51 * scale),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0 * scale),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                AppStrings.confirmButtonText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: calculateFontSize(14),
                ),
              ),
            ),
          ),
        )),
        const Spacer(flex: 3),
      ],
    );
  }
}
