import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumacao_front/constants/app_constants.dart';
import 'package:rumacao_front/view/global/main_interaction_screen.dart';
import 'package:rumacao_front/view/identification/identification_form.dart';
import 'package:rumacao_front/view/identification/terms_and_conditions.dart';
import 'package:rumacao_front/view/questions/questions_page.dart';
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
        const Spacer(flex: 2),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: const IdentificationForm(),
        ),
        const Spacer(),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
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
                  Text(
                    AppStrings.newsletterConsentMessage,
                    style: AppStyles.termsText,
                  ),
                ],
              )
            ],
          ),
        ),
        const Spacer(),
        // Botão de confirmação ou loading (mantém a largura fixa)
        Obx(() {
          if (viewModel.isSubmitting.value) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.75,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFF7E97ED),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            );
          } else {
            return SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: ElevatedButton(
                onPressed: () async {
                  if (await viewModel.validateForm()) {
                    Get.to(() => QuestionsPage());
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7E97ED),
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
            );
          }
        }),
        const Spacer(flex: 3),
      ],
    );
  }
}
