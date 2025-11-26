/// ZephyrUI 性能监控覆盖层
///
/// 提供实时性能监控、FPS显示、内存使用情况等性能指标。
library performance_overlay;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zephyr_ui/src/utils/performance/performance_optimizer.dart';
import 'package:zephyr_ui/zephyr_ui.dart';
// Using existing performance utilities

/// 性能监控覆盖层
class ZephyrPerformanceOverlay extends StatefulWidget {
  const ZephyrPerformanceOverlay({
    required this.child,
    super.key,
    this.enabled = true,
    this.level = PerformanceLevel.medium,
    this.showFPS = true,
    this.showMemory = true,
    this.showWidgetCount = true,
    this.showBuildTime = true,
    this.updateInterval = const Duration(milliseconds: 500),
  });
  final Widget child;
  final bool enabled;
  final PerformanceLevel level;
  final bool showFPS;
  final bool showMemory;
  final bool showWidgetCount;
  final bool showBuildTime;
  final Duration updateInterval;

  @override
  State<ZephyrPerformanceOverlay> createState() =>
      _ZephyrPerformanceOverlayState();
}

class _ZephyrPerformanceOverlayState extends State<ZephyrPerformanceOverlay> {
  late ZephyrEnhancedPerformanceMonitor _monitor;
  Timer? _updateTimer;

  // 性能数据
  double _currentFPS = 60.0;
  double _currentMemoryMB = 0.0;
  int _widgetCount = 0;
  double _avgBuildTime = 0.0;

  // 历史数据用于图表
  final List<double> _fpsHistory = [];
  final List<double> _memoryHistory = [];
  static const int _maxHistoryLength = 60;

  @override
  void initState() {
    super.initState();
    _monitor = ZephyrEnhancedPerformanceMonitor.instance;

    if (widget.enabled) {
      _startMonitoring();
    }
  }

