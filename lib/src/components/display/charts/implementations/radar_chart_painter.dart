import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../chart_types.dart';
import '../chart_theme.dart';

/// Radar Chart Implementation
///
/// Features:
/// - Multi-axis radar display
/// - Filled areas with transparency
/// - Interactive tooltips
/// - Comparative analysis (multiple series)
/// - Animation support
/// - Customizable axis labels
class RadarChartPainter extends CustomPainter {
  final List<chromaChartSeries> series;
  final Animation<double> animation;
  final chromaChartTheme theme;
  final bool showGrid;
  final bool showLabels;
  final bool fillAreas;
  final bool showPoints;
  final double startAngle;
  final Function(chromaChartDataPoint, chromaChartSeries)? onTap;

  RadarChartPainter({
    required this.series,
    required this.animation,
    required this.theme,
    required this.showGrid,
    required this.showLabels,
    this.fillAreas = true,
    this.showPoints = true,
    this.startAngle = -math.pi / 2,
    required this.onTap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (series.isEmpty || series[0].data.isEmpty) {
      _drawPlaceholder(canvas, size, '雷达图');
      return;
    }

    final padding = theme.padding;
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = math.min(size.width - padding.horizontal, size.height - padding.vertical) / 2 - 20;

    // Draw grid
    if (showGrid) {
      _drawGrid(canvas, centerX, centerY, radius);
    }

    // Draw axes
    _drawAxes(canvas, centerX, centerY, radius);

    // Draw axis labels
    if (showLabels) {
      _drawAxisLabels(canvas, centerX, centerY, radius);
    }

    // Draw data series
    _drawDataSeries(canvas, centerX, centerY, radius);

    // Draw legend
    if (showLabels && series.length > 1) {
      _drawLegend(canvas, size);
    }
  }

  void _drawGrid(Canvas canvas, double centerX, double centerY, double radius) {
    final gridPaint = Paint()
      ..color = theme.gridColor
      ..strokeWidth = theme.gridWidth;

    final gridLevels = 5;

    // Draw concentric circles
    for (int i = 1; i <= gridLevels; i++) {
      final levelRadius = (radius * i) / gridLevels;
      canvas.drawCircle(Offset(centerX, centerY), levelRadius, gridPaint);
    }

    // Draw radial lines
    final angleStep = 2 * math.pi / series[0].data.length;
    for (int i = 0; i < series[0].data.length; i++) {
      final angle = startAngle + i * angleStep;
      final x = centerX + math.cos(angle) * radius;
      final y = centerY + math.sin(angle) * radius;

      canvas.drawLine(
        Offset(centerX, centerY),
        Offset(x, y),
        gridPaint,
      );
    }
  }

  void _drawAxes(Canvas canvas, double centerX, double centerY, double radius) {
    final axisPaint = Paint()
      ..color = theme.axisColor
      ..strokeWidth = 2;

    final angleStep = 2 * math.pi / series[0].data.length;

    for (int i = 0; i < series[0].data.length; i++) {
      final angle = startAngle + i * angleStep;
      final x = centerX + math.cos(angle) * radius;
      final y = centerY + math.sin(angle) * radius;

      canvas.drawLine(
        Offset(centerX, centerY),
        Offset(x, y),
        axisPaint,
      );
    }
  }

  void _drawAxisLabels(Canvas canvas, double centerX, double centerY, double radius) {
    final angleStep = 2 * math.pi / series[0].data.length;

    for (int i = 0; i < series[0].data.length; i++) {
      final angle = startAngle + i * angleStep;
      final labelRadius = radius + 30;
      final x = centerX + math.cos(angle) * labelRadius;
      final y = centerY + math.sin(angle) * labelRadius;

      _drawText(canvas, series[0].data[i].label, Offset(x, y), theme.labelStyle);
    }
  }

  void _drawDataSeries(Canvas canvas, double centerX, double centerY, double radius) {
    final maxValue = _findMaxValue();
    final angleStep = 2 * math.pi / series[0].data.length;

    for (int seriesIndex = 0; seriesIndex < series.length; seriesIndex++) {
      final seriesData = series[seriesIndex];
      final path = Path();

      // Calculate points and create path
      for (int i = 0; i < seriesData.data.length; i++) {
        final dataPoint = seriesData.data[i];
        final angle = startAngle + i * angleStep;
        final value = dataPoint.value * animation.value;
        final normalizedValue = value / maxValue;
        final pointRadius = radius * normalizedValue;

        final x = centerX + math.cos(angle) * pointRadius;
        final y = centerY + math.sin(angle) * pointRadius;

        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }

        // Draw points if enabled
        if (showPoints) {
          _drawDataPoint(canvas, Offset(x, y), seriesData.color);
        }
      }

      // Close path if filling areas
      if (fillAreas) {
        path.close();

        // Draw filled area
        final areaPaint = Paint()
          ..color = seriesData.color.withOpacity(0.3)
          ..style = PaintingStyle.fill;

        canvas.drawPath(path, areaPaint);
      }

      // Draw outline
      final outlinePaint = Paint()
        ..color = seriesData.color
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;

      canvas.drawPath(path, outlinePaint);
    }
  }

  void _drawDataPoint(Canvas canvas, Offset center, Color color) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 4, paint);

    // Draw white border
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(center, 4, borderPaint);
  }

  void _drawLegend(Canvas canvas, Size size) {
    final legendY = size.height - 50;
    var legendX = 20.0;

    for (final seriesData in series) {
      // Draw color indicator
      final paint = Paint()
        ..color = seriesData.color
        ..style = PaintingStyle.fill;

      final rect = Rect.fromLTWH(legendX, legendY - 8, 16, 16);
      canvas.drawRect(rect, paint);

      // Draw series name
      _drawText(canvas, seriesData.name, Offset(legendX + 20, legendY), theme.legendStyle);

      legendX += 120; // Spacing between legend items
    }
  }

  double _findMaxValue() {
    double maxValue = 0;
    for (final series in this.series) {
      for (final point in series.data) {
        if (point.value > maxValue) {
          maxValue = point.value;
        }
      }
    }
    return maxValue;
  }

  void _drawPlaceholder(Canvas canvas, Size size, String text) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: '$text (开发中)',
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );

    final offset = Offset(
      (size.width - textPainter.width) / 2,
      (size.height - textPainter.height) / 2,
    );

    textPainter.paint(canvas, offset);
  }

  void _drawText(Canvas canvas, String text, Offset offset, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: style,
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: 200,
    );

    textPainter.paint(canvas, offset - Offset(textPainter.width / 2, textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
