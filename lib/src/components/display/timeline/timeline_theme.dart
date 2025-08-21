import 'package:flutter/material.dart';

/// ZephyrUI 时间线主题配置
///
/// 定义时间线组件的视觉样式，包括颜色、字体、边框等属性。
/// 支持明暗主题切换和自定义样式覆盖。
class ZephyrTimelineTheme {
  /// 背景颜色
  final Color backgroundColor;
  
  /// 边框颜色
  final Color borderColor;
  
  /// 边框宽度
  final double borderWidth;
  
  /// 边框圆角
  final BorderRadius borderRadius;
  
  /// 内边距
  final EdgeInsets padding;
  
  /// 主色调
  final Color primaryColor;
  
  /// 连接线颜色
  final Color connectorColor;
  
  /// 等待状态颜色
  final Color pendingColor;
  
  /// 进行中状态颜色
  final Color processingColor;
  
  /// 已完成状态颜色
  final Color completedColor;
  
  /// 已失败状态颜色
  final Color failedColor;
  
  /// 已取消状态颜色
  final Color cancelledColor;
  
  /// 标题文本样式
  final TextStyle titleStyle;
  
  /// 描述文本样式
  final TextStyle descriptionStyle;
  
  /// 时间文本样式
  final TextStyle timeStyle;
  
  /// 附加信息文本样式
  final TextStyle extraStyle;
  
  /// 创建时间线主题
  const ZephyrTimelineTheme({
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.padding,
    required this.primaryColor,
    required this.connectorColor,
    required this.pendingColor,
    required this.processingColor,
    required this.completedColor,
    required this.failedColor,
    required this.cancelledColor,
    required this.titleStyle,
    required this.descriptionStyle,
    required this.timeStyle,
    required this.extraStyle,
  });
  