  @override
  void didUpdateWidget(ZephyrPerformanceOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.enabled != widget.enabled) {
      if (widget.enabled) {
        _startMonitoring();
      } else {
        _stopMonitoring();
      }
    }
  }

  @override
  void dispose() {
    _stopMonitoring();
    super.dispose();
  }

  void _startMonitoring() {
    _monitor.startMonitoring(level: widget.level);

    _updateTimer = Timer.periodic(widget.updateInterval, (timer) {
      if (mounted) {
        _updatePerformanceData();
      }
    });
  }

  void _stopMonitoring() {
    _monitor.stopMonitoring();
    _updateTimer?.cancel();
  }

  void _updatePerformanceData() {
    final report = _monitor.getPerformanceReport();

    setState(() {
      // 更新FPS
      if (report.frameTimeStats.average > 0) {
        _currentFPS = 1000 / report.frameTimeStats.average;
      }

      // 更新内存使用
      _currentMemoryMB = report.memoryStats.average / 1024 / 1024;

      // 更新组件数量
      _widgetCount = report.widgetBuildStats.length;

      // 更新构建时间
      _avgBuildTime = report.widgetBuildStats.values.fold<double>(
            0,
            (sum, stats) => sum + stats.average,
          ) /
          (report.widgetBuildStats.isEmpty
              ? 1
              : report.widgetBuildStats.length);

      // 更新历史数据
      _fpsHistory.add(_currentFPS);
      _memoryHistory.add(_currentMemoryMB);

      if (_fpsHistory.length > _maxHistoryLength) {
        _fpsHistory.removeAt(0);
      }
      if (_memoryHistory.length > _maxHistoryLength) {
        _memoryHistory.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child;
    }

    return Stack(
      children: [
        widget.child,
        Positioned(
          top: 0,
          right: 0,
          child: _buildPerformancePanel(),
        ),
      ],
    );
  }

  Widget _buildPerformancePanel() {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          const SizedBox(height: 8),
          if (widget.showFPS) _buildFPSIndicator(),
          if (widget.showMemory) _buildMemoryIndicator(),
          if (widget.showWidgetCount) _buildWidgetCountIndicator(),
          if (widget.showBuildTime) _buildBuildTimeIndicator(),
          const SizedBox(height: 8),
          _buildMiniChart(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const Icon(
          Icons.speed,
          color: Colors.white,
          size: 16,
        ),
        const SizedBox(width: 8),
        const Text(
          'Performance Monitor',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => _showDetailedStats(),
          child: const Icon(
            Icons.info_outline,
            color: Colors.white70,
            size: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildFPSIndicator() {
    final color = _getPerformanceColor(_currentFPS, 55, 30);
    return _buildIndicatorRow(
      'FPS',
      _currentFPS.toStringAsFixed(1),
      color,
      Icons.timeline,
    );
  }

  Widget _buildMemoryIndicator() {
    final color =
        _getPerformanceColor(_currentMemoryMB, 100, 200, inverted: true);
    return _buildIndicatorRow(
      'Memory',
      '${_currentMemoryMB.toStringAsFixed(1)}MB',
      color,
      Icons.memory,
    );
  }

  Widget _buildWidgetCountIndicator() {
    final color =
        _getPerformanceColor(_widgetCount.toDouble(), 100, 200, inverted: true);
    return _buildIndicatorRow(
      'Widgets',
      _widgetCount.toString(),
      color,
      Icons.widgets,
    );
  }

  Widget _buildBuildTimeIndicator() {
    final color = _getPerformanceColor(_avgBuildTime, 16, 32, inverted: true);
    return _buildIndicatorRow(
      'Build',
      '${_avgBuildTime.toStringAsFixed(1)}ms',
      color,
      Icons.build,
    );
  }

  Widget _buildIndicatorRow(
      String label, String value, Color color, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 12,
          ),
          const SizedBox(width: 6),
          Text(
            '$label:',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 10,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniChart() {
    return SizedBox(
      height: 40,
      width: 120,
      child: CustomPaint(
        painter: _MiniChartPainter(
          fpsData: _fpsHistory,
          memoryData: _memoryHistory,
        ),
      ),
    );
  }

  Color _getPerformanceColor(
      double value, double goodThreshold, double badThreshold,
      {bool inverted = false}) {
    if (inverted) {
      if (value <= goodThreshold) return Colors.green;
      if (value <= badThreshold) return Colors.yellow;
      return Colors.red;
    } else {
      if (value >= goodThreshold) return Colors.green;
      if (value >= badThreshold) return Colors.yellow;
      return Colors.red;
    }
  }

  void _showDetailedStats() {
    final report = _monitor.getPerformanceReport();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Detailed Performance Stats'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailedStat(
                  'Average FPS',
                  report.frameTimeStats.average > 0
                      ? (1000 / report.frameTimeStats.average)
                          .toStringAsFixed(1)
                      : 'N/A'),
              _buildDetailedStat('Max Frame Time',
                  '${report.frameTimeStats.max.toStringAsFixed(2)}ms'),
              _buildDetailedStat('Memory Usage',
                  '${(report.memoryStats.average / 1024 / 1024).toStringAsFixed(1)}MB'),
              _buildDetailedStat('Widget Build Count',
                  report.widgetBuildStats.length.toString()),
              _buildDetailedStat(
                  'Total Metrics', report.metricsCount.toString()),
              const SizedBox(height: 16),
              const Text('Recommendations:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              ..._getRecommendations().map((rec) => Padding(
                    padding: const EdgeInsets.only(left: 8, top: 4),
                    child: Text('• $rec', style: const TextStyle(fontSize: 12)),
                  )),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedStat(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value),
        ],
      ),
    );
  }

  List<String> _getRecommendations() {
    final recommendations = <String>[];

    if (_currentFPS < 55) {
      recommendations.add(
          'FPS is low (${_currentFPS.toStringAsFixed(1)}). Consider optimizing widget rebuilds.');
    }

    if (_currentMemoryMB > 100) {
      recommendations.add(
          'Memory usage is high (${_currentMemoryMB.toStringAsFixed(1)}MB). Consider memory optimization.');
    }

    if (_widgetCount > 150) {
      recommendations.add(
          'High widget count ($_widgetCount). Consider reducing widget hierarchy.');
    }

    if (_avgBuildTime > 16) {
      recommendations.add(
          'Build time is high (${_avgBuildTime.toStringAsFixed(1)}ms). Consider optimizing build methods.');
    }

    if (recommendations.isEmpty) {
      recommendations.add('Performance is good!');
    }

    return recommendations;
  }
}

/// 迷你图表绘制器
class _MiniChartPainter extends CustomPainter {
  _MiniChartPainter({
    required this.fpsData,
    required this.memoryData,
  });
  final List<double> fpsData;
  final List<double> memoryData;

  @override
  void paint(Canvas canvas, Size size) {
    if (fpsData.isEmpty) return;

    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final path = Path();
    final stepX = size.width / (fpsData.length - 1);

    // 绘制FPS曲线
    for (var i = 0; i < fpsData.length; i++) {
      final x = i * stepX;
      final y = size.height - (fpsData[i] / 60) * size.height;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);

    // 绘制60FPS基准线
    final baselinePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..strokeWidth = 0.5;

    canvas.drawLine(
      Offset(0, size.height - size.height),
      Offset(size.width, size.height - size.height),
      baselinePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// 性能监控扩展
extension ZephyrPerformanceExtensions on BuildContext {
  /// 显示性能监控覆盖层
  Widget withPerformanceOverlay({
    required Widget child,
    bool enabled = true,
    PerformanceLevel level = PerformanceLevel.medium,
  }) {
    return ZephyrPerformanceOverlay(
      enabled: enabled,
      level: level,
      child: child,
    );
  }

  /// 获取当前性能报告
  EnhancedPerformanceReport getPerformanceReport() {
    return ZephyrEnhancedPerformanceMonitor.instance.getPerformanceReport();
  }

  /// 记录自定义性能指标
  void recordCustomMetric(String name, double value) {
    ZephyrEnhancedPerformanceMonitor.instance
        .measureExecutionTime(name, () => value);
  }
}
