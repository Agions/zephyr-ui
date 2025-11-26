/// 图表类型定义
library chart_types;

import 'package:flutter/material.dart';

/// 图表类型枚举
enum ZephyrChartType {
  /// 柱状图
  bar,

  /// 折线图
  line,

  /// 饼图
  pie,

  /// 面积图
  area,

  /// 散点图
  scatter,

  /// 雷达图
  radar,
}

/// 图表数据点
class ZephyrChartDataPoint {
  const ZephyrChartDataPoint({
    required this.label,
    required this.value,
    this.color,
    this.metadata,
  });
  final String label;
  final double value;
  final Color? color;
  final Map<String, dynamic>? metadata;
}

/// 图表数据系列
class ZephyrChartSeries {
  const ZephyrChartSeries({
    required this.name,
    required this.data,
    required this.color,
    this.visible = true,
    this.metadata,
  });
  final String name;
  final List<ZephyrChartDataPoint> data;
  final Color color;
  final bool visible;
  final Map<String, dynamic>? metadata;
}

/// 图表配置
class ZephyrChartConfig {
  const ZephyrChartConfig({
    this.showLegend = true,
    this.showGrid = true,
    this.showTooltip = true,
    this.showLabels = true,
    this.enableAnimation = true,
    this.animationDuration = const Duration(milliseconds: 1000),
    this.title,
    this.subtitle,
    this.padding,
  });
  final bool showLegend;
  final bool showGrid;
  final bool showTooltip;
  final bool showLabels;
  final bool enableAnimation;
  final Duration animationDuration;
  final String? title;
  final String? subtitle;
  final EdgeInsets? padding;
}
