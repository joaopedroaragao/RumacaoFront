// // lib/view/results/result_section.dart
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:rumacao_front/view/results/circular_chart.dart';
// import 'package:rumacao_front/view/results/percentage_tile.dart';
// import 'package:rumacao_front/viewmodel/results_view_model.dart';
//
// class ResultSection extends StatelessWidget {
//   const ResultSection({Key? key}) : super(key: key);
//
//   /// Retorna a cor associada à categoria (usando cores fixas).
//   Color _getCategoryColor(String title) {
//     switch (title.toLowerCase()) {
//       case "Educação":
//         return const Color(0xFFEA5EB5);
//       case "Ciência":
//         return const Color(0xFFFE8F38);
//       case "Cultura":
//         return const Color(0xFFFFDB4F);
//       default:
//         return Colors.grey;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final ResultsViewModel resultsVM = Get.find<ResultsViewModel>();
//     return Obx(() {
//       print(resultsVM.isLoading.value);
//       if (resultsVM.isLoading.value) {
//         return const Center(child: CircularProgressIndicator());
//       } else if (resultsVM.error.value != null) {
//         return Center(
//           child: Text(
//             resultsVM.error.value!,
//             style: const TextStyle(color: Colors.red),
//           ),
//         );
//       } else {
//         final data = resultsVM.scoreData;
//         // Suponha que a API retorne:
//         // overallPercentage: número
//         // categories: lista de mapas com { "title": string, "percentage": number }
//         final overallPercentage = data['overallPercentage'] ?? 0.0;
//         final categories = data['areaPercentages'] ?? [];
//         print(categories);
//         // Mapeia as categorias para segmentos do gráfico.
//         List<ChartSegment> segments = [];
//         for (var cat in categories) {
//           final String title = cat.key;
//           final double value = (cat['percentage'] ?? 0).toDouble();
//           segments.add(ChartSegment(
//             value: value,
//             color: _getCategoryColor(title),
//           ));
//         }
//
//         return Column(
//           children: [
//             const SizedBox(height: 20),
//             // Exibe o gráfico em pizza (apenas a borda segmentada) sem porcentagem central.
//             CircularChart(
//               size: 150,
//               strokeWidth: 10,
//               segments: segments,
//             ),
//             const SizedBox(height: 20),
//             for (var cat in categories)
//               PercentageTile(
//                 title: cat['title'] ?? "",
//                 percentage: "${cat['percentage'] ?? 0}%",
//                 color: _getCategoryColor(cat['title'] ?? ""),
//               ),
//             const SizedBox(height: 20),
//           ],
//         );
//       }
//     });
//   }
// }
