import 'package:flutter/material.dart';
import 'dart:math';

class ArcSlider extends StatefulWidget {
  final Color arrowColor; // Cor da seta
  final Color backgroundArcColor; // Cor do arco de fundo
  final double arrowThickness; // Espessura da seta
  final double arcThickness; // Espessura do arco
  final double width; // Largura do widget
  final double height; // Altura do widget
  final double value; // Valor inicial do slider (entre 0 e 1)
  final ValueChanged<double> onChanged; // Callback para mudanças no valor
  final Color Function(double value) colorResolver; // Função para resolver a cor do arco com base no value

  const ArcSlider({
    Key? key,
    required this.arrowColor,
    required this.backgroundArcColor,
    this.arrowThickness = 3.0,
    this.arcThickness = 8.0,
    this.width = 200.0,
    this.height = 100.0,
    this.value = 0.0,
    required this.onChanged,
    required this.colorResolver,
  })  : assert(value >= 0.0 && value <= 1.0, 'Value must be between 0 and 1'),
        assert(arcThickness > 0, 'Arc thickness must be greater than 0'),
        assert(width > 0, 'Width must be greater than 0'),
        assert(height > 0, 'Height must be greater than 0'),
        super(key: key);

  @override
  _ArcSliderState createState() => _ArcSliderState();
}

class _ArcSliderState extends State<ArcSlider> {
  late double _angle; // Ângulo correspondente ao valor do slider
  late Color _arcColor; // Cor do arco (atualizada com o colorResolver)

  @override
  void initState() {
    super.initState();
    _arcColor = widget.colorResolver(widget.value); // Resolve a cor inicial
    _angle = widget.value * pi; // Converte o valor inicial (0-1) para ângulo (0-pi)
  }

  void _updateAngleAndValue(Offset localPosition, RenderBox box) {
    final center = Offset(widget.width / 2, widget.height);
    final dx = localPosition.dx - center.dx;
    final dy = localPosition.dy - center.dy;

    // Calcula o ângulo do ponto atual em coordenadas polares
    final angle = atan2(dy, dx);

    // Limita o ângulo para o intervalo do arco (π a 2π)
    if (angle >= -pi && angle <= 0) {
      setState(() {
        _angle = pi + angle; // Transforma o ângulo para o intervalo [0, π]
        final newValue = _angle / pi; // Converte o ângulo para o valor do slider (0-1)
        _arcColor = widget.colorResolver(newValue); // Atualiza a cor do arco
        widget.onChanged(newValue); // Chama o callback com o novo valor
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: GestureDetector(
        onPanUpdate: (details) {
          final renderBox = context.findRenderObject() as RenderBox;

          // Obtém a posição global do widget
          final widgetOffset = renderBox.localToGlobal(Offset.zero);

          // Calcula a posição local do gesto com base no widget
          final localPosition = details.globalPosition - widgetOffset;

          _updateAngleAndValue(localPosition, renderBox);
        },
        child: CustomPaint(
          size: Size(widget.width, widget.height), // Define a largura e altura
          painter: GaugePainter(
            angle: _angle,
            arcColor: _arcColor,
            arrowColor: widget.arrowColor,
            backgroundArcColor: widget.backgroundArcColor,
            arrowThickness: widget.arrowThickness,
            arcThickness: widget.arcThickness, // Passa a espessura do arco
          ),
        ),
      ),
    );
  }
}

class GaugePainter extends CustomPainter {
  final double angle;
  final Color arcColor;
  final Color arrowColor;
  final Color backgroundArcColor;
  final double arrowThickness;
  final double arcThickness;

  GaugePainter({
    required this.angle,
    required this.arcColor,
    required this.arrowColor,
    required this.backgroundArcColor,
    required this.arrowThickness,
    required this.arcThickness,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = min(size.width / 2, size.height) - arcThickness;

    // Desenha o arco cinza (fundo)
    final arcPaintBackground = Paint()
      ..color = backgroundArcColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = arcThickness;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi, // Início do arco
      pi, // Extensão do arco (180 graus)
      false,
      arcPaintBackground,
    );

    // Desenha o arco colorido
    final arcPaint = Paint()
      ..color = arcColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = arcThickness;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi,
      angle,
      false,
      arcPaint,
    );

    // Desenha a linha principal da seta
    final arrowPaint = Paint()
      ..color = arrowColor
      ..strokeWidth = arrowThickness
      ..strokeCap = StrokeCap.round;

    // Define o ponto inicial da seta um pouco abaixo do arco
    final arrowStart = Offset(center.dx, center.dy + arcThickness / 2);

    // Calcula o ponto final da seta ajustado para não invadir o arco
    final arrowEnd = Offset(
      center.dx + (radius - arcThickness) * cos(pi + angle),
      center.dy + (radius - arcThickness) * sin(pi + angle),
    );

    canvas.drawLine(arrowStart, arrowEnd, arrowPaint);

    // Desenha os "braços" da cabeça da seta
    final double arrowHeadSize = 10;
    final double arrowHeadAngle = pi / 4.5;

    final arrowLeft = Offset(
      arrowEnd.dx - arrowHeadSize * cos(pi + angle - arrowHeadAngle),
      arrowEnd.dy - arrowHeadSize * sin(pi + angle - arrowHeadAngle),
    );

    final arrowRight = Offset(
      arrowEnd.dx - arrowHeadSize * cos(pi + angle + arrowHeadAngle),
      arrowEnd.dy - arrowHeadSize * sin(pi + angle + arrowHeadAngle),
    );

    canvas.drawLine(arrowEnd, arrowLeft, arrowPaint);
    canvas.drawLine(arrowEnd, arrowRight, arrowPaint);

    // Ponto na base da seta (tamanho proporcional à espessura)
    final dotPaint = Paint()..color = arrowColor;
    canvas.drawCircle(arrowStart, arrowThickness * 3, dotPaint);
  }

  @override
  bool shouldRepaint(GaugePainter oldDelegate) {
    return oldDelegate.angle != angle ||
        oldDelegate.arcColor != arcColor ||
        oldDelegate.arrowThickness != arrowThickness ||
        oldDelegate.arcThickness != arcThickness ||
        oldDelegate.arrowColor != arrowColor ||
        oldDelegate.backgroundArcColor != backgroundArcColor;
  }
}
