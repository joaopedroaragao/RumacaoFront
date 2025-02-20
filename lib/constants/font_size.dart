import 'package:get/get.dart';

double calculateFontSize(double baseFontSize) {
  const double baseHeight = 620;
  const double baseWidth = 500;
  final double heightFactor = Get.height / baseHeight;
  final double widthFactor = Get.width / baseWidth;
  const weightSum = 35;
  final double scaleFactor = ((weightSum - 1) * heightFactor + widthFactor) / weightSum;
  return baseFontSize * scaleFactor;
}
