import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:chroma_ui/src/core/theme/chroma_colors.dart';
import 'package:chroma_ui/src/core/theme/chroma_spacing.dart';
import 'package:chroma_ui/src/core/theme/chroma_typography.dart';

class chromaRadarChart extends StatefulWidget {
  final List<RadarChartData> data;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final bool showGrid;
  final bool showLegend;
  final bool showTooltip;
  final bool animate;
  final Duration animationDuration;
  final Color? gridColor;
  final Color? axisColor;
  final AxisLabelStyle? axisLabelStyle;
  final EdgeInsetsGeometry? margin;
  final bool fillAreas;
  final double? strokeWidth;
  final double? areaOpacity;
  final List<String> categories;
  final double? startAngle;
  final VoidCallback? onTap;
  final ValueChanged<RadarChartPoint?>? onHover;

  const chromaRadarChart({
    required this.data,
    required this.categories,
    this.width,
    this.height = 300,
    this.padding,
    this.showGrid = true,
    this.showLegend = true,
    this.showTooltip = true,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 800),
    this.gridColor,
    this.axisColor,
    this.axisLabelStyle,
    this.margin,
    this.fillAreas = true,
    this.strokeWidth,
    this.areaOpacity,
    this.startAngle,
    this.onTap,
    this.onHover,
    super.key,
  });

  @override
  State<chromaRadarChart> createState() => _chromaRadarChartState();
}

