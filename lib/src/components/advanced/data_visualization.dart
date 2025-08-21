import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

class ZDataVisualization extends StatelessWidget {
  final List<ChartData> data;
  final ChartType type;
  final String title;
  final String? subtitle;
  final bool showLegend;
  final bool showGrid;
  final Color? primaryColor;
  final double? height;

  const ZDataVisualization({
    super.key,
    required this.data,
    required this.type,
    required this.title,
    this.subtitle,
    this.showLegend = true,
    this.showGrid = true,
    this.primaryColor,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                PopupMenuButton<ChartType>(
                  initialValue: type,
                  onSelected: (newType) {
                    // 这里可以添加类型切换逻辑
                  },
                  itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: ChartType.bar,
                          child: Text('柱状图'),
                        ),
                        const PopupMenuItem(
                          value: ChartType.line,
                          child: Text('折线图'),
                        ),
                        const PopupMenuItem(
                          value: ChartType.pie,
                          child: Text('饼图'),
                        ),
                      ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: height ?? 300,
              child: _buildChart(context),
            ),
            if (showLegend) ...[
              const SizedBox(height: 16),
              _buildLegend(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildChart(BuildContext context) {
    final color = primaryColor ?? Theme.of(context).primaryColor;
    
    switch (type) {
      case ChartType.bar:
        return _buildBarChart(color);
      case ChartType.line:
        return _buildLineChart(color);
      case ChartType.pie:
        return _buildPieChart(color);
      case ChartType.area:
        return _buildAreaChart(color);
      case ChartType.scatter:
        return _buildScatterChart(color);
      default:
        return _buildBarChart(color);
    }
  }

  Widget _buildBarChart(Color color) {
    if (data.isEmpty) return const Center(child: Text('暂无数据'));
    
    final maxValue = data.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    
    return Row(
      children: data.map((item) {
        final height = (item.value / maxValue) * 200;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: height,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.label,
                  style: const TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  item.value.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLineChart(Color color) {
    if (data.isEmpty) return const Center(child: Text('暂无数据'));
    
    final points = data.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      final x = (index / (data.length - 1)) * 300;
      final maxValue = data.map((e) => e.value).reduce((a, b) => a > b ? a : b);
      final y = 200 - (item.value / maxValue) * 200;
      return Offset(x, y);
    }).toList();

    return CustomPaint(
      painter: LineChartPainter(points, color),
      size: const Size(300, 200),
    );
  }

  Widget _buildPieChart(Color color) {
    if (data.isEmpty) return const Center(child: Text('暂无数据'));
    
    final total = data.map((e) => e.value).reduce((a, b) => a + b);
    final colors = _generateColors(data.length, color);
    
    return SizedBox(
      width: 200,
      height: 200,
      child: CustomPaint(
        painter: PieChartPainter(data, colors, total),
      ),
    );
  }

  Widget _buildAreaChart(Color color) {
    // 类似于折线图，但填充区域
    return _buildLineChart(color);
  }

  Widget _buildScatterChart(Color color) {
    if (data.isEmpty) return const Center(child: Text('暂无数据'));
    
    return CustomPaint(
      painter: ScatterChartPainter(data, color),
      size: const Size(300, 200),
    );
  }

  Widget _buildLegend() {
    final colors = _generateColors(data.length, primaryColor ?? Colors.blue);
    
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: data.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: colors[index],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              item.label,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        );
      }).toList(),
    );
  }

  List<Color> _generateColors(int count, Color baseColor) {
    return List.generate(count, (index) {
      final hue = (baseColor.hue + (index * 360 / count)) % 360;
      return HSVColor.fromAHSV(1, hue, 0.8, 0.9).toColor();
    });
  }
}

class ChartData {
  final String label;
  final double value;
  final Color? color;

  const ChartData({
    required this.label,
    required this.value,
    this.color,
  });
}

enum ChartType {
  bar,
  line,
  pie,
  area,
  scatter,
}

class LineChartPainter extends CustomPainter {
  final List<Offset> points;
  final Color color;

  LineChartPainter(this.points, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(points[0].dx, points[0].dy);
    
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    canvas.drawPath(path, paint);

    // 绘制数据点
    for (final point in points) {
      canvas.drawCircle(point, 4, paint..style = PaintingStyle.fill);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class PieChartPainter extends CustomPainter {
  final List<ChartData> data;
  final List<Color> colors;
  final double total;

  PieChartPainter(this.data, this.colors, this.total);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 10;
    
    double startAngle = -math.pi / 2;
    
    for (int i = 0; i < data.length; i++) {
      final item = data[i];
      final sweepAngle = (item.value / total) * 2 * math.pi;
      
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.fill;
      
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );
      
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class ScatterChartPainter extends CustomPainter {
  final List<ChartData> data;
  final Color color;

  ScatterChartPainter(this.data, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final maxValue = data.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (int i = 0; i < data.length; i++) {
      final item = data[i];
      final x = (i / (data.length - 1)) * (size.width - 20) + 10;
      final y = size.height - (item.value / maxValue) * (size.height - 20) - 10;
      
      canvas.drawCircle(Offset(x, y), 6, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}