import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumacao_front/constants/app_constants.dart';
import 'package:rumacao_front/constants/font_size.dart';

class PercentageTile extends StatefulWidget {
  final String title;
  final String percentage;
  final Color color;
  final bool isFilled;
  final double height; // Altura configurável

  const PercentageTile({
    super.key,
    required this.title,
    required this.percentage,
    required this.color,
    required this.isFilled,
    this.height = 60, // valor padrão
  });

  @override
  State<PercentageTile> createState() => _PercentageTileState();
}

class _PercentageTileState extends State<PercentageTile> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    // Adiciona o observer para redimensionamento do navegador
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    // Força o rebuild quando as dimensões mudarem
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Cor de fundo do tile
    final backgroundColor = widget.isFilled ? widget.color : Colors.white;
    // Cores do texto
    final percentageColor = widget.isFilled
        ? Colors.white
        : const Color(0xFF161A41).withOpacity(0.78);
    final textColor = widget.isFilled
        ? Colors.white.withOpacity(0.64)
        : const Color(0xFF161A41).withOpacity(0.41);
    final shadowColor = widget.isFilled
        ? const Color(0xFF6976EB).withOpacity(0.36)
        : Colors.black.withOpacity(0.04);

    final boxShadow = [
      BoxShadow(
        color: shadowColor,
        offset: const Offset(0, 14),
        blurRadius: 17.6,
      ),
    ];

    // Conteúdo do tile: linha com valor e título
    final content = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              widget.percentage,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: calculateFontSize(17),
                fontWeight: FontWeight.bold,
                color: percentageColor,
              ),
            ),
          ),
          const Spacer(flex: 2),
          Expanded(
            flex: 4,
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: calculateFontSize(14),
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Spacer(flex: 4),
        ],
      ),
    );

    // Cria uma versão com padding interno para o conteúdo
    final Widget paddedContent = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: content,
    );

    // Se não estiver preenchido, cria uma faixa à esquerda
    final Widget tileChild = Row(
      children: [
        Container(
          width: 10,
          color: widget.color, // faixa sem arredondamento
        ),
        Expanded(child: paddedContent),
      ],
    );

    final borderRadius = BorderRadius.circular(12);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      height: widget.height,
      decoration: BoxDecoration(
        boxShadow: boxShadow,
        borderRadius: borderRadius,
      ),
      // ClipRRect garante que o contorno externo fique arredondado
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
          ),
          child: tileChild,
        ),
      ),
    );
  }
}
