import 'package:flutter/material.dart';
import 'package:rumacao_front/model/answer_option.dart';
import 'package:rumacao_front/view/questions/option_selector.dart';

OptionButton buildOptionButton(AnswerOption option) {
  switch (option.id) {
    case 0:
      return OptionButton(
        size: 55,
        backgroundColor: const Color(0xFF7E96EC).withOpacity(0.45),
        selectedColor: const Color(0xFF7E96EC),
        label: option.label,
      );
    case 1:
      return OptionButton(
        size: 45,
        backgroundColor: const Color(0xFFA98EED).withOpacity(0.45),
        selectedColor: const Color(0xFFA98EED),
        label: option.label,
      );
    case 2:
      return OptionButton(
        size: 40,
        backgroundColor: const Color(0xFFC591ED).withOpacity(0.45),
        selectedColor: const Color(0xFFC591ED),
        label: option.label,
      );
    case 3:
      return OptionButton(
        size: 45,
        backgroundColor: const Color(0xFFCE73EA).withOpacity(0.45),
        selectedColor: const Color(0xFFCE73EA),
        label: option.label,
      );
    case 4:
      return OptionButton(
        size: 55,
        backgroundColor: const Color(0xFFEA5EB5).withOpacity(0.45),
        selectedColor: const Color(0xFFEA5EB5),
        label: option.label,
      );
    default:
      return OptionButton(
        size: 40,
        backgroundColor: const Color(0xFFD9D9D9),
        selectedColor: Colors.grey,
        label: option.label,
      );
  }
}
