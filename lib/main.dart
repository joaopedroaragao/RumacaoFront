import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumacao_front/constants/app_constants.dart';
import 'package:rumacao_front/view/home/home_page.dart';
import 'package:rumacao_front/view/identification/identification_page.dart';
import 'package:rumacao_front/view/questions/question_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appName,
      theme: ThemeData(
        fontFamily: "Inter",
        useMaterial3: true,
      ),
      home: const QuestionPage(),
    );
  }
}