import 'package:flutter/material.dart';

/// Zephyr数字输入框主题配置
///
/// 定义数字输入框的视觉外观和样式
class ZephyrInputNumberTheme {
  const ZephyrInputNumberTheme({
    required this.fillColor,
    required this.focusedFillColor,
    required this.disabledFillColor,
    required this.errorFillColor,
    required this.borderColor,
    required this.focusedBorderColor,
    required this.disabledBorderColor,
    required this.borderWidth,
    required this.focusedBorderWidth,
    required this.disabledBorderWidth,
    required this.errorBorderWidth,
    required this.borderRadius,
    required this.textColor,
    required this.disabledTextColor,
    required this.placeholderStyle,
    required this.errorColor,
    required this.errorStyle,
    required this.errorSpacing,
    required this.helperStyle,
    required this.helperSpacing,
    required this.contentPadding,
    required this.prefixPadding,
    required this.suffixPadding,
    required this.controlSize,
    required this.controlBorderRadius,
    required this.controlBackgroundColor,
    required this.disabledControlBackgroundColor,
    required this.controlIconSize,
    required this.controlIconColor,
    required this.disabledControlIconColor,
    required this.controlSpacing,
  });

  /// 工厂构造函数 - 浅色主题
  factory ZephyrInputNumberTheme.light() {
    return const ZephyrInputNumberTheme(
      fillColor: Color(0xFFFFFFFF),
      focusedFillColor: Color(0xFFFFFFFF),
      disabledFillColor: Color(0xFFF5F5F5),
      errorFillColor: Color(0xFFFFF0F0),
      borderColor: Color(0xFFD1D5DB),
      focusedBorderColor: Color(0xFF3B82F6),
      disabledBorderColor: Color(0xFFE5E7EB),
      borderWidth: 1.0,
      focusedBorderWidth: 1.0,
      disabledBorderWidth: 1.0,
      errorBorderWidth: 1.0,
      borderRadius: 6.0,
      textColor: Color(0xFF1F2937),
      disabledTextColor: Color(0xFF9CA3AF),
      placeholderStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Color(0xFF9CA3AF),
      ),
      errorColor: Color(0xFFEF4444),
      errorStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Color(0xFFEF4444),
      ),
      errorSpacing: 4.0,
      helperStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Color(0xFF6B7280),
      ),
      helperSpacing: 4.0,
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      prefixPadding: EdgeInsets.only(left: 12, right: 8),
      suffixPadding: EdgeInsets.only(left: 8, right: 12),
      controlSize: 24.0,
      controlBorderRadius: 4.0,
      controlBackgroundColor: Color(0xFFF3F4F6),
      disabledControlBackgroundColor: Color(0xFFE5E7EB),
      controlIconSize: 16.0,
      controlIconColor: Color(0xFF6B7280),
      disabledControlIconColor: Color(0xFF9CA3AF),
      controlSpacing: 2.0,
    );
  }

  /// 工厂构造函数 - 深色主题
  factory ZephyrInputNumberTheme.dark() {
    return const ZephyrInputNumberTheme(
      fillColor: Color(0xFF374151),
      focusedFillColor: Color(0xFF374151),
      disabledFillColor: Color(0xFF1F2937),
      errorFillColor: Color(0xFF3F1212),
      borderColor: Color(0xFF4B5563),
      focusedBorderColor: Color(0xFF60A5FA),
      disabledBorderColor: Color(0xFF374151),
      borderWidth: 1.0,
      focusedBorderWidth: 1.0,
      disabledBorderWidth: 1.0,
      errorBorderWidth: 1.0,
      borderRadius: 6.0,
      textColor: Color(0xFFF9FAFB),
      disabledTextColor: Color(0xFF6B7280),
      placeholderStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Color(0xFF6B7280),
      ),
      errorColor: Color(0xFFEF4444),
      errorStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Color(0xFFEF4444),
      ),
      errorSpacing: 4.0,
      helperStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Color(0xFF9CA3AF),
      ),
      helperSpacing: 4.0,
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      prefixPadding: EdgeInsets.only(left: 12, right: 8),
      suffixPadding: EdgeInsets.only(left: 8, right: 12),
      controlSize: 24.0,
      controlBorderRadius: 4.0,
      controlBackgroundColor: Color(0xFF1F2937),
      disabledControlBackgroundColor: Color(0xFF111827),
      controlIconSize: 16.0,
      controlIconColor: Color(0xFF9CA3AF),
      disabledControlIconColor: Color(0xFF4B5563),
      controlSpacing: 2.0,
    );
  }

  /// 工厂构造函数 - 自定义主题
  factory ZephyrInputNumberTheme.custom({
    Color? fillColor,
    Color? focusedFillColor,
    Color? disabledFillColor,
    Color? errorFillColor,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? disabledBorderColor,
    double? borderWidth,
    double? focusedBorderWidth,
    double? disabledBorderWidth,
    double? errorBorderWidth,
    double? borderRadius,
    Color? textColor,
    Color? disabledTextColor,
    TextStyle? placeholderStyle,
    Color? errorColor,
    TextStyle? errorStyle,
    double? errorSpacing,
    TextStyle? helperStyle,
    double? helperSpacing,
    EdgeInsetsGeometry? contentPadding,
    EdgeInsetsGeometry? prefixPadding,
    EdgeInsetsGeometry? suffixPadding,
    double? controlSize,
    double? controlBorderRadius,
    Color? controlBackgroundColor,
    Color? disabledControlBackgroundColor,
    double? controlIconSize,
    Color? controlIconColor,
    Color? disabledControlIconColor,
    double? controlSpacing,
  }) {
    final baseTheme = ZephyrInputNumberTheme.light();
    return ZephyrInputNumberTheme(
      fillColor: fillColor ?? baseTheme.fillColor,
      focusedFillColor: focusedFillColor ?? baseTheme.focusedFillColor,
      disabledFillColor: disabledFillColor ?? baseTheme.disabledFillColor,
      errorFillColor: errorFillColor ?? baseTheme.errorFillColor,
      borderColor: borderColor ?? baseTheme.borderColor,
      focusedBorderColor: focusedBorderColor ?? baseTheme.focusedBorderColor,
      disabledBorderColor: disabledBorderColor ?? baseTheme.disabledBorderColor,
      borderWidth: borderWidth ?? baseTheme.borderWidth,
      focusedBorderWidth: focusedBorderWidth ?? baseTheme.focusedBorderWidth,
      disabledBorderWidth: disabledBorderWidth ?? baseTheme.disabledBorderWidth,
      errorBorderWidth: errorBorderWidth ?? baseTheme.errorBorderWidth,
      borderRadius: borderRadius ?? baseTheme.borderRadius,
      textColor: textColor ?? baseTheme.textColor,
      disabledTextColor: disabledTextColor ?? baseTheme.disabledTextColor,
      placeholderStyle: placeholderStyle ?? baseTheme.placeholderStyle,
      errorColor: errorColor ?? baseTheme.errorColor,
      errorStyle: errorStyle ?? baseTheme.errorStyle,
      errorSpacing: errorSpacing ?? baseTheme.errorSpacing,
      helperStyle: helperStyle ?? baseTheme.helperStyle,
      helperSpacing: helperSpacing ?? baseTheme.helperSpacing,
      contentPadding: contentPadding ?? baseTheme.contentPadding,
      prefixPadding: prefixPadding ?? baseTheme.prefixPadding,
      suffixPadding: suffixPadding ?? baseTheme.suffixPadding,
      controlSize: controlSize ?? baseTheme.controlSize,
      controlBorderRadius: controlBorderRadius ?? baseTheme.controlBorderRadius,
      controlBackgroundColor:
          controlBackgroundColor ?? baseTheme.controlBackgroundColor,
      disabledControlBackgroundColor: disabledControlBackgroundColor ??
          baseTheme.disabledControlBackgroundColor,
      controlIconSize: controlIconSize ?? baseTheme.controlIconSize,
      controlIconColor: controlIconColor ?? baseTheme.controlIconColor,
      disabledControlIconColor:
          disabledControlIconColor ?? baseTheme.disabledControlIconColor,
      controlSpacing: controlSpacing ?? baseTheme.controlSpacing,
    );
  }

  /// 填充颜色
  final Color fillColor;

  /// 聚焦时填充颜色
  final Color focusedFillColor;

  /// 禁用时填充颜色
  final Color disabledFillColor;

  /// 错误时填充颜色
  final Color errorFillColor;

  /// 边框颜色
  final Color borderColor;

  /// 聚焦时边框颜色
  final Color focusedBorderColor;

  /// 禁用时边框颜色
  final Color disabledBorderColor;

  /// 边框宽度
  final double borderWidth;

  /// 聚焦时边框宽度
  final double focusedBorderWidth;

  /// 禁用时边框宽度
  final double disabledBorderWidth;

  /// 错误时边框宽度
  final double errorBorderWidth;

  /// 边框圆角
  final double borderRadius;

  /// 文本颜色
  final Color textColor;

  /// 禁用时文本颜色
  final Color disabledTextColor;

  /// 占位符样式
  final TextStyle placeholderStyle;

  /// 错误颜色
  final Color errorColor;

  /// 错误样式
  final TextStyle errorStyle;

  /// 错误信息间距
  final double errorSpacing;

  /// 帮助文本样式
  final TextStyle helperStyle;

  /// 帮助文本间距
  final double helperSpacing;

  /// 内容内边距
  final EdgeInsetsGeometry contentPadding;

  /// 前缀内边距
  final EdgeInsetsGeometry prefixPadding;

  /// 后缀内边距
  final EdgeInsetsGeometry suffixPadding;

  /// 控制按钮大小
  final double controlSize;

  /// 控制按钮圆角
  final double controlBorderRadius;

  /// 控制按钮背景颜色
  final Color controlBackgroundColor;

  /// 禁用时控制按钮背景颜色
  final Color disabledControlBackgroundColor;

  /// 控制按钮图标大小
  final double controlIconSize;

  /// 控制按钮图标颜色
  final Color controlIconColor;

  /// 禁用时控制按钮图标颜色
  final Color disabledControlIconColor;

  /// 控制按钮间距
  final double controlSpacing;

  /// 复制并修改属性
  ZephyrInputNumberTheme copyWith({
    Color? fillColor,
    Color? focusedFillColor,
    Color? disabledFillColor,
    Color? errorFillColor,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? disabledBorderColor,
    double? borderWidth,
    double? focusedBorderWidth,
    double? disabledBorderWidth,
    double? errorBorderWidth,
    double? borderRadius,
    Color? textColor,
    Color? disabledTextColor,
    TextStyle? placeholderStyle,
    Color? errorColor,
    TextStyle? errorStyle,
    double? errorSpacing,
    TextStyle? helperStyle,
    double? helperSpacing,
    EdgeInsetsGeometry? contentPadding,
    EdgeInsetsGeometry? prefixPadding,
    EdgeInsetsGeometry? suffixPadding,
    double? controlSize,
    double? controlBorderRadius,
    Color? controlBackgroundColor,
    Color? disabledControlBackgroundColor,
    double? controlIconSize,
    Color? controlIconColor,
    Color? disabledControlIconColor,
    double? controlSpacing,
  }) {
    return ZephyrInputNumberTheme(
      fillColor: fillColor ?? this.fillColor,
      focusedFillColor: focusedFillColor ?? this.focusedFillColor,
      disabledFillColor: disabledFillColor ?? this.disabledFillColor,
      errorFillColor: errorFillColor ?? this.errorFillColor,
      borderColor: borderColor ?? this.borderColor,
      focusedBorderColor: focusedBorderColor ?? this.focusedBorderColor,
      disabledBorderColor: disabledBorderColor ?? this.disabledBorderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      focusedBorderWidth: focusedBorderWidth ?? this.focusedBorderWidth,
      disabledBorderWidth: disabledBorderWidth ?? this.disabledBorderWidth,
      errorBorderWidth: errorBorderWidth ?? this.errorBorderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      textColor: textColor ?? this.textColor,
      disabledTextColor: disabledTextColor ?? this.disabledTextColor,
      placeholderStyle: placeholderStyle ?? this.placeholderStyle,
      errorColor: errorColor ?? this.errorColor,
      errorStyle: errorStyle ?? this.errorStyle,
      errorSpacing: errorSpacing ?? this.errorSpacing,
      helperStyle: helperStyle ?? this.helperStyle,
      helperSpacing: helperSpacing ?? this.helperSpacing,
      contentPadding: contentPadding ?? this.contentPadding,
      prefixPadding: prefixPadding ?? this.prefixPadding,
      suffixPadding: suffixPadding ?? this.suffixPadding,
      controlSize: controlSize ?? this.controlSize,
      controlBorderRadius: controlBorderRadius ?? this.controlBorderRadius,
      controlBackgroundColor:
          controlBackgroundColor ?? this.controlBackgroundColor,
      disabledControlBackgroundColor:
          disabledControlBackgroundColor ?? this.disabledControlBackgroundColor,
      controlIconSize: controlIconSize ?? this.controlIconSize,
      controlIconColor: controlIconColor ?? this.controlIconColor,
      disabledControlIconColor:
          disabledControlIconColor ?? this.disabledControlIconColor,
      controlSpacing: controlSpacing ?? this.controlSpacing,
    );
  }

  /// 合并另一个主题
  ZephyrInputNumberTheme merge(ZephyrInputNumberTheme other) {
    return copyWith(
      fillColor: other.fillColor,
      focusedFillColor: other.focusedFillColor,
      disabledFillColor: other.disabledFillColor,
      errorFillColor: other.errorFillColor,
      borderColor: other.borderColor,
      focusedBorderColor: other.focusedBorderColor,
      disabledBorderColor: other.disabledBorderColor,
      borderWidth: other.borderWidth,
      focusedBorderWidth: other.focusedBorderWidth,
      disabledBorderWidth: other.disabledBorderWidth,
      errorBorderWidth: other.errorBorderWidth,
      borderRadius: other.borderRadius,
      textColor: other.textColor,
      disabledTextColor: other.disabledTextColor,
      placeholderStyle: other.placeholderStyle,
      errorColor: other.errorColor,
      errorStyle: other.errorStyle,
      errorSpacing: other.errorSpacing,
      helperStyle: other.helperStyle,
      helperSpacing: other.helperSpacing,
      contentPadding: other.contentPadding,
      prefixPadding: other.prefixPadding,
      suffixPadding: other.suffixPadding,
      controlSize: other.controlSize,
      controlBorderRadius: other.controlBorderRadius,
      controlBackgroundColor: other.controlBackgroundColor,
      disabledControlBackgroundColor: other.disabledControlBackgroundColor,
      controlIconSize: other.controlIconSize,
      controlIconColor: other.controlIconColor,
      disabledControlIconColor: other.disabledControlIconColor,
      controlSpacing: other.controlSpacing,
    );
  }

  /// 解析主题
  static ZephyrInputNumberTheme resolve(
      BuildContext context, ZephyrInputNumberTheme? theme) {
    if (theme != null) return theme;

    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? ZephyrInputNumberTheme.dark()
        : ZephyrInputNumberTheme.light();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ZephyrInputNumberTheme &&
        other.fillColor == fillColor &&
        other.focusedFillColor == focusedFillColor &&
        other.disabledFillColor == disabledFillColor &&
        other.errorFillColor == errorFillColor &&
        other.borderColor == borderColor &&
        other.focusedBorderColor == focusedBorderColor &&
        other.disabledBorderColor == disabledBorderColor &&
        other.borderWidth == borderWidth &&
        other.focusedBorderWidth == focusedBorderWidth &&
        other.disabledBorderWidth == disabledBorderWidth &&
        other.errorBorderWidth == errorBorderWidth &&
        other.borderRadius == borderRadius &&
        other.textColor == textColor &&
        other.disabledTextColor == disabledTextColor &&
        other.placeholderStyle == placeholderStyle &&
        other.errorColor == errorColor &&
        other.errorStyle == errorStyle &&
        other.errorSpacing == errorSpacing &&
        other.helperStyle == helperStyle &&
        other.helperSpacing == helperSpacing &&
        other.contentPadding == contentPadding &&
        other.prefixPadding == prefixPadding &&
        other.suffixPadding == suffixPadding &&
        other.controlSize == controlSize &&
        other.controlBorderRadius == controlBorderRadius &&
        other.controlBackgroundColor == controlBackgroundColor &&
        other.disabledControlBackgroundColor ==
            disabledControlBackgroundColor &&
        other.controlIconSize == controlIconSize &&
        other.controlIconColor == controlIconColor &&
        other.disabledControlIconColor == disabledControlIconColor &&
        other.controlSpacing == controlSpacing;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      fillColor,
      focusedFillColor,
      disabledFillColor,
      errorFillColor,
      borderColor,
      focusedBorderColor,
      disabledBorderColor,
      borderWidth,
      focusedBorderWidth,
      disabledBorderWidth,
      errorBorderWidth,
      borderRadius,
      textColor,
      disabledTextColor,
      placeholderStyle,
      errorColor,
      errorStyle,
      errorSpacing,
      helperStyle,
      helperSpacing,
      contentPadding,
      prefixPadding,
      suffixPadding,
      controlSize,
      controlBorderRadius,
      controlBackgroundColor,
      disabledControlBackgroundColor,
      controlIconSize,
      controlIconColor,
      disabledControlIconColor,
      controlSpacing,
    ]);
  }
}
