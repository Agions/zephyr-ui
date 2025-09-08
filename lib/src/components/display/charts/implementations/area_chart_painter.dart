import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../chart_types.dart';
import '../chart_theme.dart';

/// Area Chart Implementation
///
/// Features:
/// - Gradient fills
/// - Stacked areas
/// - Interactive tooltips
/// - Smooth curves
/// - Animation support
class AreaChartPainter extends CustomPainter {
  final List<chromaChartSeries> series;
  final Animation<double> animation;
  final chromaChartTheme theme;
  final bool showGrid;
  final bool showLabels;
  final bool stacked;
  final bool smoothCurve;
  final Function(chromaChartDataPoint, chromaChartSeries)? onTap;

  AreaChartPainter({
    required this.series,
    required this.animation,
    required this.theme,
    required this.showGrid,
    required this.showLabels,
    this.stacked = false,
    this.smoothCurve = false,
    required this.onTap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (series.isEmpty) {
      _drawPlaceholder(canvas, size, '面积图');
      return;
    }

    final padding = theme.padding;
    final chartWidth = size.width - padding.horizontal;
    final chartHeight = size.height - padding.vertical;
    final maxValue = _findMaxValue();

    // Draw grid
    if (showGrid) {
      _drawGrid(canvas, size, padding, maxValue);
    }

    // Draw areas
    if (stacked) {
      _drawStackedAreas(canvas, size, padding, maxValue);
    } else {
      _drawIndividualAreas(canvas, size, padding, maxValue);
    }

    // Draw axis labels
    _drawAxisLabels(canvas, size, padding);
  }

  void _drawIndividualAreas(Canvas canvas, Size size, EdgeInsets padding, double maxValue) {
    final chartWidth = size.width - padding.horizontal;
    final chartHeight = size.height - padding.vertical;

    for (final seriesData in series) {
      final areaPath = Path();
      final linePath = Path();
      final gradient = _createGradient(seriesData.color, size, padding);

      for (int i = 0; i < seriesData.data.length; i++) {
        final dataPoint = seriesData.data[i];
        final x = padding.left + (i / (seriesData.data.length - 1)) * chartWidth;
        final y = padding.top + chartHeight - (dataPoint.value / maxValue) * chartHeight * animation.value;

        if (i == 0) {
          areaPath.moveTo(x, padding.top + chartHeight);
          areaPath.lineTo(x, y);
          linePath.moveTo(x, y);
        } else {
          if (smoothCurve) {
            final prevX = padding.left + ((i - 1) / (seriesData.data.length - 1)) * chartWidth;
            final prevY = padding.top + chartHeight - (seriesData.data[i - 1].value / maxValue) * chartHeight * animation.value;
            final controlX = (prevX + x) / 2;

            areaPath.quadraticBezierTo(controlX, prevY, x, y);
            linePath.quadraticBezierTo(controlX, prevY, x, y);
          } else {
            areaPath.lineTo(x, y);
            linePath.lineTo(x, y);
          }
        }

        // Draw points
        if (showLabels) {
          _drawDataPoint(canvas, Offset(x, y), seriesData.color);
          _drawText(canvas, dataPoint.value.toString(), Offset(x, y - 20), theme.labelStyle);
        }
      }

      // Close area path
      areaPath.lineTo(padding.left + chartWidth, padding.top + chartHeight);
      areaPath.close();

      // Draw area with gradient
      final areaPaint = Paint()
        ..shader = gradient
        ..style = PaintingStyle.fill;

      canvas.drawPath(areaPath, areaPaint);

      // Draw line
      final linePaint = Paint()
        ..color = seriesData.color
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;

      canvas.drawPath(linePath, linePaint);
    }
  }

  void _drawStackedAreas(Canvas canvas, Size size, EdgeInsets padding, double maxValue) {
    final chartWidth = size.width - padding.horizontal;
    final chartHeight = size.height - padding.vertical;
    final stackedValues = List<double>.filled(series[0].data.length, 0);

    for (int seriesIndex = 0; seriesIndex < series.length; seriesIndex++) {
      final seriesData = series[seriesIndex];
      final areaPath = Path();
      final gradient = _createGradient(seriesData.color, size, padding);

      for (int i = 0; i < seriesData.data.length; i++) {
        final dataPoint = seriesData.data[i];
        final x = padding.left + (i / (seriesData.data.length - 1)) * chartWidth;
        final baseY = padding.top + chartHeight - (stackedValues[i] / maxValue) * chartHeight;
        final y = padding.top + chartHeight - ((stackedValues[i] + dataPoint.value) / maxValue) * chartHeight * animation.value;

        if (i == 0) {
          areaPath.moveTo(x, baseY);
          areaPath.lineTo(x, y);
        } else {
          areaPath.lineTo(x, y);
        }

        stackedValues[i] += dataPoint.value * animation.value;

        if (showLabels && seriesIndex == series.length - 1) {
          _drawDataPoint(canvas, Offset(x, y), seriesData.color);
          _drawText(canvas, stackedValues[i].toString(), Offset(x, y - 20), theme.labelStyle);
        }
      }

      // Close area path
      for (int i = seriesData.data.length - 1; i >= 0; i--) {
        final x = padding.left + (i / (seriesData.data.length - 1)) * chartWidth;
        final baseY = padding.top + chartHeight - (stackedValues[i] - seriesData.data[i].value * animation.value) / maxValue * chartHeight;
        areaPath.lineTo(x, baseY);
      }

      areaPath.close();

      // Draw area with gradient
      final areaPaint = Paint()
        ..shader = gradient
        ..style = PaintingStyle.fill;

      canvas.drawPath(areaPath, areaPaint);
    }
  }

  LinearGradient _createGradient(Color color, Size size, EdgeInsets padding) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        color.withOpacity(0.3),
        color.withOpacity(0.1),
        color.withOpacity(0.0),
      ],
      stops: const [0.0, 0.5, 1.0],
    );
  }

  void _drawDataPoint(Canvas canvas, Offset offset, Color color) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(offset, 4, paint);

    // Draw white border
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(offset, 4, borderPaint);
  }

  void _drawAxisLabels(Canvas canvas, Size size, EdgeInsets padding) {
    if (series.isNotEmpty) {
      final chartWidth = size.width - padding.horizontal;

      for (int i = 0; i < series[0].data.length; i++) {
        final label = series[0].data[i].label;
        final x = padding.left + (i / (series[0].data.length - 1)) * chartWidth;
        final y = size.height - padding.bottom + 20;
        _drawText(canvas, label, Offset(x, y), theme.labelStyle);
      }
    }
  }

  void _drawGrid(Canvas canvas, Size size, EdgeInsets padding, double maxValue) {
    final gridPaint = Paint()
      ..color = theme.gridColor
      ..strokeWidth = theme.gridWidth;

    final chartHeight = size.height - padding.vertical;
    final gridLines = 5;

    // Horizontal grid lines
    for (int i = 0; i <= gridLines; i++) {
      final y = padding.top + (chartHeight / gridLines) * i;
      canvas.drawLine(
        Offset(padding.left, y),
        Offset(size.width - padding.right, y),
        gridPaint,
      );
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
