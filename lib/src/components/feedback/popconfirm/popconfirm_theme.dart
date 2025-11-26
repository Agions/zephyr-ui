/// ZephyrUI 气泡确认框主题
///
/// 定义气泡确认框组件的主题样式。
library popconfirm_theme;

import 'package:flutter/material.dart';

/// ZephyrUI 气泡确认框主题
class ZephyrPopconfirmTheme extends ThemeExtension<ZephyrPopconfirmTheme> {
  /// 创建气泡确认框主题
  const ZephyrPopconfirmTheme({
    required this.backgroundColor,
    required this.borderColor,
    required this.borderRadius,
    required this.border,
    required this.padding,
    required this.margin,
    required this.titleStyle,
    required this.messageStyle,
    required this.iconColor,
    required this.primaryColor,
    required this.successColor,
    required this.warningColor,
    required this.errorColor,
    required this.infoColor,
    required this.boxShadow,
  });

  /// 从主题创建气泡确认框主题
  factory ZephyrPopconfirmTheme.fromTheme(ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return ZephyrPopconfirmTheme(
      backgroundColor: colorScheme.surface,
      borderColor: colorScheme.outline.withValues(alpha:0.2),
      borderRadius: const BorderRadius.circular(8),
      border: Border.all(
        color: colorScheme.outline.withValues(alpha:0.2),
        width: 1,
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(8),
      titleStyle: TextStyle(
        color: colorScheme.onSurface,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      messageStyle: TextStyle(
        color: colorScheme.onSurface.withValues(alpha:0.7),
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      iconColor: colorScheme.primary,
      primaryColor: colorScheme.primary,
      successColor: colorScheme.primary,
      warningColor: colorScheme.secondary,
      errorColor: colorScheme.error,
      infoColor: colorScheme.primary,
      boxShadow: [
        const BoxShadow(
          color: Colors.black.withValues(alpha:0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  /// 创建亮色主题
  factory ZephyrPopconfirmTheme.light() {
    return ZephyrPopconfirmTheme.fromTheme(ThemeData.light());
  }

  /// 创建暗色主题
  factory ZephyrPopconfirmTheme.dark() {
    return ZephyrPopconfirmTheme.fromTheme(ThemeData.dark());
  }

  /// 背景色
  final Color backgroundColor;

  /// 边框颜色
  final Color borderColor;

  /// 圆角
  final BorderRadius borderRadius;

  /// 边框
  final Border border;

  /// 内边距
  final EdgeInsetsGeometry padding;

  /// 外边距
  final EdgeInsetsGeometry margin;

  /// 标题样式
  final TextStyle titleStyle;

  /// 消息样式
  final TextStyle messageStyle;

  /// 图标颜色
  final Color iconColor;

  /// 主要颜色
  final Color primaryColor;

  /// 成功颜色
  final Color successColor;

  /// 警告颜色
  final Color warningColor;

  /// 错误颜色
  final Color errorColor;

  /// 信息颜色
  final Color infoColor;

  /// 阴影
  final List<BoxShadow> boxShadow;

  @override
  ZephyrPopconfirmTheme copyWith({
    Color? backgroundColor,
    Color? borderColor,
    BorderRadius? borderRadius,
    Border? border,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    Color? iconColor,
    Color? primaryColor,
    Color? successColor,
    Color? warningColor,
    Color? errorColor,
    Color? infoColor,
    List<BoxShadow>? boxShadow,
  }) {
    return ZephyrPopconfirmTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderRadius: borderRadius ?? this.borderRadius,
      border: border ?? this.border,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      titleStyle: titleStyle ?? this.titleStyle,
      messageStyle: messageStyle ?? this.messageStyle,
      iconColor: iconColor ?? this.iconColor,
      primaryColor: primaryColor ?? this.primaryColor,
      successColor: successColor ?? this.successColor,
      warningColor: warningColor ?? this.warningColor,
      errorColor: errorColor ?? this.errorColor,
      infoColor: infoColor ?? this.infoColor,
      boxShadow: boxShadow ?? this.boxShadow,
    );
  }

  @override
  ZephyrPopconfirmTheme lerp(
      ThemeExtension<ZephyrPopconfirmTheme>? other, double t) {
    if (other is! ZephyrPopconfirmTheme) {
      return this;
    }
    return ZephyrPopconfirmTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      borderRadius: const BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
      border: Border.lerp(border, other.border, t)!,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t)!,
      margin: EdgeInsetsGeometry.lerp(margin, other.margin, t)!,
      titleStyle: TextStyle.lerp(titleStyle, other.titleStyle, t)!,
      messageStyle: TextStyle.lerp(messageStyle, other.messageStyle, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      successColor: Color.lerp(successColor, other.successColor, t)!,
      warningColor: Color.lerp(warningColor, other.warningColor, t)!,
      errorColor: Color.lerp(errorColor, other.errorColor, t)!,
      infoColor: Color.lerp(infoColor, other.infoColor, t)!,
      boxShadow: List<BoxShadow>.generate(
        boxShadow.length,
        (index) => BoxShadow.lerp(
          boxShadow[index],
          other.boxShadow[index],
          t,
        )!,
      ),
    );
  }
}
