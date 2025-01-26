import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rumacao_front/constants/font_family.dart';
import 'package:rumacao_front/view/global/arc_slider.dart';

class QuestionCard extends StatefulWidget {
  const QuestionCard({super.key});

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  late int red;
  late int green;
  late int blue;
  double value = 0.5;

  late String title;
  late String description;

  @override
  void initState() {
    super.initState();
    setValuesFrom(value);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.all(32),
          width: min(600, constraints.maxWidth - 64),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 23),
                blurRadius: 28.6,
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              arcSlider,
              const Spacer(flex: 2),
              SizedBox(
                height: 24, // Altura fixa para o título
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: FontFamily.inter.name,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF161A41).withOpacity(0.78),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 48, // Altura fixa para a descrição
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: FontFamily.inter.name,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: const Color(0xFF161A41).withOpacity(0.31),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        );
      },
    );
  }

  Widget get arcSlider {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ArcSlider(
          arrowColor: Colors.green.shade800,
          backgroundArcColor: Colors.grey.shade200,
          arrowThickness: 4.0,
          width: max(500, constraints.maxWidth - 64 - 32),
          height: MediaQuery.of(context).size.height * 0.2,
          value: value,
          arcThickness: 15,
          colorResolver: (value) {
            return Color.fromRGBO(red, green, blue, 1);
          },
          onChanged: (value) {
            setState(() => setValuesFrom(value));
          },
        );
      },
    );
  }

  setValuesFrom(double value) {
    if (value < 0.2) {
      // Vermelho para laranja
      red = 255;
      green = (value / 0.2 * 165).toInt();
      blue = 0;

      title = "Discordo totalmente";
      description = "Expressa um nível completo de discordância, sem ressalvas.";
    } else if (value < 0.4) {
      // Laranja para amarelo
      red = 255;
      green = 165 + ((value - 0.2) / 0.2 * 90).toInt();
      blue = 0;

      title = "Discordo";
      description = "Expressa um nível moderado de discordância.";
    } else if (value < 0.6) {
      // Amarelo para verde claro
      red = 255 - ((value - 0.4) / 0.2 * 255).toInt();
      green = 255;
      blue = 0;

      title = "Neutro";
      description = "Expressa uma posição de neutralidade, sem concordar ou discordar.";
    } else if (value < 0.8) {
      // Verde claro para verde médio
      red = 0;
      green = 255;
      blue = ((value - 0.6) / 0.2 * 128).toInt();

      title = "Concordo";
      description = "Expressa um nível moderado de concordância.";
    } else {
      // Verde médio para verde escuro
      red = 0;
      green = 255 - ((value - 0.8) / 0.2 * 100).toInt();
      blue = ((value - 0.8) / 0.2 * 50).toInt();

      title = "Concordo totalmente";
      description = "Expressa um nível completo de concordância, sem ressalvas.";
    }
  }
}
