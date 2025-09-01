import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'chart_theme.dart';
import 'chart_types.dart';

/// ZephyrUI 图表组件
///
/// 提供各种数据可视化图表，支持多种图表类型和配置选项。
///
/// 示例用法:
/// ```dart
/// ZephyrChart(
///   type: ZephyrChartType.bar,
///   series: [
///     ZephyrChartSeries(
///       name: '销售额',
///       data: [
///         ZephyrChartDataPoint(label: '一月', value: 1000),
///         ZephyrChartDataPoint(label: '二月', value: 1500),
///       ],
///       color: Colors.blue,
///     ),
///   ],
/// )
/// ```
class ZephyrChart extends StatefulWidget {
  /// 图表类型
  final ZephyrChartType type;
  
  /// 数据系列
  final List<ZephyrChartSeries> series;
  
  /// 图表配置
  final ZephyrChartConfig config;
  
  /// 图表主题
  final ZephyrChartTheme? theme;
  
  /// 图表尺寸
  final Size? size;
  
  /// 点击数据点回调
  final Function(ZephyrChartDataPoint, ZephyrChartSeries)? onDataPointTap;

  const ZephyrChart({
    Key? key,
    required this.type,
    required this.series,
    this.config = const ZephyrChartConfig(),
    this.theme,
    this.size,
    this.onDataPointTap,
  }) : super(key: key);

  @override
  State<ZephyrChart> createState() => _ZephyrChartState();
}

