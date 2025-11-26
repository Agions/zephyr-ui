/// ZephyrUI 全局提示主题
///
/// 定义全局提示组件的主题样式。
library message_theme;

import 'package:flutter/material.dart';

/// ZephyrUI 全局提示主题
class ZephyrMessageTheme extends ThemeExtension<ZephyrMessageTheme> {
  /// 创建全局提示主题
  const ZephyrMessageTheme({
    required this.backgroundColor,
    required this.borderColor,
    required this.borderRadius,
    required this.border,
    required this.padding,
    required this.contentStyle,
    required this.successIconColor,
    required this.errorIconColor,
    required this.warningIconColor,
    required this.infoIconColor,
    required this.closeIconColor,
    required this.boxShadow,
  });

  /// 从主题创建全局提示主题
  factory ZephyrMessageTheme.fromTheme(ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return ZephyrMessageTheme(
      backgroundColor: colorScheme.surface,
      borderColor: colorScheme.outline.withValues(alpha:0.2),
      borderRadius: const BorderRadius.circular(8),
      border: Border.all(
        color: colorScheme.outline.withValues(alpha:0.2),
        width: 1,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      contentStyle: TextStyle(
        color: colorScheme.onSurface,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      successIconColor: colorScheme.primary,
      errorIconColor: colorScheme.error,
      warningIconColor: colorScheme.secondary,
      infoIconColor: colorScheme.primary,
      closeIconColor: colorScheme.onSurface.withValues(alpha:0.6),
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
  factory ZephyrMessageTheme.light() {
    return ZephyrMessageTheme.fromTheme(ThemeData.light());
  }

  /// 创建暗色主题
  factory ZephyrMessageTheme.dark() {
    return ZephyrMessageTheme.fromTheme(ThemeData.dark());
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

  /// 内容样式
  final TextStyle contentStyle;

  /// 成功图标颜色
  final Color successIconColor;

  /// 错误图标颜色
  final Color errorIconColor;

  /// 警告图标颜色
  final Color warningIconColor;

  /// 信息图标颜色
  final Color infoIconColor;

  /// 关闭图标颜色
  final Color closeIconColor;

  /// 阴影
  final List<BoxShadow> boxShadow;

  @override
  ZephyrMessageTheme copyWith({
    Color? backgroundColor,
    Color? borderColor,
    BorderRadius? borderRadius,
    Border? border,
    EdgeInsetsGeometry? padding,
    TextStyle? contentStyle,
    Color? successIconColor,
    Color? errorIconColor,
    Color? warningIconColor,
    Color? infoIconColor,
    Color? closeIconColor,
    List<BoxShadow>? boxShadow,
  }) {
    return ZephyrMessageTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderRadius: borderRadius ?? this.borderRadius,
      border: border ?? this.border,
      padding: padding ?? this.padding,
      contentStyle: contentStyle ?? this.contentStyle,
      successIconColor: successIconColor ?? this.successIconColor,
      errorIconColor: errorIconColor ?? this.errorIconColor,
      warningIconColor: warningIconColor ?? this.warningIconColor,
      infoIconColor: infoIconColor ?? this.infoIconColor,
      closeIconColor: closeIconColor ?? this.closeIconColor,
      boxShadow: boxShadow ?? this.boxShadow,
    );
  }

  @override
  ZephyrMessageTheme lerp(ThemeExtension<ZephyrMessageTheme>? other, double t) {
    if (other is! ZephyrMessageTheme) {
      return this;
    }
    return ZephyrMessageTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      borderRadius: const BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
      border: Border.lerp(border, other.border, t)!,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t)!,
      contentStyle: TextStyle.lerp(contentStyle, other.contentStyle, t)!,
      successIconColor:
          Color.lerp(successIconColor, other.successIconColor, t)!,
      errorIconColor: Color.lerp(errorIconColor, other.errorIconColor, t)!,
      warningIconColor:
          Color.lerp(warningIconColor, other.warningIconColor, t)!,
      infoIconColor: Color.lerp(infoIconColor, other.infoIconColor, t)!,
      closeIconColor: Color.lerp(closeIconColor, other.closeIconColor, t)!,
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
