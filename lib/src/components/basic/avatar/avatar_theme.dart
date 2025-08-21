import 'package:flutter/material.dart';

/// 定义ZephyrAvatar组件的主题样式
class ZephyrAvatarTheme extends ThemeExtension<ZephyrAvatarTheme> {
  /// 创建一个ZephyrAvatarTheme实例
  const ZephyrAvatarTheme({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderWidth,
    required this.borderColor,
    required this.elevation,
    required this.shadowColor,
    required this.squareBorderRadius,
  });

  /// 头像背景色
  final Color backgroundColor;

  /// 头像前景色（文字或图标颜色）
  final Color foregroundColor;

  /// 头像边框宽度
  final double borderWidth;

  /// 头像边框颜色
  final Color borderColor;

  /// 阴影高度
  final double elevation;

  /// 阴影颜色
  final Color shadowColor;

  /// 方形头像的圆角半径
  final double squareBorderRadius;

  @override
  ZephyrAvatarTheme copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    double? borderWidth,
    Color? borderColor,
    double? elevation,
    Color? shadowColor,
    double? squareBorderRadius,
  }) {
    return ZephyrAvatarTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderColor: borderColor ?? this.borderColor,
      elevation: elevation ?? this.elevation,
      shadowColor: shadowColor ?? this.shadowColor,
      squareBorderRadius: squareBorderRadius ?? this.squareBorderRadius,
    );
  }

  @override
  ZephyrAvatarTheme lerp(ThemeExtension<ZephyrAvatarTheme>? other, double t) {
    if (other is! ZephyrAvatarTheme) {
      return this;
    }

    return ZephyrAvatarTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      foregroundColor: Color.lerp(foregroundColor, other.foregroundColor, t)!,
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      elevation: lerpDouble(elevation, other.elevation, t)!,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t)!,
      squareBorderRadius:
          lerpDouble(squareBorderRadius, other.squareBorderRadius, t)!,
    );
  }

  /// 创建一个基于当前主题的默认ZephyrAvatarTheme
  static ZephyrAvatarTheme fallback(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ZephyrAvatarTheme(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      borderWidth: 0.0,
      borderColor: colorScheme.outline,
      elevation: 0.0,
      shadowColor: theme.shadowColor,
      squareBorderRadius: 8.0,
    );
  }
}

/// 在两个double值之间进行插值
double? lerpDouble(double? a, double? b, double t) {
  if (a == null && b == null) return null;
  if (a == null) return b! * t;
  if (b == null) return a * (1.0 - t);
  return a + (b - a) * t;
}
