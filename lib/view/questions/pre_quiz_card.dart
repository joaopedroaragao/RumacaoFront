import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rumacao_front/constants/app_constants.dart';
import 'package:rumacao_front/constants/font_family.dart';
import 'package:rumacao_front/constants/font_size.dart';
import 'package:rumacao_front/view/global/action_button.dart';
import 'package:rumacao_front/viewmodel/questions_view_model.dart';

class PreQuizCard extends StatelessWidget {
  final QuestionViewModel viewModel;
  final VoidCallback onStart;

  const PreQuizCard({
    Key? key,
    required this.viewModel,
    required this.onStart,
  }) : super(key: key);

  Widget _icon() {
    return SvgPicture.asset(
      AppImages.rumacaoIconSvg,
      height: 86,
      width: 67,
    );
  }

  Widget _welcomeText() {
    return Obx(() {
      final name = viewModel.userName.value.isNotEmpty ? viewModel.userName.value : "(Nome)";
      return Text(
        "Parabéns, $name!",
        style: TextStyle(
          fontFamily: FontFamily.inter.name,
          fontSize: calculateFontSize(18).roundToDouble(),
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      );
    });
  }

  Widget _instructionText() {
    return Text(
      "Tudo pronto para começarmos a atividade",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: FontFamily.inter.name,
        fontSize: calculateFontSize(15).roundToDouble(),
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double dialogWidth = MediaQuery.of(context).size.width * 0.8;
    final double dialogHeight = MediaQuery.of(context).size.height * 0.5;
    return Center(
      child: Container(
        width: dialogWidth,
        height: dialogHeight,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF90A8ED),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 3),
            _icon(),
            const Spacer(),
            _welcomeText(),
            const Spacer(),
            _instructionText(),
            const Spacer(flex: 2),
            Obx(() {
              if (viewModel.isLoading.value) {
                return const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                );
              } else {
                return ActionButton(
                  height: 51,
                  width: 159,
                  text: "INICIAR",
                  onPressed: onStart,
                );
              }
            }),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
