// lib/view/identification/identification_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumacao_front/constants/app_constants.dart';
import 'package:rumacao_front/view/global/footer.dart';
import 'package:rumacao_front/view/identification/identification_form.dart';
import 'package:rumacao_front/view/identification/identification_header.dart';
import 'package:rumacao_front/view/identification/terms_and_conditions.dart';
import 'package:rumacao_front/viewmodel/identification_view_model.dart';

class IdentificationPage extends StatelessWidget {
  const IdentificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = IdentificationViewModel();
    Get.put(viewModel);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(AppStrings.headerLogo),
        leading: Container(),
      ),
      body: Column(
        children: [
          const SizedBox(height: 48),
          const IdentificationHeader(),
          const Spacer(),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: const IdentificationForm(),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: viewModel.validateForm,
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
          const Footer(),
        ],
      ),
    );
  }
}
