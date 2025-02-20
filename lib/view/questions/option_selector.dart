import 'package:flutter/material.dart';
import 'package:rumacao_front/constants/font_family.dart';
import 'package:rumacao_front/constants/font_size.dart';

/// Representa o aspecto visual de uma opção.
class OptionButton {
  final Color? borderColor;
  final Color backgroundColor;
  final Color selectedColor;
  final double size;
  final double borderWidth;
  final String label;
  final TextStyle? textStyle;

  OptionButton({
    this.borderColor,
    required this.backgroundColor,
    required this.selectedColor,
    this.label = "",
    this.size = 40.0,
    this.borderWidth = 0,
    this.textStyle,
  });
}

/// Widget que exibe as opções.
class OptionSelector extends StatelessWidget {
  final List<OptionButton> options;
  final int? selectedIndex;
  final void Function(int)? onSelected;

  const OptionSelector({
    super.key,
    required this.options,
    this.selectedIndex,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(options.length, (index) {
        final option = options[index];
        final isSelected = index == selectedIndex;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => onSelected?.call(index),
              child: Container(
                width: option.size,
                height: option.size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: option.backgroundColor,
                  border: Border.all(
                    color: option.borderColor ?? Colors.transparent,
                    width: option.borderWidth,
                  ),
                ),
                child: isSelected
                    ? Center(
                  child: Container(
                    width: option.size * 0.5,
                    height: option.size * 0.5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: option.selectedColor,
                    ),
                  ),
                )
                    : null,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              option.label,
              style: option.textStyle ??
                  TextStyle(
                    fontFamily: FontFamily.inter.name,
                    fontSize: calculateFontSize(13),
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      }),
    );
  }
}
