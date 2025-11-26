import 'package:flutter/material.dart';

/// 定义徽章组件的视觉样式
///
/// 该类包含所有控制徽章外观的属性，包括颜色、圆角、内边距和边框样式
class ZephyrBadgeTheme extends ThemeExtension<ZephyrBadgeTheme> {
  /// 创建徽章主题
  const ZephyrBadgeTheme({
    required this.backgroundColor,
    required this.textColor,
    required this.borderRadius,
    required this.padding,
    this.borderWidth = 0.0,
    this.borderColor = Colors.transparent,
  });

  /// 徽章背景色
  final Color backgroundColor;

  /// 徽章文本颜色
  final Color textColor;

  /// 徽章边框圆角
  final BorderRadius borderRadius;

  /// 徽章内边距
  final EdgeInsetsGeometry padding;

  /// 徽章边框宽度
  final double borderWidth;

  /// 徽章边框颜色
  final Color borderColor;

  /// 创建默认的徽章主题
  static ZephyrBadgeTheme fallback(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ZephyrBadgeTheme(
      backgroundColor: colorScheme.error,
      textColor: colorScheme.onError,
      borderRadius: const BorderRadius.circular(10.0),
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
      borderWidth: 0.0,
      borderColor: Colors.transparent,
    );
  }

  @override
  ZephyrBadgeTheme copyWith({
    Color? backgroundColor,
    Color? textColor,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
    double? borderWidth,
    Color? borderColor,
  }) {
    return ZephyrBadgeTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      borderWidth: borderWidth ?? this.borderWidth,
      borderColor: borderColor ?? this.borderColor,
    );
  }

  @override
  ZephyrBadgeTheme lerp(ThemeExtension<ZephyrBadgeTheme>? other, double t) {
    if (other is! ZephyrBadgeTheme) {
      return this;
    }

    return ZephyrBadgeTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      borderRadius: const BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t)!,
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
    );
  }

  /// 辅助方法：对 double 类型值进行线性插值
  static double? lerpDouble(double? a, double? b, double t) {
    if (a == null && b == null) return null;
    if (a == null) return b! * t;
    if (b == null) return a * (1.0 - t);
    return a + (b - a) * t;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is ZephyrBadgeTheme &&
        other.backgroundColor == backgroundColor &&
        other.textColor == textColor &&
        other.borderRadius == borderRadius &&
        other.padding == padding &&
        other.borderWidth == borderWidth &&
        other.borderColor == borderColor;
  }

  @override
  int get hashCode => Object.hash(
        backgroundColor,
        textColor,
        borderRadius,
        padding,
        borderWidth,
        borderColor,
      );
}
