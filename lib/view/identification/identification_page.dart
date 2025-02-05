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
              // Label de erro para os Termos (aparece caso não esteja marcado e o formulário já tenha sido submetido)
              Obx(() {
                if (!viewModel.acceptTerms.value && viewModel.hasSubmitted.value) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Você deve aceitar os Termos e Condições para continuar",
                        style: TextStyle(color: Colors.red, fontSize: 12),
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
        ElevatedButton(
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
        const Spacer(flex: 3),
      ],
    );
  }
}
