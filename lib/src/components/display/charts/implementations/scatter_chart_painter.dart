import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../chart_types.dart';
import '../chart_theme.dart';

/// Scatter Plot Implementation
///
/// Features:
/// - Multiple series support
/// - Variable point sizes
/// - Color gradients
/// - Interactive tooltips
/// - Bubble chart capability
/// - Animation support
class ScatterChartPainter extends CustomPainter {
  final List<chromaChartSeries> series;
  final Animation<double> animation;
  final chromaChartTheme theme;
  final bool showGrid;
  final bool showLabels;
  final bool enableTooltips;
  final double minPointSize;
  final double maxPointSize;
  final Function(chromaChartDataPoint, chromaChartSeries)? onTap;

  ScatterChartPainter({
    required this.series,
    required this.animation,
    required this.theme,
    required this.showGrid,
    required this.showLabels,
    this.enableTooltips = true,
    this.minPointSize = 4,
    this.maxPointSize = 12,
    required this.onTap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (series.isEmpty) {
      _drawPlaceholder(canvas, size, '散点图');
      return;
    }

    final padding = theme.padding;
    final chartWidth = size.width - padding.horizontal;
    final chartHeight = size.height - padding.vertical;

    // Find data ranges
    final ranges = _calculateDataRanges();

    // Draw grid
    if (showGrid) {
      _drawGrid(canvas, size, padding, ranges);
    }

    // Draw axes
    _drawAxes(canvas, size, padding, ranges);

    // Draw scatter points
    _drawScatterPoints(canvas, size, padding, ranges);

    // Draw legend
    if (showLabels) {
      _drawLegend(canvas, size);
    }
  }

  Map<String, double> _calculateDataRanges() {
    double minX = double.infinity;
    double maxX = double.negativeInfinity;
    double minY = double.infinity;
    double maxY = double.negativeInfinity;
    double minSize = double.infinity;
    double maxSize = double.negativeInfinity;

    for (final seriesData in series) {
      for (final point in seriesData.data) {
        // Assuming X value is derived from index or metadata
        final xValue = point.metadata?['x'] ?? seriesData.data.indexOf(point).toDouble();
        final yValue = point.value;
        final sizeValue = point.metadata?['size'] ?? 1.0;

        minX = math.min(minX, xValue);
        maxX = math.max(maxX, xValue);
        minY = math.min(minY, yValue);
        maxY = math.max(maxY, yValue);
        minSize = math.min(minSize, sizeValue);
        maxSize = math.max(maxSize, sizeValue);
      }
    }

    return {
      'minX': minX,
      'maxX': maxX,
      'minY': minY,
      'maxY': maxY,
      'minSize': minSize,
      'maxSize': maxSize,
    };
  }

  void _drawGrid(Canvas canvas, Size size, EdgeInsets padding, Map<String, double> ranges) {
    final gridPaint = Paint()
      ..color = theme.gridColor
      ..strokeWidth = theme.gridWidth;

    final chartWidth = size.width - padding.horizontal;
    final chartHeight = size.height - padding.vertical;
    final gridLines = 5;

    // Vertical grid lines
    for (int i = 0; i <= gridLines; i++) {
      final x = padding.left + (i / gridLines) * chartWidth;
      canvas.drawLine(
        Offset(x, padding.top),
        Offset(x, size.height - padding.bottom),
        gridPaint,
      );
    }

    // Horizontal grid lines
    for (int i = 0; i <= gridLines; i++) {
      final y = padding.top + (i / gridLines) * chartHeight;
      canvas.drawLine(
        Offset(padding.left, y),
        Offset(size.width - padding.right, y),
        gridPaint,
      );
    }
  }

  void _drawAxes(Canvas canvas, Size size, EdgeInsets padding, Map<String, double> ranges) {
    final axisPaint = Paint()
      ..color = theme.axisColor
      ..strokeWidth = 2;

    final chartWidth = size.width - padding.horizontal;
    final chartHeight = size.height - padding.vertical;

    // X-axis
    canvas.drawLine(
      Offset(padding.left, size.height - padding.bottom),
      Offset(size.width - padding.right, size.height - padding.bottom),
      axisPaint,
    );

    // Y-axis
    canvas.drawLine(
      Offset(padding.left, padding.top),
      Offset(padding.left, size.height - padding.bottom),
      axisPaint,
    );

    // Draw axis labels
    _drawAxisLabels(canvas, size, padding, ranges);
  }

  void _drawAxisLabels(Canvas canvas, Size size, EdgeInsets padding, Map<String, double> ranges) {
    final chartWidth = size.width - padding.horizontal;
    final chartHeight = size.height - padding.vertical;
    final gridLines = 5;

    // X-axis labels
    for (int i = 0; i <= gridLines; i++) {
      final value = ranges['minX']! + (ranges['maxX']! - ranges['minX']!) * (i / gridLines);
      final x = padding.left + (i / gridLines) * chartWidth;
      final y = size.height - padding.bottom + 20;
      _drawText(canvas, value.toStringAsFixed(1), Offset(x, y), theme.labelStyle);
    }

    // Y-axis labels
    for (int i = 0; i <= gridLines; i++) {
      final value = ranges['minY']! + (ranges['maxY']! - ranges['minY']!) * (i / gridLines);
      final x = padding.left - 30;
      final y = size.height - padding.bottom - (i / gridLines) * chartHeight;
      _drawText(canvas, value.toStringAsFixed(1), Offset(x, y), theme.labelStyle);
    }
  }

  void _drawScatterPoints(Canvas canvas, Size size, EdgeInsets padding, Map<String, double> ranges) {
    final chartWidth = size.width - padding.horizontal;
    final chartHeight = size.height - padding.vertical;

    for (final seriesData in series) {
      for (final point in seriesData.data) {
        final xValue = point.metadata?['x'] ?? seriesData.data.indexOf(point).toDouble();
        final yValue = point.value;
        final sizeValue = point.metadata?['size'] ?? 1.0;

        // Calculate position
        final x = padding.left + ((xValue - ranges['minX']!) / (ranges['maxX']! - ranges['minX']!)) * chartWidth;
        final y = size.height - padding.bottom - ((yValue - ranges['minY']!) / (ranges['maxY']! - ranges['minY']!)) * chartHeight;

        // Calculate point size
        final normalizedSize = (sizeValue - ranges['minSize']!) / (ranges['maxSize']! - ranges['minSize']!);
        final pointSize = minPointSize + (maxPointSize - minPointSize) * normalizedSize;

        // Draw point with animation
        final animatedSize = pointSize * animation.value;
        _drawScatterPoint(canvas, Offset(x, y), animatedSize, seriesData.color, point);

        // Draw label if enabled
        if (showLabels) {
          _drawText(canvas, point.label, Offset(x, y - animatedSize - 5), theme.labelStyle);
        }
      }
    }
  }

  void _drawScatterPoint(Canvas canvas, Offset center, double size, Color color, chromaChartDataPoint point) {
    // Create gradient for bubble effect
    final gradient = RadialGradient(
      center: Alignment.center,
      radius: 1.0,
      colors: [
        color.withOpacity(0.8),
        color.withOpacity(0.4),
      ],
    );

    // Draw point
    final paint = Paint()
      ..shader = gradient.createShader(Rect.fromCircle(center: center, radius: size))
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, size, paint);

    // Draw border
    final borderPaint = Paint()
      ..color = color.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.drawCircle(center, size, borderPaint);

    // Draw highlight if needed
    if (point.metadata?['highlight'] == true) {
      final highlightPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;

      canvas.drawCircle(center, size + 2, highlightPaint);
    }
  }

  void _drawLegend(Canvas canvas, Size size) {
    final legendY = size.height - 50;
    var legendX = 20.0;

    for (final seriesData in series) {
      // Draw color indicator
      final paint = Paint()
        ..color = seriesData.color
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(legendX, legendY), 6, paint);

      // Draw series name
      _drawText(canvas, seriesData.name, Offset(legendX + 15, legendY + 5), theme.legendStyle);

      legendX += 100; // Spacing between legend items
    }
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