class _chromaRadarChartState extends State<chromaRadarChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  RadarChartPoint? _hoveredPoint;
  Offset? _hoverPosition;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    if (widget.animate) {
      _animationController.forward();
    } else {
      _animationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<chromaColors>()!;
    final spacing = theme.extension<chromaSpacing>()!;
    final typography = theme.extension<chromaTypography>()!;

    return Container(
      width: widget.width,
      height: widget.height,
      padding: widget.padding ?? spacing.paddingMd,
      margin: widget.margin,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: RadarChartPainter(
              data: widget.data,
              categories: widget.categories,
              animation: _animation.value,
              showGrid: widget.showGrid,
              gridColor: widget.gridColor ?? colors.outline.withOpacity(0.2),
              axisColor: widget.axisColor ?? colors.outline,
              axisLabelStyle: widget.axisLabelStyle ??
                  AxisLabelStyle(
                    color: colors.onSurface,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
              fillAreas: widget.fillAreas,
              strokeWidth: widget.strokeWidth ?? 2.0,
              areaOpacity: widget.areaOpacity ?? 0.3,
              startAngle: widget.startAngle ?? -math.pi / 2,
              hoveredPoint: _hoveredPoint,
              hoverPosition: _hoverPosition,
            ),
            child: MouseRegion(
              onHover: _handleHover,
              onExit: _handleExit,
              child: GestureDetector(
                onTap: widget.onTap,
                child: widget.showLegend ? _buildLegend(colors, typography) : null,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLegend(chromaColors colors, chromaTypography typography) {
    return Positioned(
      top: 8,
      right: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: colors.surface.withOpacity(0.9),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colors.outline.withOpacity(0.2)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.data.map((series) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: series.color,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    series.label,
                    style: typography.bodySmall?.copyWith(
                      color: colors.onSurface,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _handleHover(PointerHoverEvent event) {
    setState(() {
      _hoverPosition = event.localPosition;
      _hoveredPoint = _findNearestPoint(event.localPosition);
    });
    widget.onHover?.call(_hoveredPoint);
  }

  void _handleExit(PointerExitEvent event) {
    setState(() {
      _hoverPosition = null;
      _hoveredPoint = null;
    });
    widget.onHover?.call(null);
  }

  RadarChartPoint? _findNearestPoint(Offset position) {
    const threshold = 20.0;
    RadarChartPoint? nearestPoint;
    double minDistance = double.infinity;

    final center = Offset(
      (widget.width ?? 300) / 2,
      (widget.height ?? 300) / 2,
    );
    final radius = math.min(center.dx, center.dy) - 40;

    for (final series in widget.data) {
      for (int i = 0; i < series.points.length; i++) {
        final point = series.points[i];
        final angle = widget.startAngle! + (2 * math.pi * i / widget.categories.length);
        final pointRadius = (point.value / 100) * radius * _animation.value;
        final pointPosition = Offset(
          center.dx + pointRadius * math.cos(angle),
          center.dy + pointRadius * math.sin(angle),
        );

        final distance = (position - pointPosition).distance;
        if (distance < threshold && distance < minDistance) {
          minDistance = distance;
          nearestPoint = point;
        }
      }
    }

    return nearestPoint;
  }
}

class RadarChartPainter extends CustomPainter {
  final List<RadarChartData> data;
  final List<String> categories;
  final double animation;
  final bool showGrid;
  final Color gridColor;
  final Color axisColor;
  final AxisLabelStyle axisLabelStyle;
  final bool fillAreas;
  final double strokeWidth;
  final double areaOpacity;
  final double startAngle;
  final RadarChartPoint? hoveredPoint;
  final Offset? hoverPosition;

  RadarChartPainter({
    required this.data,
    required this.categories,
    required this.animation,
    required this.showGrid,
    required this.gridColor,
    required this.axisColor,
    required this.axisLabelStyle,
    required this.fillAreas,
    required this.strokeWidth,
    required this.areaOpacity,
    required this.startAngle,
    this.hoveredPoint,
    this.hoverPosition,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty || categories.isEmpty) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(center.dx, center.dy) - 40;

    // Draw grid
    if (showGrid) {
      _drawGrid(canvas, center, radius);
    }

    // Draw axes
    _drawAxes(canvas, center, radius);

    // Draw category labels
    _drawCategoryLabels(canvas, center, radius);

    // Draw radar data
    for (int i = 0; i < data.length; i++) {
      _drawRadarData(canvas, center, radius, data[i], i);
    }

    // Draw tooltip if hovering
    if (hoveredPoint != null && hoverPosition != null) {
      _drawTooltip(canvas, hoverPosition!, hoveredPoint!);
    }
  }

  void _drawGrid(Canvas canvas, Offset center, double radius) {
    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1;

    // Draw concentric circles
    for (int i = 1; i <= 5; i++) {
      final r = (radius / 5) * i;
      canvas.drawCircle(center, r, gridPaint);
    }

    // Draw radial lines
    for (int i = 0; i < categories.length; i++) {
      final angle = startAngle + (2 * math.pi * i / categories.length);
      final endX = center.dx + radius * math.cos(angle);
      final endY = center.dy + radius * math.sin(angle);
      canvas.drawLine(center, Offset(endX, endY), gridPaint);
    }
  }

  void _drawAxes(Canvas canvas, Offset center, double radius) {
    final axisPaint = Paint()
      ..color = axisColor
      ..strokeWidth = 2;

    // Draw main axes
    for (int i = 0; i < categories.length; i++) {
      final angle = startAngle + (2 * math.pi * i / categories.length);
      final endX = center.dx + radius * math.cos(angle);
      final endY = center.dy + radius * math.sin(angle);
      canvas.drawLine(center, Offset(endX, endY), axisPaint);
    }
  }

  void _drawCategoryLabels(Canvas canvas, Offset center, double radius) {
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < categories.length; i++) {
      final angle = startAngle + (2 * math.pi * i / categories.length);
      final labelRadius = radius + 20;
      final labelX = center.dx + labelRadius * math.cos(angle);
      final labelY = center.dy + labelRadius * math.sin(angle);

      textPainter.text = TextSpan(
        text: categories[i],
        style: TextStyle(
          color: axisLabelStyle.color,
          fontSize: axisLabelStyle.fontSize,
          fontWeight: axisLabelStyle.fontWeight,
        ),
      );

      textPainter.layout();

      // Adjust text position to avoid overlap
      final offset = Offset(
        labelX - textPainter.width / 2,
        labelY - textPainter.height / 2,
      );

      textPainter.paint(canvas, offset);
    }
  }

  void _drawRadarData(
    Canvas canvas,
    Offset center,
    double radius,
    RadarChartData series,
    int seriesIndex,
  ) {
    if (series.points.isEmpty || series.points.length != categories.length) return;

    final path = Path();
    final points = <Offset>[];

    // Calculate points
    for (int i = 0; i < series.points.length; i++) {
      final point = series.points[i];
      final angle = startAngle + (2 * math.pi * i / categories.length);
      final pointRadius = (point.value / 100) * radius * animation;
      final pointX = center.dx + pointRadius * math.cos(angle);
      final pointY = center.dy + pointRadius * math.sin(angle);
      points.add(Offset(pointX, pointY));
    }

    // Create path
    path.moveTo(points.first.dx, points.first.dy);
    for (final point in points.skip(1)) {
      path.lineTo(point.dx, point.dy);
    }
    path.close();

    // Fill area if enabled
    if (fillAreas) {
      final fillPaint = Paint()
        ..color = series.color.withOpacity(areaOpacity)
        ..style = PaintingStyle.fill;

      canvas.drawPath(path, fillPaint);
    }

    // Draw outline
    final strokePaint = Paint()
      ..color = series.color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, strokePaint);

    // Draw points
    for (final point in points) {
      canvas.drawCircle(point, 4, strokePaint);
      canvas.drawCircle(point, 2, Paint()..color = Colors.white);
    }

    // Highlight hovered point
    if (hoveredPoint != null && series.points.contains(hoveredPoint)) {
      final pointIndex = series.points.indexOf(hoveredPoint!);
      if (pointIndex >= 0 && pointIndex < points.length) {
        final point = points[pointIndex];
        final highlightPaint = Paint()
          ..color = Colors.white
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;

        canvas.drawCircle(point, 6, highlightPaint);
      }
    }
  }

  void _drawTooltip(Canvas canvas, Offset position, RadarChartPoint point) {
    const tooltipPadding = 8.0;
    const tooltipRadius = 4.0;

    final textPainter = TextPainter(
      text: TextSpan(
        text: 'Value: ${point.value.toStringAsFixed(1)}',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    final tooltipWidth = textPainter.width + tooltipPadding * 2;
    final tooltipHeight = textPainter.height + tooltipPadding * 2;

    final tooltipRect = Rect.fromLTWH(
      position.dx - tooltipWidth / 2,
      position.dy - tooltipHeight - 10,
      tooltipWidth,
      tooltipHeight,
    );

    final tooltipPaint = Paint()
      ..color = Colors.black.withOpacity(0.8)
      ..style = PaintingStyle.fill;

    final tooltipBorderPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Draw tooltip background
    final rRect = RRect.fromRectAndRadius(tooltipRect, Radius.circular(tooltipRadius));
    canvas.drawRRect(rRect, tooltipPaint);
    canvas.drawRRect(rRect, tooltipBorderPaint);

    // Draw tooltip text
    textPainter.paint(
      canvas,
      Offset(
        tooltipRect.left + tooltipPadding,
        tooltipRect.top + tooltipPadding,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant RadarChartPainter oldDelegate) {
    return oldDelegate.animation != animation ||
        oldDelegate.data != data ||
        oldDelegate.categories != categories ||
        oldDelegate.hoveredPoint != hoveredPoint ||
        oldDelegate.hoverPosition != hoverPosition;
  }
}

class RadarChartData {
  final String label;
  final Color color;
  final List<RadarChartPoint> points;

  const RadarChartData({
    required this.label,
    required this.color,
    required this.points,
  });
}

class RadarChartPoint {
  final double value;
  final String? label;
  final Map<String, dynamic>? metadata;

  const RadarChartPoint({
    required this.value,
    this.label,
    this.metadata,
  });
}
