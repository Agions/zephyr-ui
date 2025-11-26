/// ZephyrUI 返回顶部主题
///
/// 定义返回顶部组件的主题样式。
library backtop_theme;

import 'package:flutter/material.dart';

/// ZephyrUI 返回顶部主题
class ZephyrBackTopTheme extends ThemeExtension<ZephyrBackTopTheme> {
  /// 创建返回顶部主题
  const ZephyrBackTopTheme({
    required this.backgroundColor,
    required this.iconColor,
    required this.borderRadius,
    required this.boxShadow,
  });

  /// 从主题创建返回顶部主题
  factory ZephyrBackTopTheme.fromTheme(ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return ZephyrBackTopTheme(
      backgroundColor: colorScheme.primary,
      iconColor: colorScheme.onPrimary,
      borderRadius: const BorderRadius.circular(20),
      boxShadow: [
        const BoxShadow(
          color: Colors.black.withValues(alpha:0.2),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  /// 创建亮色主题
  factory ZephyrBackTopTheme.light() {
    return ZephyrBackTopTheme.fromTheme(ThemeData.light());
  }

  /// 创建暗色主题
  factory ZephyrBackTopTheme.dark() {
    return ZephyrBackTopTheme.fromTheme(ThemeData.dark());
  }

  /// 背景色
  final Color backgroundColor;

  /// 图标颜色
  final Color iconColor;

  /// 圆角
  final BorderRadius borderRadius;

  /// 阴影
  final List<BoxShadow> boxShadow;

  @override
  ZephyrBackTopTheme copyWith({
    Color? backgroundColor,
    Color? iconColor,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
  }) {
    return ZephyrBackTopTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      iconColor: iconColor ?? this.iconColor,
      borderRadius: borderRadius ?? this.borderRadius,
      boxShadow: boxShadow ?? this.boxShadow,
    );
  }

  @override
  ZephyrBackTopTheme lerp(ThemeExtension<ZephyrBackTopTheme>? other, double t) {
    if (other is! ZephyrBackTopTheme) {
      return this;
    }
    return ZephyrBackTopTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      borderRadius: const BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
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
