import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:chroma_ui/src/core/theme/chroma_colors.dart';
import 'package:chroma_ui/src/core/theme/chroma_spacing.dart';
import 'package:chroma_ui/src/core/theme/chroma_typography.dart';

class chromaScatterChart extends StatefulWidget {
  final List<ScatterChartData> data;
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
  final double? minPointSize;
  final double? maxPointSize;
  final bool enableZoom;
  final bool enablePan;
  final VoidCallback? onTap;
  final ValueChanged<ScatterChartPoint?>? onHover;

  const chromaScatterChart({
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
    this.minPointSize = 4,
    this.maxPointSize = 20,
    this.enableZoom = false,
    this.enablePan = false,
    this.onTap,
    this.onHover,
    super.key,
  });

  @override
  State<chromaScatterChart> createState() => _chromaScatterChartState();
}

class _chromaScatterChartState extends State<chromaScatterChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  ScatterChartPoint? _hoveredPoint;
  Offset? _hoverPosition;
  double _scale = 1.0;
  Offset _offset = Offset.zero;

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
      child: ClipRect(
        child: Transform.scale(
          scale: _scale,
          child: Transform.translate(
            offset: _offset,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return CustomPaint(
                  painter: ScatterChartPainter(
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
                    minPointSize: widget.minPointSize!,
                    maxPointSize: widget.maxPointSize!,
                    hoveredPoint: _hoveredPoint,
                    hoverPosition: _hoverPosition,
                  ),
                  child: MouseRegion(
                    onHover: _handleHover,
                    onExit: _handleExit,
                    child: GestureDetector(
                      onTap: widget.onTap,
                      onScaleUpdate: widget.enableZoom ? _handleScaleUpdate : null,
                      onPanUpdate: widget.enablePan ? _handlePanUpdate : null,
                      child: widget.showLegend ? _buildLegend(colors, typography) : null,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
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
                      shape: BoxShape.circle,
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

  ScatterChartPoint? _findNearestPoint(Offset position) {
    const threshold = 20.0;
    ScatterChartPoint? nearestPoint;
    double minDistance = double.infinity;

    for (final series in widget.data) {
      for (final point in series.points) {
        final pointPosition = _convertDataToPoint(point);
        final distance = (position - pointPosition).distance;
        if (distance < threshold && distance < minDistance) {
          minDistance = distance;
          nearestPoint = point;
        }
      }
    }

    return nearestPoint;
  }

  Offset _convertDataToPoint(ScatterChartPoint point) {
    // This would be implemented in the painter with proper scaling
    return Offset.zero;
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _scale = details.scale.clamp(0.5, 3.0);
    });
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    setState(() {
      _offset += details.delta;
    });
  }
}

class ScatterChartPainter extends CustomPainter {
  final List<ScatterChartData> data;
  final double animation;
  final bool showGrid;
  final Color gridColor;
  final Color axisColor;
  final AxisLabelStyle xAxisLabelStyle;
  final AxisLabelStyle yAxisLabelStyle;
  final double minPointSize;
  final double maxPointSize;
  final ScatterChartPoint? hoveredPoint;
  final Offset? hoverPosition;

  ScatterChartPainter({
    required this.data,
    required this.animation,
    required this.showGrid,
    required this.gridColor,
    required this.axisColor,
    required this.xAxisLabelStyle,
    required this.yAxisLabelStyle,
    required this.minPointSize,
    required this.maxPointSize,
    this.hoveredPoint,
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
    final yMin = allPoints.map((p) => p.y).reduce(math.min);
    final yMax = allPoints.map((p) => p.y).reduce(math.max);
    final sizeMin = allPoints.map((p) => p.size).reduce(math.min);
    final sizeMax = allPoints.map((p) => p.size).reduce(math.max);

    // Draw grid
    if (showGrid) {
      _drawGrid(canvas, size, padding, chartWidth, chartHeight);
    }

    // Draw axes
    _drawAxes(canvas, size, padding, chartWidth, chartHeight);

    // Draw scatter points
    for (final series in data) {
      _drawScatterPoints(
        canvas,
        size,
        padding,
        chartWidth,
        chartHeight,
        xMin,
        xMax,
        yMin,
        yMax,
        sizeMin,
        sizeMax,
        series,
      );
    }

    // Draw tooltip if hovering
    if (hoveredPoint != null && hoverPosition != null) {
      _drawTooltip(canvas, hoverPosition!, hoveredPoint!);
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

  void _drawScatterPoints(
    Canvas canvas,
    Size size,
    double padding,
    double chartWidth,
    double chartHeight,
    double xMin,
    double xMax,
    double yMin,
    double yMax,
    double sizeMin,
    double sizeMax,
    ScatterChartData series,
  ) {
    if (series.points.isEmpty) return;

    for (final point in series.points) {
      final x = padding + ((point.x - xMin) / (xMax - xMin)) * chartWidth;
      final y = size.height - padding - ((point.y - yMin) / (yMax - yMin)) * chartHeight;
      final size = minPointSize +
          ((point.size - sizeMin) / (sizeMax - sizeMin)) * (maxPointSize - minPointSize);
      final animatedSize = size * animation;

      // Create gradient for bubble effect
      final gradient = RadialGradient(
        center: Alignment.center,
        radius: 0.8,
        colors: [
          series.color.withOpacity(0.8),
          series.color.withOpacity(0.4),
        ],
      );

      final paint = Paint()
        ..shader = gradient.createShader(Rect.fromCircle(
          center: Offset(x, y),
          radius: animatedSize,
        ));

      // Draw point
      canvas.drawCircle(Offset(x, y), animatedSize, paint);

      // Draw border
      final borderPaint = Paint()
        ..color = series.color
        ..strokeWidth = 1
        ..style = PaintingStyle.stroke;

      canvas.drawCircle(Offset(x, y), animatedSize, borderPaint);

      // Highlight hovered point
      if (point == hoveredPoint) {
        final highlightPaint = Paint()
          ..color = Colors.white
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;

        canvas.drawCircle(Offset(x, y), animatedSize + 2, highlightPaint);
      }
    }
  }

  void _drawTooltip(Canvas canvas, Offset position, ScatterChartPoint point) {
    const tooltipPadding = 8.0;
    const tooltipRadius = 4.0;

    final textPainter = TextPainter(
      text: TextSpan(
        text: 'X: ${point.x.toStringAsFixed(2)}, Y: ${point.y.toStringAsFixed(2)}',
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
  bool shouldRepaint(covariant ScatterChartPainter oldDelegate) {
    return oldDelegate.animation != animation ||
        oldDelegate.data != data ||
        oldDelegate.hoveredPoint != hoveredPoint ||
        oldDelegate.hoverPosition != hoverPosition;
  }
}

class ScatterChartData {
  final String label;
  final Color color;
  final List<ScatterChartPoint> points;

  const ScatterChartData({
    required this.label,
    required this.color,
    required this.points,
  });
}

class ScatterChartPoint {
  final double x;
  final double y;
  final double size;
  final String? label;
  final Map<String, dynamic>? metadata;

  const ScatterChartPoint({
    required this.x,
    required this.y,
    required this.size,
    this.label,
    this.metadata,
  });
}
