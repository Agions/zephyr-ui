import 'package:flutter/material.dart';

/// ZephyrUI 统计卡片主题配置
///
/// 定义统计卡片组件的视觉样式，包括颜色、字体、边框等属性。
/// 支持明暗主题切换和自定义样式覆盖。
class ZephyrStatisticTheme {
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
  
  /// 成功颜色
  final Color successColor;
  
  /// 警告颜色
  final Color warningColor;
  
  /// 错误颜色
  final Color errorColor;
  
  /// 信息颜色
  final Color infoColor;
  
  /// 标题文本样式
  final TextStyle titleStyle;
  
  /// 数值文本样式
  final TextStyle valueStyle;
  
  /// 描述文本样式
  final TextStyle descriptionStyle;
  
  /// 趋势文本样式
  final TextStyle trendStyle;
  
  /// 图标大小
  final double iconSize;
  
  /// 是否显示边框
  final bool showBorder;
  
  /// 创建统计卡片主题
  const ZephyrStatisticTheme({
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.padding,
    required this.primaryColor,
    required this.successColor,
    required this.warningColor,
    required this.errorColor,
    required this.infoColor,
    required this.titleStyle,
    required this.valueStyle,
    required this.descriptionStyle,
    required this.trendStyle,
    required this.iconSize,
    required this.showBorder,
  });
  
  /// 创建明亮的统计卡片主题
  factory ZephyrStatisticTheme.light() {
    return ZephyrStatisticTheme(
      backgroundColor: Colors.white,
      borderColor: const Color(0xFFE5E7EB),
      borderWidth: 1.0,
      borderRadius: BorderRadius.circular(12.0),
      padding: const EdgeInsets.all(20.0),
      primaryColor: const Color(0xFF3B82F6),
      successColor: const Color(0xFF10B981),
      warningColor: const Color(0xFFF59E0B),
      errorColor: const Color(0xFFEF4444),
      infoColor: const Color(0xFF6366F1),
      titleStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF6B7280),
      ),
      valueStyle: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: Color(0xFF111827),
      ),
      descriptionStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF9CA3AF),
      ),
      trendStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      iconSize: 24.0,
      showBorder: true,
    );
  }
  
  /// 创建暗色的统计卡片主题
  factory ZephyrStatisticTheme.dark() {
    return ZephyrStatisticTheme(
      backgroundColor: const Color(0xFF1F2937),
      borderColor: const Color(0xFF374151),
      borderWidth: 1.0,
      borderRadius: BorderRadius.circular(12.0),
      padding: const EdgeInsets.all(20.0),
      primaryColor: const Color(0xFF60A5FA),
      successColor: const Color(0xFF34D399),
      warningColor: const Color(0xFFFCD34D),
      errorColor: const Color(0xFFF87171),
      infoColor: const Color(0xFF818CF8),
      titleStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF9CA3AF),
      ),
      valueStyle: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: Color(0xFFF9FAFB),
      ),
      descriptionStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(0xFF6B7280),
      ),
      trendStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      iconSize: 24.0,
      showBorder: true,
    );
  }
  
  /// 创建自定义统计卡片主题
  factory ZephyrStatisticTheme.custom({
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    Color? primaryColor,
    Color? successColor,
    Color? warningColor,
    Color? errorColor,
    Color? infoColor,
    TextStyle? titleStyle,
    TextStyle? valueStyle,
    TextStyle? descriptionStyle,
    TextStyle? trendStyle,
    double? iconSize,
    bool? showBorder,
  }) {
    final baseTheme = ZephyrStatisticTheme.light();
    
    return ZephyrStatisticTheme(
      backgroundColor: backgroundColor ?? baseTheme.backgroundColor,
      borderColor: borderColor ?? baseTheme.borderColor,
      borderWidth: borderWidth ?? baseTheme.borderWidth,
      borderRadius: borderRadius ?? baseTheme.borderRadius,
      padding: padding ?? baseTheme.padding,
      primaryColor: primaryColor ?? baseTheme.primaryColor,
      successColor: successColor ?? baseTheme.successColor,
      warningColor: warningColor ?? baseTheme.warningColor,
      errorColor: errorColor ?? baseTheme.errorColor,
      infoColor: infoColor ?? baseTheme.infoColor,
      titleStyle: titleStyle ?? baseTheme.titleStyle,
      valueStyle: valueStyle ?? baseTheme.valueStyle,
      descriptionStyle: descriptionStyle ?? baseTheme.descriptionStyle,
      trendStyle: trendStyle ?? baseTheme.trendStyle,
      iconSize: iconSize ?? baseTheme.iconSize,
      showBorder: showBorder ?? baseTheme.showBorder,
    );
  }
  
  /// 复制主题并修改部分属性
  ZephyrStatisticTheme copyWith({
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    Color? primaryColor,
    Color? successColor,
    Color? warningColor,
    Color? errorColor,
    Color? infoColor,
    TextStyle? titleStyle,
    TextStyle? valueStyle,
    TextStyle? descriptionStyle,
    TextStyle? trendStyle,
    double? iconSize,
    bool? showBorder,
  }) {
    return ZephyrStatisticTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      primaryColor: primaryColor ?? this.primaryColor,
      successColor: successColor ?? this.successColor,
      warningColor: warningColor ?? this.warningColor,
      errorColor: errorColor ?? this.errorColor,
      infoColor: infoColor ?? this.infoColor,
      titleStyle: titleStyle ?? this.titleStyle,
      valueStyle: valueStyle ?? this.valueStyle,
      descriptionStyle: descriptionStyle ?? this.descriptionStyle,
      trendStyle: trendStyle ?? this.trendStyle,
      iconSize: iconSize ?? this.iconSize,
      showBorder: showBorder ?? this.showBorder,
    );
  }
  
  /// 主题合并
  ZephyrStatisticTheme merge(ZephyrStatisticTheme? other) {
    if (other == null) return this;
    
    return copyWith(
      backgroundColor: other.backgroundColor,
      borderColor: other.borderColor,
      borderWidth: other.borderWidth,
      borderRadius: other.borderRadius,
      padding: other.padding,
      primaryColor: other.primaryColor,
      successColor: other.successColor,
      warningColor: other.warningColor,
      errorColor: other.errorColor,
      infoColor: other.infoColor,
      titleStyle: other.titleStyle,
      valueStyle: other.valueStyle,
      descriptionStyle: other.descriptionStyle,
      trendStyle: other.trendStyle,
      iconSize: other.iconSize,
      showBorder: other.showBorder,
    );
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is ZephyrStatisticTheme &&
      other.backgroundColor == backgroundColor &&
      other.borderColor == borderColor &&
      other.borderWidth == borderWidth &&
      other.borderRadius == borderRadius &&
      other.padding == padding &&
      other.primaryColor == primaryColor &&
      other.successColor == successColor &&
      other.warningColor == warningColor &&
      other.errorColor == errorColor &&
      other.infoColor == infoColor &&
      other.titleStyle == titleStyle &&
      other.valueStyle == valueStyle &&
      other.descriptionStyle == descriptionStyle &&
      other.trendStyle == trendStyle &&
      other.iconSize == iconSize &&
      other.showBorder == showBorder;
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
      successColor,
      warningColor,
      errorColor,
      infoColor,
      titleStyle,
      valueStyle,
      descriptionStyle,
      trendStyle,
      iconSize,
      showBorder,
    ]);
  }
}