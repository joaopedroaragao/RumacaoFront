import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumacao_front/constants/app_constants.dart';
import 'package:rumacao_front/view/global/footer.dart';
import 'package:rumacao_front/view/home/header_section.dart';
import 'package:rumacao_front/view/home/middle_section.dart';
import 'package:rumacao_front/viewmodel/home_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Get.put(HomeViewModel());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    // Força a reconstrução da UI quando a janela for redimensionada
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        leading: Container(),
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
