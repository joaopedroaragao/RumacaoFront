import 'dart:math';
import 'package:flutter/material.dart';

class ChartSegment {
  final double value; // Valor numérico (por exemplo, 32.35)
  final Color color;

  ChartSegment({required this.value, required this.color});
}

class CircularChart extends StatelessWidget {
  final List<ChartSegment> segments;
  final double size;
  final double strokeWidth;

  const CircularChart({
    super.key,
    required this.segments,
    this.size = 150,
    this.strokeWidth = 10,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _CircularChartPainter(segments: segments, strokeWidth: strokeWidth),
    );
  }
}

class _CircularChartPainter extends CustomPainter {
  final List<ChartSegment> segments;
  final double strokeWidth;

  _CircularChartPainter({required this.segments, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (min(size.width, size.height) - strokeWidth) / 2;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    // Calcula o total para normalizar os valores
    final total = segments.fold(0.0, (prev, seg) => prev + seg.value);
    double startAngle = -pi / 2; // Inicia no topo

    for (final segment in segments) {
      final sweepAngle = 2 * pi * (segment.value / total);
      paint.color = segment.color;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant _CircularChartPainter oldDelegate) {
    return oldDelegate.segments != segments || oldDelegate.strokeWidth != strokeWidth;
  }
}
