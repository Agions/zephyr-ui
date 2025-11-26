/// ZephyrUI 加载中主题
///
/// 定义加载中组件的主题样式。
library spin_theme;

import 'package:flutter/material.dart';

/// ZephyrUI 加载中主题
class ZephyrSpinTheme extends ThemeExtension<ZephyrSpinTheme> {
  /// 创建加载中主题
  const ZephyrSpinTheme({
    required this.color,
    required this.tipStyle,
    required this.backgroundColor,
    required this.borderRadius,
  });

  /// 从主题创建加载中主题
  factory ZephyrSpinTheme.fromTheme(ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return ZephyrSpinTheme(
      color: colorScheme.primary,
      tipStyle: TextStyle(
        color: colorScheme.onSurface,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      backgroundColor: Colors.white.withValues(alpha:0.7),
      borderRadius: const BorderRadius.circular(8),
    );
  }

  /// 创建亮色主题
  factory ZephyrSpinTheme.light() {
    return ZephyrSpinTheme.fromTheme(ThemeData.light());
  }

  /// 创建暗色主题
  factory ZephyrSpinTheme.dark() {
    return ZephyrSpinTheme.fromTheme(ThemeData.dark());
  }

  /// 加载指示器颜色
  final Color color;

  /// 提示文本样式
  final TextStyle tipStyle;

  /// 背景色
  final Color backgroundColor;

  /// 圆角
  final BorderRadius borderRadius;

  @override
  ZephyrSpinTheme copyWith({
    Color? color,
    TextStyle? tipStyle,
    Color? backgroundColor,
    BorderRadius? borderRadius,
  }) {
    return ZephyrSpinTheme(
      color: color ?? this.color,
      tipStyle: tipStyle ?? this.tipStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  ZephyrSpinTheme lerp(ThemeExtension<ZephyrSpinTheme>? other, double t) {
    if (other is! ZephyrSpinTheme) {
      return this;
    }
    return ZephyrSpinTheme(
      color: Color.lerp(color, other.color, t)!,
      tipStyle: TextStyle.lerp(tipStyle, other.tipStyle, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      borderRadius: const BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
    );
  }
}