class _ZephyrChartState extends State<ZephyrChart> 
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.config.enableAnimation 
          ? widget.config.animationDuration 
          : Duration.zero,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    
    if (widget.config.enableAnimation) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = widget.theme ?? ZephyrChartTheme.of(context);
    
    return Container(
      width: widget.size?.width,
      height: widget.size?.height,
      padding: widget.config.padding ?? effectiveTheme.padding,
      decoration: BoxDecoration(
        color: effectiveTheme.backgroundColor,
        borderRadius: effectiveTheme.borderRadius,
        border: Border.all(
          color: effectiveTheme.borderColor,
          width: effectiveTheme.borderWidth,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.config.title != null || widget.config.subtitle != null)
            _buildHeader(effectiveTheme),
          Expanded(
            child: _buildChartContent(effectiveTheme),
          ),
          if (widget.config.showLegend)
            _buildLegend(effectiveTheme),
        ],
      ),
    );
  }

  /// 构建图表标题
  Widget _buildHeader(ZephyrChartTheme theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.config.title != null)
            Text(
              widget.config.title!,
              style: theme.titleStyle,
            ),
          if (widget.config.subtitle != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                widget.config.subtitle!,
                style: theme.subtitleStyle,
              ),
            ),
        ],
      ),
    );
  }

  /// 构建图表内容
  Widget _buildChartContent(ZephyrChartTheme theme) {
    switch (widget.type) {
      case ZephyrChartType.bar:
        return _buildBarChart(theme);
      case ZephyrChartType.line:
        return _buildLineChart(theme);
      case ZephyrChartType.pie:
        return _buildPieChart(theme);
      case ZephyrChartType.area:
        return _buildAreaChart(theme);
      case ZephyrChartType.scatter:
        return _buildScatterChart(theme);
      case ZephyrChartType.radar:
        return _buildRadarChart(theme);
    }
  }

  /// 构建柱状图
  Widget _buildBarChart(ZephyrChartTheme theme) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: _BarChartPainter(
            series: widget.series,
            animation: _animation,
            theme: theme,
            showGrid: widget.config.showGrid,
            showLabels: widget.config.showLabels,
            onTap: widget.onDataPointTap,
          ),
        );
      },
    );
  }

  /// 构建折线图
  Widget _buildLineChart(ZephyrChartTheme theme) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: _LineChartPainter(
            series: widget.series,
            animation: _animation,
            theme: theme,
            showGrid: widget.config.showGrid,
            showLabels: widget.config.showLabels,
            onTap: widget.onDataPointTap,
          ),
        );
      },
    );
  }

  /// 构建饼图
  Widget _buildPieChart(ZephyrChartTheme theme) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: _PieChartPainter(
            series: widget.series,
            animation: _animation,
            theme: theme,
            showLabels: widget.config.showLabels,
            onTap: widget.onDataPointTap,
          ),
        );
      },
    );
  }

  /// 构建面积图
  Widget _buildAreaChart(ZephyrChartTheme theme) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: _AreaChartPainter(
            series: widget.series,
            animation: _animation,
            theme: theme,
            showGrid: widget.config.showGrid,
            showLabels: widget.config.showLabels,
            onTap: widget.onDataPointTap,
          ),
        );
      },
    );
  }

  /// 构建散点图
  Widget _buildScatterChart(ZephyrChartTheme theme) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: _ScatterChartPainter(
            series: widget.series,
            animation: _animation,
            theme: theme,
            showGrid: widget.config.showGrid,
            showLabels: widget.config.showLabels,
            onTap: widget.onDataPointTap,
          ),
        );
      },
    );
  }

  /// 构建雷达图
  Widget _buildRadarChart(ZephyrChartTheme theme) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: _RadarChartPainter(
            series: widget.series,
            animation: _animation,
            theme: theme,
            showGrid: widget.config.showGrid,
            showLabels: widget.config.showLabels,
            onTap: widget.onDataPointTap,
          ),
        );
      },
    );
  }

  /// 构建图例
  Widget _buildLegend(ZephyrChartTheme theme) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Wrap(
        spacing: 16,
        runSpacing: 8,
        children: widget.series.where((s) => s.visible).map((series) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: series.color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                series.name,
                style: theme.legendStyle,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

/// 柱状图画笔
class _BarChartPainter extends CustomPainter {
  final List<ZephyrChartSeries> series;
  final Animation<double> animation;
  final ZephyrChartTheme theme;
  final bool showGrid;
  final bool showLabels;
  final Function(ZephyrChartDataPoint, ZephyrChartSeries)? onTap;

  _BarChartPainter({
    required this.series,
    required this.animation,
    required this.theme,
    required this.showGrid,
    required this.showLabels,
    required this.onTap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (series.isEmpty) {
      _drawPlaceholder(canvas, size, '柱状图');
      return;
    }

    final padding = theme.padding;
    final chartWidth = size.width - padding.horizontal;
    final chartHeight = size.height - padding.vertical;
    final maxValue = _findMaxValue();
    final barWidth = chartWidth / (series.length * series[0].data.length);
    final groupWidth = barWidth * series.length;
    final spacing = (chartWidth - groupWidth * series[0].data.length) / (series[0].data.length + 1);

    // Draw grid
    if (showGrid) {
      _drawGrid(canvas, size, padding, maxValue);
    }

    // Draw bars
    for (int seriesIndex = 0; seriesIndex < series.length; seriesIndex++) {
      final seriesData = series[seriesIndex];
      final color = seriesData.color;
      
      for (int pointIndex = 0; pointIndex < seriesData.data.length; pointIndex++) {
        final dataPoint = seriesData.data[pointIndex];
        final barHeight = (dataPoint.value / maxValue) * chartHeight * animation.value;
        final x = padding.left + spacing + pointIndex * (groupWidth + spacing) + seriesIndex * barWidth;
        final y = padding.top + chartHeight - barHeight;

        final paint = Paint()
          ..color = color
          ..style = PaintingStyle.fill;

        final rect = Rect.fromLTWH(x, y, barWidth * 0.8, barHeight);
        canvas.drawRect(rect, paint);

        // Draw value labels
        if (showLabels) {
          _drawText(canvas, dataPoint.value.toString(), 
            Offset(x + barWidth * 0.4, y - 20), theme.labelStyle);
        }
      }
    }

    // Draw axis labels
    if (series.isNotEmpty) {
      for (int i = 0; i < series[0].data.length; i++) {
        final label = series[0].data[i].label;
        final x = padding.left + spacing + i * (groupWidth + spacing) + groupWidth / 2;
        final y = padding.top + chartHeight + 20;
        _drawText(canvas, label, Offset(x, y), theme.labelStyle);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// 折线图画笔
class _LineChartPainter extends CustomPainter {
  final List<ZephyrChartSeries> series;
  final Animation<double> animation;
  final ZephyrChartTheme theme;
  final bool showGrid;
  final bool showLabels;
  final Function(ZephyrChartDataPoint, ZephyrChartSeries)? onTap;

  _LineChartPainter({
    required this.series,
    required this.animation,
    required this.theme,
    required this.showGrid,
    required this.showLabels,
    required this.onTap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (series.isEmpty) {
      _drawPlaceholder(canvas, size, '折线图');
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

    // Draw lines
    for (final seriesData in series) {
      final color = seriesData.color;
      final path = Path();
      
      for (int i = 0; i < seriesData.data.length; i++) {
        final dataPoint = seriesData.data[i];
        final x = padding.left + (i / (seriesData.data.length - 1)) * chartWidth;
        final y = padding.top + chartHeight - (dataPoint.value / maxValue) * chartHeight * animation.value;
        
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }

        // Draw points
        final paint = Paint()
          ..color = color
          ..style = PaintingStyle.fill;
        
        canvas.drawCircle(Offset(x, y), 4, paint);

        // Draw value labels
        if (showLabels) {
          _drawText(canvas, dataPoint.value.toString(), 
            Offset(x, y - 20), theme.labelStyle);
        }
      }

      // Draw line
      final linePaint = Paint()
        ..color = color
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;
      
      canvas.drawPath(path, linePaint);
    }

    // Draw axis labels
    if (series.isNotEmpty) {
      for (int i = 0; i < series[0].data.length; i++) {
        final label = series[0].data[i].label;
        final x = padding.left + (i / (series[0].data.length - 1)) * chartWidth;
        final y = padding.top + chartHeight + 20;
        _drawText(canvas, label, Offset(x, y), theme.labelStyle);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// 饼图画笔
class _PieChartPainter extends CustomPainter {
  final List<ZephyrChartSeries> series;
  final Animation<double> animation;
  final ZephyrChartTheme theme;
  final bool showLabels;
  final Function(ZephyrChartDataPoint, ZephyrChartSeries)? onTap;

  _PieChartPainter({
    required this.series,
    required this.animation,
    required this.theme,
    required this.showLabels,
    required this.onTap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (series.isEmpty || series[0].data.isEmpty) {
      _drawPlaceholder(canvas, size, '饼图');
      return;
    }

    final padding = theme.padding;
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = math.min(size.width - padding.horizontal, size.height - padding.vertical) / 2 - 20;
    
    final totalValue = series[0].data.fold(0.0, (sum, point) => sum + point.value);
    double currentAngle = -math.pi / 2; // Start from top

    for (int i = 0; i < series[0].data.length; i++) {
      final dataPoint = series[0].data[i];
      final color = dataPoint.color ?? theme.defaultColors[i % theme.defaultColors.length];
      final sliceAngle = (dataPoint.value / totalValue) * 2 * math.pi * animation.value;

      // Draw pie slice
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
        currentAngle,
        sliceAngle,
        true,
        paint,
      );

      // Draw label
      if (showLabels) {
        final labelAngle = currentAngle + sliceAngle / 2;
        final labelX = centerX + math.cos(labelAngle) * (radius * 0.7);
        final labelY = centerY + math.sin(labelAngle) * (radius * 0.7);
        
        _drawText(canvas, 
          '${dataPoint.label}\n${((dataPoint.value / totalValue) * 100).toStringAsFixed(1)}%', 
          Offset(labelX, labelY), theme.labelStyle);
      }

      currentAngle += sliceAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// 面积图画笔
class _AreaChartPainter extends CustomPainter {
  final List<ZephyrChartSeries> series;
  final Animation<double> animation;
  final ZephyrChartTheme theme;
  final bool showGrid;
  final bool showLabels;
  final Function(ZephyrChartDataPoint, ZephyrChartSeries)? onTap;

  _AreaChartPainter({
    required this.series,
    required this.animation,
    required this.theme,
    required this.showGrid,
    required this.showLabels,
    required this.onTap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: 实现面积图绘制逻辑
    _drawPlaceholder(canvas, size, '面积图');
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// 散点图画笔
class _ScatterChartPainter extends CustomPainter {
  final List<ZephyrChartSeries> series;
  final Animation<double> animation;
  final ZephyrChartTheme theme;
  final bool showGrid;
  final bool showLabels;
  final Function(ZephyrChartDataPoint, ZephyrChartSeries)? onTap;

  _ScatterChartPainter({
    required this.series,
    required this.animation,
    required this.theme,
    required this.showGrid,
    required this.showLabels,
    required this.onTap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: 实现散点图绘制逻辑
    _drawPlaceholder(canvas, size, '散点图');
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// 雷达图画笔
class _RadarChartPainter extends CustomPainter {
  final List<ZephyrChartSeries> series;
  final Animation<double> animation;
  final ZephyrChartTheme theme;
  final bool showGrid;
  final bool showLabels;
  final Function(ZephyrChartDataPoint, ZephyrChartSeries)? onTap;

  _RadarChartPainter({
    required this.series,
    required this.animation,
    required this.theme,
    required this.showGrid,
    required this.showLabels,
    required this.onTap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: 实现雷达图绘制逻辑
    _drawPlaceholder(canvas, size, '雷达图');
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// 绘制占位符
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

/// 查找最大值
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

/// 绘制网格
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

/// 绘制文本
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