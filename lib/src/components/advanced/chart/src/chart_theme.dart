import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/// ZephyrUI 图表主题配置
///
/// 提供图表的样式配置选项，包括颜色、字体、边框等。
class ZephyrChartTheme {
  /// 背景颜色
  final Color backgroundColor;
  
  /// 边框颜色
  final Color borderColor;
  
  /// 边框宽度
  final double borderWidth;
  
  /// 边框圆角
  final BorderRadius borderRadius;
  
  /// 标题样式
  final TextStyle titleStyle;
  
  /// 副标题样式
  final TextStyle subtitleStyle;
  
  /// 图例样式
  final TextStyle legendStyle;
  
  /// 标签样式
  final TextStyle labelStyle;
  
  /// 网格线颜色
  final Color gridColor;
  
  /// 网格线宽度
  final double gridWidth;
  
  /// 工具提示背景颜色
  final Color tooltipBackgroundColor;
  
  /// 工具提示文本颜色
  final Color tooltipTextColor;
  
  /// 工具提示边框颜色
  final Color tooltipBorderColor;
  
  /// 内边距
  final EdgeInsets padding;
  
  /// 默认颜色列表
  final List<Color> defaultColors;

  /// 创建亮色主题
  const ZephyrChartTheme.light()
      : backgroundColor = Colors.white,
        borderColor = const Color(0xFFE5E7EB),
        borderWidth = 1.0,
        borderRadius = const BorderRadius.all(Radius.circular(8)),
        titleStyle = const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1F2937),
        ),
        subtitleStyle = const TextStyle(
          fontSize: 14,
          color: Color(0xFF6B7280),
        ),
        legendStyle = const TextStyle(
          fontSize: 12,
          color: Color(0xFF6B7280),
        ),
        labelStyle = const TextStyle(
          fontSize: 12,
          color: Color(0xFF6B7280),
        ),
        gridColor = const Color(0xFFE5E7EB),
        gridWidth = 1.0,
        tooltipBackgroundColor = const Color(0xFF1F2937),
        tooltipTextColor = Colors.white,
        tooltipBorderColor = const Color(0xFF374151),
        padding = const EdgeInsets.all(16),
        defaultColors = const [
          Color(0xFF3B82F6),
          Color(0xFF10B981),
          Color(0xFFF59E0B),
          Color(0xFFEF4444),
          Color(0xFF8B5CF6),
          Color(0xFF06B6D4),
          Color(0xFFF97316),
          Color(0xFF84CC16),
        ];

  /// 创建暗色主题
  const ZephyrChartTheme.dark()
      : backgroundColor = const Color(0xFF1F2937),
        borderColor = const Color(0xFF374151),
        borderWidth = 1.0,
        borderRadius = const BorderRadius.all(Radius.circular(8)),
        titleStyle = const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFFF9FAFB),
        ),
        subtitleStyle = const TextStyle(
          fontSize: 14,
          color: Color(0xFF9CA3AF),
        ),
        legendStyle = const TextStyle(
          fontSize: 12,
          color: Color(0xFF9CA3AF),
        ),
        labelStyle = const TextStyle(
          fontSize: 12,
          color: Color(0xFF9CA3AF),
        ),
        gridColor = const Color(0xFF374151),
        gridWidth = 1.0,
        tooltipBackgroundColor = const Color(0xFFF9FAFB),
        tooltipTextColor = const Color(0xFF1F2937),
        tooltipBorderColor = const Color(0xFF6B7280),
        padding = const EdgeInsets.all(16),
        defaultColors = const [
          Color(0xFF60A5FA),
          Color(0xFF34D399),
          Color(0xFFFBBF24),
          Color(0xFFF87171),
          Color(0xFFA78BFA),
          Color(0xFF22D3EE),
          Color(0xFFFB923C),
          Color(0xFFA3E635),
        ];

  /// 创建自定义主题
  const ZephyrChartTheme({
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.titleStyle,
    required this.subtitleStyle,
    required this.legendStyle,
    required this.labelStyle,
    required this.gridColor,
    required this.gridWidth,
    required this.tooltipBackgroundColor,
    required this.tooltipTextColor,
    required this.tooltipBorderColor,
    required this.padding,
    required this.defaultColors,
  });

  /// 从上下文获取主题
  static ZephyrChartTheme of(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark 
        ? const ZephyrChartTheme.dark() 
        : const ZephyrChartTheme.light();
  }

  /// 创建主题副本
  ZephyrChartTheme copyWith({
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    BorderRadius? borderRadius,
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    TextStyle? legendStyle,
    TextStyle? labelStyle,
    Color? gridColor,
    double? gridWidth,
    Color? tooltipBackgroundColor,
    Color? tooltipTextColor,
    Color? tooltipBorderColor,
    EdgeInsets? padding,
    List<Color>? defaultColors,
  }) {
    return ZephyrChartTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      titleStyle: titleStyle ?? this.titleStyle,
      subtitleStyle: subtitleStyle ?? this.subtitleStyle,
      legendStyle: legendStyle ?? this.legendStyle,
      labelStyle: labelStyle ?? this.labelStyle,
      gridColor: gridColor ?? this.gridColor,
      gridWidth: gridWidth ?? this.gridWidth,
      tooltipBackgroundColor: tooltipBackgroundColor ?? this.tooltipBackgroundColor,
      tooltipTextColor: tooltipTextColor ?? this.tooltipTextColor,
      tooltipBorderColor: tooltipBorderColor ?? this.tooltipBorderColor,
      padding: padding ?? this.padding,
      defaultColors: defaultColors ?? this.defaultColors,
    );
  }

  /// 合并主题
  ZephyrChartTheme merge(ZephyrChartTheme other) {
    return copyWith(
      backgroundColor: other.backgroundColor,
      borderColor: other.borderColor,
      borderWidth: other.borderWidth,
      borderRadius: other.borderRadius,
      titleStyle: other.titleStyle,
      subtitleStyle: other.subtitleStyle,
      legendStyle: other.legendStyle,
      labelStyle: other.labelStyle,
      gridColor: other.gridColor,
      gridWidth: other.gridWidth,
      tooltipBackgroundColor: other.tooltipBackgroundColor,
      tooltipTextColor: other.tooltipTextColor,
      tooltipBorderColor: other.tooltipBorderColor,
      padding: other.padding,
      defaultColors: other.defaultColors,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ZephyrChartTheme &&
        other.backgroundColor == backgroundColor &&
        other.borderColor == borderColor &&
        other.borderWidth == borderWidth &&
        other.borderRadius == borderRadius &&
        other.titleStyle == titleStyle &&
        other.subtitleStyle == subtitleStyle &&
        other.legendStyle == legendStyle &&
        other.labelStyle == labelStyle &&
        other.gridColor == gridColor &&
        other.gridWidth == gridWidth &&
        other.tooltipBackgroundColor == tooltipBackgroundColor &&
        other.tooltipTextColor == tooltipTextColor &&
        other.tooltipBorderColor == tooltipBorderColor &&
        other.padding == padding &&
        listEquals(other.defaultColors, defaultColors);
  }

  @override
  int get hashCode {
    return Object.hashAll([
      backgroundColor,
      borderColor,
      borderWidth,
      borderRadius,
      titleStyle,
      subtitleStyle,
      legendStyle,
      labelStyle,
      gridColor,
      gridWidth,
      tooltipBackgroundColor,
      tooltipTextColor,
      tooltipBorderColor,
      padding,
      ...defaultColors,
    ]);
  }
}