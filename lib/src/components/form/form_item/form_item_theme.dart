import 'package:flutter/material.dart';

/// Zephyr表单项主题配置
///
/// 定义表单项的视觉外观和样式
class ZephyrFormItemTheme {
  const ZephyrFormItemTheme({
    required this.labelColor,
    required this.labelStyle,
    required this.requiredColor,
    required this.errorColor,
    required this.errorStyle,
    required this.errorSpacing,
    required this.helperColor,
    required this.helperStyle,
    required this.helperSpacing,
    required this.spacing,
  });

  /// 工厂构造函数 - 浅色主题
  factory ZephyrFormItemTheme.light() {
    return const ZephyrFormItemTheme(
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
      errorSpacing: 4.0,
      helperColor: Color(0xFF6B7280),
      helperStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Color(0xFF6B7280),
      ),
      helperSpacing: 4.0,
      spacing: 8.0,
    );
  }

  /// 工厂构造函数 - 深色主题
  factory ZephyrFormItemTheme.dark() {
    return const ZephyrFormItemTheme(
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
      errorSpacing: 4.0,
      helperColor: Color(0xFF9CA3AF),
      helperStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Color(0xFF9CA3AF),
      ),
      helperSpacing: 4.0,
      spacing: 8.0,
    );
  }

  /// 工厂构造函数 - 自定义主题
  factory ZephyrFormItemTheme.custom({
    Color? labelColor,
    TextStyle? labelStyle,
    Color? requiredColor,
    Color? errorColor,
    TextStyle? errorStyle,
    double? errorSpacing,
    Color? helperColor,
    TextStyle? helperStyle,
    double? helperSpacing,
    double? spacing,
  }) {
    final baseTheme = ZephyrFormItemTheme.light();
    return ZephyrFormItemTheme(
      labelColor: labelColor ?? baseTheme.labelColor,
      labelStyle: labelStyle ?? baseTheme.labelStyle,
      requiredColor: requiredColor ?? baseTheme.requiredColor,
      errorColor: errorColor ?? baseTheme.errorColor,
      errorStyle: errorStyle ?? baseTheme.errorStyle,
      errorSpacing: errorSpacing ?? baseTheme.errorSpacing,
      helperColor: helperColor ?? baseTheme.helperColor,
      helperStyle: helperStyle ?? baseTheme.helperStyle,
      helperSpacing: helperSpacing ?? baseTheme.helperSpacing,
      spacing: spacing ?? baseTheme.spacing,
    );
  }

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

  /// 错误信息间距
  final double errorSpacing;

  /// 帮助文本颜色
  final Color helperColor;

  /// 帮助文本样式
  final TextStyle helperStyle;

  /// 帮助文本间距
  final double helperSpacing;

  /// 间距
  final double spacing;

  /// 复制并修改属性
  ZephyrFormItemTheme copyWith({
    Color? labelColor,
    TextStyle? labelStyle,
    Color? requiredColor,
    Color? errorColor,
    TextStyle? errorStyle,
    double? errorSpacing,
    Color? helperColor,
    TextStyle? helperStyle,
    double? helperSpacing,
    double? spacing,
  }) {
    return ZephyrFormItemTheme(
      labelColor: labelColor ?? this.labelColor,
      labelStyle: labelStyle ?? this.labelStyle,
      requiredColor: requiredColor ?? this.requiredColor,
      errorColor: errorColor ?? this.errorColor,
      errorStyle: errorStyle ?? this.errorStyle,
      errorSpacing: errorSpacing ?? this.errorSpacing,
      helperColor: helperColor ?? this.helperColor,
      helperStyle: helperStyle ?? this.helperStyle,
      helperSpacing: helperSpacing ?? this.helperSpacing,
      spacing: spacing ?? this.spacing,
    );
  }

  /// 合并另一个主题
  ZephyrFormItemTheme merge(ZephyrFormItemTheme other) {
    return copyWith(
      labelColor: other.labelColor,
      labelStyle: other.labelStyle,
      requiredColor: other.requiredColor,
      errorColor: other.errorColor,
      errorStyle: other.errorStyle,
      errorSpacing: other.errorSpacing,
      helperColor: other.helperColor,
      helperStyle: other.helperStyle,
      helperSpacing: other.helperSpacing,
      spacing: other.spacing,
    );
  }

  /// 解析主题
  static ZephyrFormItemTheme resolve(
      BuildContext context, ZephyrFormItemTheme? theme) {
    if (theme != null) return theme;

    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? ZephyrFormItemTheme.dark()
        : ZephyrFormItemTheme.light();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ZephyrFormItemTheme &&
        other.labelColor == labelColor &&
        other.labelStyle == labelStyle &&
        other.requiredColor == requiredColor &&
        other.errorColor == errorColor &&
        other.errorStyle == errorStyle &&
        other.errorSpacing == errorSpacing &&
        other.helperColor == helperColor &&
        other.helperStyle == helperStyle &&
        other.helperSpacing == helperSpacing &&
        other.spacing == spacing;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      labelColor,
      labelStyle,
      requiredColor,
      errorColor,
      errorStyle,
      errorSpacing,
      helperColor,
      helperStyle,
      helperSpacing,
      spacing,
    ]);
  }
}
