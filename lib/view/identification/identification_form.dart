// lib/view/identification/widgets/identification_form.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumacao_front/view/identification/form_text_field.dart';
import 'package:rumacao_front/viewmodel/identification_view_model.dart';

class IdentificationForm extends StatelessWidget {
  const IdentificationForm({super.key});

  @override
  Widget build(BuildContext context) {
    final IdentificationViewModel viewModel = Get.find();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Campo Nome
        FormTextField(
          label: 'Nome',
          onChanged: viewModel.setName,
          errorText: viewModel.nameError,
        ),
        const SizedBox(height: 16),

        // Campo E-mail
        FormTextField(
          label: 'E-mail',
          onChanged: viewModel.setEmail,
          errorText: viewModel.emailError,
        )
      ],
    );
  }
}
