import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:chroma_ui/src/core/theme/chroma_colors.dart';
import 'package:chroma_ui/src/core/theme/chroma_spacing.dart';
import 'package:chroma_ui/src/core/theme/chroma_typography.dart';

class chromaAreaChart extends StatefulWidget {
  final List<AreaChartData> data;
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
  final AxisLabelStyle? xAxisLabelStyle;
  final AxisLabelStyle? yAxisLabelStyle;
  final EdgeInsetsGeometry? margin;
  final bool stacked;
  final double? strokeWidth;
  final double? areaOpacity;
  final VoidCallback? onTap;
  final ValueChanged<AreaChartData?>? onHover;

  const chromaAreaChart({
    required this.data,
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
    this.xAxisLabelStyle,
    this.yAxisLabelStyle,
    this.margin,
    this.stacked = false,
    this.strokeWidth,
    this.areaOpacity,
    this.onTap,
    this.onHover,
    super.key,
  });

  @override
  State<chromaAreaChart> createState() => _chromaAreaChartState();
}

class _chromaAreaChartState extends State<chromaAreaChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  AreaChartData? _hoveredData;
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
            painter: AreaChartPainter(
              data: widget.data,
              animation: _animation.value,
              showGrid: widget.showGrid,
              gridColor: widget.gridColor ?? colors.outline.withOpacity(0.2),
              axisColor: widget.axisColor ?? colors.outline,
              xAxisLabelStyle: widget.xAxisLabelStyle ??
                  AxisLabelStyle(
                    color: colors.onSurface,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
              yAxisLabelStyle: widget.yAxisLabelStyle ??
                  AxisLabelStyle(
                    color: colors.onSurface,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
              stacked: widget.stacked,
              strokeWidth: widget.strokeWidth ?? 2.0,
              areaOpacity: widget.areaOpacity ?? 0.3,
              hoveredData: _hoveredData,
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: widget.data.map((series) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
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
                  const SizedBox(width: 6),
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
    // Calculate hover position and update hovered data
    setState(() {
      _hoverPosition = event.localPosition;
      // Implement hover logic to find nearest data point
      _hoveredData = _findNearestDataPoint(event.localPosition);
    });
    widget.onHover?.call(_hoveredData);
  }

  void _handleExit(PointerExitEvent event) {
    setState(() {
      _hoverPosition = null;
      _hoveredData = null;
    });
    widget.onHover?.call(null);
  }

  AreaChartData? _findNearestDataPoint(Offset position) {
    // Implement logic to find the nearest data point
    // This is a simplified version
    if (widget.data.isEmpty) return null;
    return widget.data.first;
  }
}

class AreaChartPainter extends CustomPainter {
  final List<AreaChartData> data;
  final double animation;
  final bool showGrid;
  final Color gridColor;
  final Color axisColor;
  final AxisLabelStyle xAxisLabelStyle;
  final AxisLabelStyle yAxisLabelStyle;
  final bool stacked;
  final double strokeWidth;
  final double areaOpacity;
  final AreaChartData? hoveredData;
  final Offset? hoverPosition;

  AreaChartPainter({
    required this.data,
    required this.animation,
    required this.showGrid,
    required this.gridColor,
    required this.axisColor,
    required this.xAxisLabelStyle,
    required this.yAxisLabelStyle,
    required this.stacked,
    required this.strokeWidth,
    required this.areaOpacity,
    this.hoveredData,
    this.hoverPosition,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final padding = 40.0;
    final chartWidth = size.width - 2 * padding;
    final chartHeight = size.height - 2 * padding;

    // Calculate data ranges
    final allPoints = data.expand((series) => series.points).toList();
    final xMin = allPoints.map((p) => p.x).reduce(math.min);
    final xMax = allPoints.map((p) => p.x).reduce(math.max);
    final yMin = stacked ? 0 : allPoints.map((p) => p.y).reduce(math.min);
    final yMax = stacked
        ? data.fold(0.0, (sum, series) => sum + series.points.map((p) => p.y).reduce(math.max))
        : allPoints.map((p) => p.y).reduce(math.max);

    // Draw grid
    if (showGrid) {
      _drawGrid(canvas, size, padding, chartWidth, chartHeight);
    }

    // Draw axes
    _drawAxes(canvas, size, padding, chartWidth, chartHeight);

    // Draw area charts
    for (int i = 0; i < data.length; i++) {
      _drawAreaChart(canvas, size, padding, chartWidth, chartHeight, xMin, xMax, yMin, yMax, data[i], i);
    }

    // Draw tooltip if hovering
    if (hoveredData != null && hoverPosition != null) {
      _drawTooltip(canvas, hoverPosition!, hoveredData!);
    }
  }

  void _drawGrid(Canvas canvas, Size size, double padding, double chartWidth, double chartHeight) {
    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1;

    // Vertical grid lines
    for (int i = 0; i <= 10; i++) {
      final x = padding + (chartWidth / 10) * i;
      canvas.drawLine(
        Offset(x, padding),
        Offset(x, size.height - padding),
        gridPaint,
      );
    }

    // Horizontal grid lines
    for (int i = 0; i <= 5; i++) {
      final y = padding + (chartHeight / 5) * i;
      canvas.drawLine(
        Offset(padding, y),
        Offset(size.width - padding, y),
        gridPaint,
      );
    }
  }

  void _drawAxes(Canvas canvas, Size size, double padding, double chartWidth, double chartHeight) {
    final axisPaint = Paint()
      ..color = axisColor
      ..strokeWidth = 2;

    // X-axis
    canvas.drawLine(
      Offset(padding, size.height - padding),
      Offset(size.width - padding, size.height - padding),
      axisPaint,
    );

    // Y-axis
    canvas.drawLine(
      Offset(padding, padding),
      Offset(padding, size.height - padding),
      axisPaint,
    );
  }

  void _drawAreaChart(
    Canvas canvas,
    Size size,
    double padding,
    double chartWidth,
    double chartHeight,
    double xMin,
    double xMax,
    double yMin,
    double yMax,
    AreaChartData series,
    int seriesIndex,
  ) {
    if (series.points.isEmpty) return;

    final path = Path();
    final areaPath = Path();
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        series.color.withOpacity(areaOpacity),
        series.color.withOpacity(0.0),
      ],
    );

    // Create points for the path
    final points = series.points.map((point) {
      final x = padding + ((point.x - xMin) / (xMax - xMin)) * chartWidth;
      final y = size.height - padding - ((point.y - yMin) / (yMax - yMin)) * chartHeight;
      return Offset(x, y);
    }).toList();

    // Apply animation
    final animatedPoints = points.map((point) {
      return Offset(
        point.dx,
        point.dy + (size.height - padding - point.dy) * (1 - animation),
      );
    }).toList();

    // Draw area
    areaPath.moveTo(animatedPoints.first.dx, size.height - padding);
    for (final point in animatedPoints) {
      areaPath.lineTo(point.dx, point.dy);
    }
    areaPath.lineTo(animatedPoints.last.dx, size.height - padding);
    areaPath.close();

    final areaPaint = Paint()
      ..shader = gradient.createShader(Rect.fromPoints(
        animatedPoints.first,
        Offset(animatedPoints.last.dx, size.height - padding),
      ));

    canvas.drawPath(areaPath, areaPaint);

    // Draw line
    path.moveTo(animatedPoints.first.dx, animatedPoints.first.dy);
    for (final point in animatedPoints.skip(1)) {
      path.lineTo(point.dx, point.dy);
    }

    final linePaint = Paint()
      ..color = series.color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, linePaint);

    // Draw points
    for (final point in animatedPoints) {
      canvas.drawCircle(point, 4, linePaint);
      canvas.drawCircle(point, 2, Paint()..color = Colors.white);
    }
  }

  void _drawTooltip(Canvas canvas, Offset position, AreaChartData data) {
    const tooltipPadding = 8.0;
    const tooltipRadius = 4.0;

    final textPainter = TextPainter(
      text: TextSpan(
        text: data.label,
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
  bool shouldRepaint(covariant AreaChartPainter oldDelegate) {
    return oldDelegate.animation != animation ||
        oldDelegate.data != data ||
        oldDelegate.hoveredData != hoveredData ||
        oldDelegate.hoverPosition != hoverPosition;
  }
}

class AreaChartData {
  final String label;
  final Color color;
  final List<AreaChartPoint> points;

  const AreaChartData({
    required this.label,
    required this.color,
    required this.points,
  });
}

class AreaChartPoint {
  final double x;
  final double y;
  final String? label;

  const AreaChartPoint({
    required this.x,
    required this.y,
    this.label,
  });
}

class AxisLabelStyle {
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;

  const AxisLabelStyle({
    required this.color,
    required this.fontSize,
    required this.fontWeight,
  });
}
