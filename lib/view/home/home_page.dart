// views/home_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumacao_front/constants/app_constants.dart';
import 'package:rumacao_front/view/global/footer.dart';
import 'package:rumacao_front/view/home/header_section.dart';
import 'package:rumacao_front/view/home/middle_section.dart';
import 'package:rumacao_front/viewmodel/home_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeViewModel());
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(AppStrings.headerLogo),
      ),
      body: const Column(
        children: [
          HeaderSection(),
          MiddleSection(),
          Footer(),
        ],
      ),
    );
  }
}
