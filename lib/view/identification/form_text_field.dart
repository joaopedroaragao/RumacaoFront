import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumacao_front/constants/app_constants.dart';
import 'package:rumacao_front/constants/font_size.dart';

class FormTextField extends StatelessWidget {
  final String label;
  final ValueChanged<String> onChanged;
  final RxnString errorText;
  final double height; // Altura configurável

  const FormTextField({
    super.key,
    required this.label,
    required this.onChanged,
    required this.errorText,
    this.height = 50, // valor padrão
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label acima do campo
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              label,
              style: AppStyles.fieldLabel,
            ),
          ),
          const SizedBox(height: 8),
          // TextField com o erro exibido como placeholder
          MouseRegion(
            cursor: SystemMouseCursors.text,
            child: Container(
              height: height,
              alignment: Alignment.center,
              child: TextField(
                onChanged: onChanged,
                cursorColor: AppColors.primaryCursor,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  // Se houver erro, ele será usado como hintText (placeholder) com estilo em vermelho
                  hintText: errorText.value,
                  hintStyle: errorText.value != null
                      ? TextStyle(fontSize: calculateFontSize(10), color: Colors.red)
                      : null,
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
          ),
        ],
      );
    });
  }
}
