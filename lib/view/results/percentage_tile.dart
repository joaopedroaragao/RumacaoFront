import 'package:flutter/material.dart';

class PercentageTile extends StatelessWidget {
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
  Widget build(BuildContext context) {
    // Cor de fundo do tile
    final backgroundColor = isFilled ? color : Colors.white;
    // Cor do texto
    final percentageColor = isFilled ? Colors.white : const Color(0xFF161A41).withOpacity(0.78);
    final textColor = isFilled ? Colors.white.withOpacity(0.64) : const Color(0xFF161A41).withOpacity(0.41);
    final shadowColor = isFilled ? const Color(0xFF6976EB).withOpacity(0.36) : Colors.black.withOpacity(0.04);
    // Sombra mais forte se preenchido
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
          SizedBox(
            width: 42,
            child: Text(
              percentage,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: percentageColor,
              ),
            ),
          ),
          const Spacer(flex: 2),
          Expanded(
            flex: 4,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Spacer(flex: 3)
        ],
      ),
    );

    // Se não estiver preenchido, criamos uma faixa à esquerda.
    // Para manter a borda externa arredondada mas a interna reta,
    // usamos um ClipRRect no container externo e a faixa é um widget separado sem borderRadius.
    Widget tileChild;
    Widget paddedContent = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: content
    );
    tileChild = Row(
      children: [
        Container(
          width: 10,
          color: color, // faixa sem arredondamento
        ),
        Expanded(child: paddedContent),
      ],
    );

    final borderRadius = BorderRadius.circular(12);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      height: height,
      decoration: BoxDecoration(
        boxShadow: boxShadow,
        borderRadius: borderRadius
      ),
      // O ClipRRect garante que o contorno externo fique arredondado.
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
