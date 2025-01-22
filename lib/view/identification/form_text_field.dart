// lib/view/identification/widgets/form_text_field.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumacao_front/constants/app_constants.dart';

class FormTextField extends StatelessWidget {
  final String label;
  final ValueChanged<String> onChanged;
  final RxnString errorText;

  const FormTextField({
    Key? key,
    required this.label,
    required this.onChanged,
    required this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              label,
              style: AppStyles.fieldLabel,
            ),
          ),
          const SizedBox(height: 8),
          MouseRegion(
            cursor: SystemMouseCursors.text,
            child: TextField(
              onChanged: onChanged,
              cursorColor: AppColors.primaryCursor,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: errorText.value != null
                      ? const BorderSide(color: Colors.red)
                      : BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: errorText.value != null
                      ? const BorderSide(color: Colors.red)
                      : BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: errorText.value != null
                      ? const BorderSide(color: Colors.red)
                      : BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.textFieldBackground,
              ),
            ),
          ),
          if (errorText.value != null)
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: Text(
                errorText.value!,
                style: AppStyles.errorText,
              ),
            ),
        ],
      );
    });
  }
}
