import 'package:flutter/material.dart';

/// Zephyr表单主题配置
///
/// 定义表单容器的视觉外观和样式
class ZephyrFormTheme {
  const ZephyrFormTheme({
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.labelColor,
    required this.labelStyle,
    required this.requiredColor,
    required this.errorColor,
    required this.errorStyle,
    required this.helperColor,
    required this.helperStyle,
    required this.itemSpacing,
    required this.contentPadding,
  });

  /// 工厂构造函数 - 浅色主题
  factory ZephyrFormTheme.light() {
    return const ZephyrFormTheme(
      backgroundColor: Color(0xFFFFFFFF),
      borderColor: Color(0xFFE5E7EB),
      borderWidth: 1.0,
      labelColor: Color(0xFF374151),
      labelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF374151),
      ),
      requiredColor: Color(0xFFEF4444),
      errorColor: Color(0xFFEF4444),
      errorStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Color(0xFFEF4444),
      ),
      helperColor: Color(0xFF6B7280),
      helperStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Color(0xFF6B7280),
      ),
      itemSpacing: 16.0,
      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    );
  }

  /// 工厂构造函数 - 深色主题
  factory ZephyrFormTheme.dark() {
    return const ZephyrFormTheme(
      backgroundColor: Color(0xFF1F2937),
      borderColor: Color(0xFF374151),
      borderWidth: 1.0,
      labelColor: Color(0xFFF9FAFB),
      labelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFFF9FAFB),
      ),
      requiredColor: Color(0xFFEF4444),
      errorColor: Color(0xFFEF4444),
      errorStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Color(0xFFEF4444),
      ),
      helperColor: Color(0xFF9CA3AF),
      helperStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Color(0xFF9CA3AF),
      ),
      itemSpacing: 16.0,
      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    );
  }

  /// 工厂构造函数 - 自定义主题
  factory ZephyrFormTheme.custom({
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    Color? labelColor,
    TextStyle? labelStyle,
    Color? requiredColor,
    Color? errorColor,
    TextStyle? errorStyle,
    Color? helperColor,
    TextStyle? helperStyle,
    double? itemSpacing,
    EdgeInsetsGeometry? contentPadding,
  }) {
    final baseTheme = ZephyrFormTheme.light();
    return ZephyrFormTheme(
      backgroundColor: backgroundColor ?? baseTheme.backgroundColor,
      borderColor: borderColor ?? baseTheme.borderColor,
      borderWidth: borderWidth ?? baseTheme.borderWidth,
      labelColor: labelColor ?? baseTheme.labelColor,
      labelStyle: labelStyle ?? baseTheme.labelStyle,
      requiredColor: requiredColor ?? baseTheme.requiredColor,
      errorColor: errorColor ?? baseTheme.errorColor,
      errorStyle: errorStyle ?? baseTheme.errorStyle,
      helperColor: helperColor ?? baseTheme.helperColor,
      helperStyle: helperStyle ?? baseTheme.helperStyle,
      itemSpacing: itemSpacing ?? baseTheme.itemSpacing,
      contentPadding: contentPadding ?? baseTheme.contentPadding,
    );
  }

  /// 背景颜色
  final Color backgroundColor;

  /// 边框颜色
  final Color borderColor;

  /// 边框宽度
  final double borderWidth;

  /// 标签颜色
  final Color labelColor;

  /// 标签样式
  final TextStyle labelStyle;

  /// 必填标记颜色
  final Color requiredColor;

  /// 错误颜色
  final Color errorColor;

  /// 错误样式
  final TextStyle errorStyle;

  /// 帮助文本颜色
  final Color helperColor;

  /// 帮助文本样式
  final TextStyle helperStyle;

  /// 表单项间距
  final double itemSpacing;

  /// 内容内边距
  final EdgeInsetsGeometry contentPadding;

  /// 复制并修改属性
  ZephyrFormTheme copyWith({
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    Color? labelColor,
    TextStyle? labelStyle,
    Color? requiredColor,
    Color? errorColor,
    TextStyle? errorStyle,
    Color? helperColor,
    TextStyle? helperStyle,
    double? itemSpacing,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return ZephyrFormTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      labelColor: labelColor ?? this.labelColor,
      labelStyle: labelStyle ?? this.labelStyle,
      requiredColor: requiredColor ?? this.requiredColor,
      errorColor: errorColor ?? this.errorColor,
      errorStyle: errorStyle ?? this.errorStyle,
      helperColor: helperColor ?? this.helperColor,
      helperStyle: helperStyle ?? this.helperStyle,
      itemSpacing: itemSpacing ?? this.itemSpacing,
      contentPadding: contentPadding ?? this.contentPadding,
    );
  }

  /// 合并另一个主题
  ZephyrFormTheme merge(ZephyrFormTheme other) {
    return copyWith(
      backgroundColor: other.backgroundColor,
      borderColor: other.borderColor,
      borderWidth: other.borderWidth,
      labelColor: other.labelColor,
      labelStyle: other.labelStyle,
      requiredColor: other.requiredColor,
      errorColor: other.errorColor,
      errorStyle: other.errorStyle,
      helperColor: other.helperColor,
      helperStyle: other.helperStyle,
      itemSpacing: other.itemSpacing,
      contentPadding: other.contentPadding,
    );
  }

  /// 解析主题
  static ZephyrFormTheme resolve(BuildContext context, ZephyrFormTheme? theme) {
    if (theme != null) return theme;

    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? ZephyrFormTheme.dark()
        : ZephyrFormTheme.light();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ZephyrFormTheme &&
        other.backgroundColor == backgroundColor &&
        other.borderColor == borderColor &&
        other.borderWidth == borderWidth &&
        other.labelColor == labelColor &&
        other.labelStyle == labelStyle &&
        other.requiredColor == requiredColor &&
        other.errorColor == errorColor &&
        other.errorStyle == errorStyle &&
        other.helperColor == helperColor &&
        other.helperStyle == helperStyle &&
        other.itemSpacing == itemSpacing &&
        other.contentPadding == contentPadding;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      backgroundColor,
      borderColor,
      borderWidth,
      labelColor,
      labelStyle,
      requiredColor,
      errorColor,
      errorStyle,
      helperColor,
      helperStyle,
      itemSpacing,
      contentPadding,
    ]);
  }
}