  /// 创建明亮的时间线主题
  factory ZephyrTimelineTheme.light() {
    return ZephyrTimelineTheme(
      backgroundColor: Colors.white,
      borderColor: const Color(0xFFE5E7EB),
      borderWidth: 1.0,
      borderRadius: BorderRadius.circular(12.0),
      padding: const EdgeInsets.all(16.0),
      primaryColor: const Color(0xFF3B82F6),
      connectorColor: const Color(0xFFD1D5DB),
      pendingColor: const Color(0xFF9CA3AF),
      processingColor: const Color(0xFF3B82F6),
      completedColor: const Color(0xFF10B981),
      failedColor: const Color(0xFFEF4444),
      cancelledColor: const Color(0xFF6B7280),
      titleStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xFF111827),
      ),
      descriptionStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF6B7280),
      ),
      timeStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF9CA3AF),
      ),
      extraStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Color(0xFF6B7280),
      ),
    );
  }
  
  /// 创建暗色的时间线主题
  factory ZephyrTimelineTheme.dark() {
    return ZephyrTimelineTheme(
      backgroundColor: const Color(0xFF1F2937),
      borderColor: const Color(0xFF374151),
      borderWidth: 1.0,
      borderRadius: BorderRadius.circular(12.0),
      padding: const EdgeInsets.all(16.0),
      primaryColor: const Color(0xFF60A5FA),
      connectorColor: const Color(0xFF4B5563),
      pendingColor: const Color(0xFF9CA3AF),
      processingColor: const Color(0xFF60A5FA),
      completedColor: const Color(0xFF34D399),
      failedColor: const Color(0xFFF87171),
      cancelledColor: const Color(0xFF9CA3AF),
      titleStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xFFF9FAFB),
      ),
      descriptionStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFFD1D5DB),
      ),
      timeStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF9CA3AF),
      ),
      extraStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Color(0xFF9CA3AF),
      ),
    );
  }
  
  /// 创建自定义时间线主题
  factory ZephyrTimelineTheme.custom({
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    Color? primaryColor,
    Color? connectorColor,
    Color? pendingColor,
    Color? processingColor,
    Color? completedColor,
    Color? failedColor,
    Color? cancelledColor,
    TextStyle? titleStyle,
    TextStyle? descriptionStyle,
    TextStyle? timeStyle,
    TextStyle? extraStyle,
  }) {
    final baseTheme = ZephyrTimelineTheme.light();
    
    return ZephyrTimelineTheme(
      backgroundColor: backgroundColor ?? baseTheme.backgroundColor,
      borderColor: borderColor ?? baseTheme.borderColor,
      borderWidth: borderWidth ?? baseTheme.borderWidth,
      borderRadius: borderRadius ?? baseTheme.borderRadius,
      padding: padding ?? baseTheme.padding,
      primaryColor: primaryColor ?? baseTheme.primaryColor,
      connectorColor: connectorColor ?? baseTheme.connectorColor,
      pendingColor: pendingColor ?? baseTheme.pendingColor,
      processingColor: processingColor ?? baseTheme.processingColor,
      completedColor: completedColor ?? baseTheme.completedColor,
      failedColor: failedColor ?? baseTheme.failedColor,
      cancelledColor: cancelledColor ?? baseTheme.cancelledColor,
      titleStyle: titleStyle ?? baseTheme.titleStyle,
      descriptionStyle: descriptionStyle ?? baseTheme.descriptionStyle,
      timeStyle: timeStyle ?? baseTheme.timeStyle,
      extraStyle: extraStyle ?? baseTheme.extraStyle,
    );
  }
  
  /// 复制主题并修改部分属性
  ZephyrTimelineTheme copyWith({
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    Color? primaryColor,
    Color? connectorColor,
    Color? pendingColor,
    Color? processingColor,
    Color? completedColor,
    Color? failedColor,
    Color? cancelledColor,
    TextStyle? titleStyle,
    TextStyle? descriptionStyle,
    TextStyle? timeStyle,
    TextStyle? extraStyle,
  }) {
    return ZephyrTimelineTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      primaryColor: primaryColor ?? this.primaryColor,
      connectorColor: connectorColor ?? this.connectorColor,
      pendingColor: pendingColor ?? this.pendingColor,
      processingColor: processingColor ?? this.processingColor,
      completedColor: completedColor ?? this.completedColor,
      failedColor: failedColor ?? this.failedColor,
      cancelledColor: cancelledColor ?? this.cancelledColor,
      titleStyle: titleStyle ?? this.titleStyle,
      descriptionStyle: descriptionStyle ?? this.descriptionStyle,
      timeStyle: timeStyle ?? this.timeStyle,
      extraStyle: extraStyle ?? this.extraStyle,
    );
  }
  
  /// 主题合并
  ZephyrTimelineTheme merge(ZephyrTimelineTheme? other) {
    if (other == null) return this;
    
    return copyWith(
      backgroundColor: other.backgroundColor,
      borderColor: other.borderColor,
      borderWidth: other.borderWidth,
      borderRadius: other.borderRadius,
      padding: other.padding,
      primaryColor: other.primaryColor,
      connectorColor: other.connectorColor,
      pendingColor: other.pendingColor,
      processingColor: other.processingColor,
      completedColor: other.completedColor,
      failedColor: other.failedColor,
      cancelledColor: other.cancelledColor,
      titleStyle: other.titleStyle,
      descriptionStyle: other.descriptionStyle,
      timeStyle: other.timeStyle,
      extraStyle: other.extraStyle,
    );
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is ZephyrTimelineTheme &&
      other.backgroundColor == backgroundColor &&
      other.borderColor == borderColor &&
      other.borderWidth == borderWidth &&
      other.borderRadius == borderRadius &&
      other.padding == padding &&
      other.primaryColor == primaryColor &&
      other.connectorColor == connectorColor &&
      other.pendingColor == pendingColor &&
      other.processingColor == processingColor &&
      other.completedColor == completedColor &&
      other.failedColor == failedColor &&
      other.cancelledColor == cancelledColor &&
      other.titleStyle == titleStyle &&
      other.descriptionStyle == descriptionStyle &&
      other.timeStyle == timeStyle &&
      other.extraStyle == extraStyle;
  }
  
  @override
  int get hashCode {
    return Object.hashAll([
      backgroundColor,
      borderColor,
      borderWidth,
      borderRadius,
      padding,
      primaryColor,
      connectorColor,
      pendingColor,
      processingColor,
      completedColor,
      failedColor,
      cancelledColor,
      titleStyle,
      descriptionStyle,
      timeStyle,
      extraStyle,
    ]);
  }
}