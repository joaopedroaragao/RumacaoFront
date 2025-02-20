import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumacao_front/view/identification/form_text_field.dart';
import 'package:rumacao_front/viewmodel/identification_view_model.dart';

class IdentificationForm extends StatelessWidget {
  const IdentificationForm({super.key});

  @override
  Widget build(BuildContext context) {
    final IdentificationViewModel viewModel = Get.find();
    // Calcula o fator de escala com base na altura da tela, considerando 800 como base ideal.
    final double scale = MediaQuery.of(context).size.height / 800;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Campo Nome com altura proporcional
        FormTextField(
          label: 'Nome',
          onChanged: viewModel.setName,
          errorText: viewModel.nameError,
          height: 50 * scale,
        ),
        SizedBox(height: 16 * scale),
        // Campo E-mail com altura proporcional
        FormTextField(
          label: 'E-mail',
          onChanged: viewModel.setEmail,
          errorText: viewModel.emailError,
          height: 50 * scale,
        ),
      ],
    );
  }
}
