import 'package:flutter/material.dart';
import 'package:rumacao_front/constants/app_constants.dart';
import 'package:rumacao_front/view/global/footer.dart';
import 'package:rumacao_front/view/global/identification_header.dart';

class MainInteractionScreen extends StatelessWidget {
  final String headerText;
  final List<Widget> items;

  const MainInteractionScreen({
    Key? key,
    required this.headerText,
    required this.items
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          BaseInteractionScreenHeader(text: headerText),
          ...items,
          const Footer(),
        ],
      ),
    );
  }
}
