import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumacao_front/view/results/circular_chart.dart';
import 'package:rumacao_front/view/results/percentage_tile.dart';
import 'package:rumacao_front/viewmodel/results_view_model.dart';
import 'package:rumacao_front/model/score_data.dart';

class ResultSection extends StatelessWidget {
  const ResultSection({Key? key}) : super(key: key);

  /// Retorna a cor associada à categoria (usando cores fixas).
  Color _getCategoryColor(String areaName) {
    switch (areaName.toLowerCase()) {
      case "educação":
      case "educação ambiental":
        return const Color(0xFFEA5EB5);
      case "cultura":
        return const Color(0xFFFFDB4F);
      case "ciência":
        return const Color(0xFFFE8F38);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final resultsVM = Get.find<ResultsViewModel>();

    return Obx(() {
      if (resultsVM.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (resultsVM.error.value != null) {
        return Center(
          child: Text(
            resultsVM.error.value!,
            style: const TextStyle(color: Colors.red),
          ),
        );
      } else if (resultsVM.scoreData.value == null) {
        return const Center(child: Text("Nenhum dado encontrado."));
      } else {
        final score = resultsVM.scoreData.value!;
        final areas = score.areaPercentages; // do tipo AreaPercentages

        // Converte as strings "xx.xx%" para double, ex.: "34.29%" -> 34.29
        double ed = double.tryParse(areas.educacao.replaceAll("%", "")) ?? 0;
        double cul = double.tryParse(areas.cultura.replaceAll("%", "")) ?? 0;
        double ci = double.tryParse(areas.ciencia.replaceAll("%", "")) ?? 0;

        double maxValue = [ed, ci, cul].reduce(max);
        bool allEqual = (ed == ci && ci == cul); // se todas são iguais, não preenche nenhuma

        bool isEducacaoFilled = !allEqual && ed == maxValue;
        bool isCienciaFilled = !allEqual && ci == maxValue;
        bool isCulturaFilled = !allEqual && cul == maxValue;

        final total = ed + cul + ci;
        if (total == 0) {
          return const Text("As porcentagens estão zeradas.");
        }

        // Monta a lista de segmentos para o gráfico
        final segments = [
          ChartSegment(value: ed, color: _getCategoryColor("Educação Ambiental")),
          ChartSegment(value: cul, color: _getCategoryColor("Cultura")),
          ChartSegment(value: ci, color: _getCategoryColor("Ciência")),
        ];

        // Preparando lista para ordenar
        final List<_AreaTileData> tileData = [
          _AreaTileData(
            title: "Educação Ambiental",
            numericValue: ed,
            color: _getCategoryColor("Educação Ambiental"),
            isFilled: isEducacaoFilled,
          ),
          _AreaTileData(
            title: "Cultura",
            numericValue: cul,
            color: _getCategoryColor("Cultura"),
            isFilled: isCulturaFilled,
          ),
          _AreaTileData(
            title: "Ciência",
            numericValue: ci,
            color: _getCategoryColor("Ciência"),
            isFilled: isCienciaFilled,
          ),
        ];

        // Ordena em ordem decrescente de valor numérico
        tileData.sort((a, b) => b.numericValue.compareTo(a.numericValue));

        return Column(
          children: [
            const SizedBox(height: 20),
            // Gráfico circular
            CircularChart(
              size: min(Get.width / 2.5, Get.height / 2),
              strokeWidth: min(Get.width * 0.055, Get.height * 0.055),
              segments: segments,
            ),
            const SizedBox(height: 20),
            // Exibe os tiles na ordem decrescente de valor
            for (var data in tileData)
              PercentageTile(
                title: data.title,
                // Arredonda o valor para inteiro e adiciona "%"
                percentage: "${data.numericValue.round()}%",
                color: data.color,
                isFilled: data.isFilled,
              ),
            const SizedBox(height: 20),
          ],
        );
      }
    });
  }
}

/// Classe auxiliar para armazenar dados de cada área antes de criar o PercentageTile.
class _AreaTileData {
  final String title;
  final double numericValue;
  final Color color;
  final bool isFilled;

  _AreaTileData({
    required this.title,
    required this.numericValue,
    required this.color,
    required this.isFilled,
  });
}
