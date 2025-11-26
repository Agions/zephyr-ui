import 'package:flutter/material.dart';

/// 定义ZephyrCard组件的样式变体
enum ZephyrCardVariant {
  /// 标准样式
  standard,

  /// 扁平样式
  flat,

  /// 阴影高度明显的样式
  elevated,

  /// 填充背景色的样式
  filled,

  /// 带轮廓的样式
  outlined,
}

/// Zephyr UI卡片组件的主题定义
///
/// 为ZephyrCard组件提供统一的样式定义，支持多种卡片变体
class ZephyrCardTheme extends ThemeExtension<ZephyrCardTheme> {
  /// 创建一个ZephyrCardTheme实例
  const ZephyrCardTheme({
    this.backgroundColor,
    this.foregroundColor,
    this.shadowColor,
    this.surfaceTintColor,
    this.elevations = const {
      ZephyrCardVariant.standard: 1.0,
      ZephyrCardVariant.flat: 0.0,
      ZephyrCardVariant.elevated: 3.0,
      ZephyrCardVariant.filled: 0.0,
      ZephyrCardVariant.outlined: 0.0,
    },
    this.borderRadius = const BorderRadius.all(Radius.circular(12.0)),
    this.borderWidth = 1.0,
    this.borderColor,
    this.padding = const EdgeInsets.all(16.0),
    this.margin = const EdgeInsets.all(8.0),
    this.hoverElevationDelta = 2.0,
    this.pressedOpacity = 0.9,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
  });

  /// 创建一个默认的ZephyrCardTheme实例
  static ZephyrCardTheme fallback(BuildContext context) {
    final theme = Theme.of(context);
    return ZephyrCardTheme(
      backgroundColor: theme.cardColor,
      foregroundColor: theme.colorScheme.onSurface,
      shadowColor: theme.shadowColor,
      surfaceTintColor: theme.colorScheme.primary,
      borderColor: theme.dividerColor,
    );
  }

  /// 卡片的背景颜色
  ///
  /// 如果为null，将使用ThemeData中的cardColor
  final Color? backgroundColor;

  /// 卡片内容的默认前景色
  ///
  /// 如果为null，将根据背景色自动选择适合的前景色
  final Color? foregroundColor;

  /// 卡片阴影的颜色
  ///
  /// 如果为null，将使用ThemeData中的shadowColor
  final Color? shadowColor;

  /// Material 3设计中的表面色调
  ///
  /// 如果为null，将使用ThemeData中的colorScheme.surfaceTint
  final Color? surfaceTintColor;

  /// 不同变体的卡片阴影高度
  final Map<ZephyrCardVariant, double> elevations;

  /// 卡片的圆角半径
  final BorderRadius borderRadius;

  /// 卡片边框宽度（仅适用于outlined变体）
  final double borderWidth;

  /// 卡片边框颜色（仅适用于outlined变体）
  ///
  /// 如果为null，将使用ThemeData中的dividerColor
  final Color? borderColor;

  /// 卡片内边距
  final EdgeInsetsGeometry padding;

  /// 卡片外边距
  final EdgeInsetsGeometry margin;

  /// 悬停状态时增加的阴影高度
  final double hoverElevationDelta;

  /// 按下状态时的不透明度
  final double pressedOpacity;

  /// 动画持续时间
  final Duration animationDuration;

  /// 动画曲线
  final Curve animationCurve;

  /// 创建一个基于当前主题的复制实例，但应用指定的属性
  @override
  ZephyrCardTheme copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    Color? shadowColor,
    Color? surfaceTintColor,
    Map<ZephyrCardVariant, double>? elevations,
    BorderRadius? borderRadius,
    double? borderWidth,
    Color? borderColor,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? hoverElevationDelta,
    double? pressedOpacity,
    Duration? animationDuration,
    Curve? animationCurve,
  }) {
    return ZephyrCardTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      shadowColor: shadowColor ?? this.shadowColor,
      surfaceTintColor: surfaceTintColor ?? this.surfaceTintColor,
      elevations: elevations ?? this.elevations,
      borderRadius: borderRadius ?? this.borderRadius,
      borderWidth: borderWidth ?? this.borderWidth,
      borderColor: borderColor ?? this.borderColor,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      hoverElevationDelta: hoverElevationDelta ?? this.hoverElevationDelta,
      pressedOpacity: pressedOpacity ?? this.pressedOpacity,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
    );
  }

  /// 在两个ZephyrCardTheme实例之间进行插值
  @override
  ZephyrCardTheme lerp(ThemeExtension<ZephyrCardTheme>? other, double t) {
    if (other is! ZephyrCardTheme) {
      return this;
    }

    // 创建新的elevations映射，对每个变体的值进行插值
    var lerpedElevations = <ZephyrCardVariant, double>{};
    elevations.forEach((variant, value) {
      lerpedElevations[variant] =
          _lerpDouble(value, other.elevations[variant] ?? value, t)!;
    });

    return ZephyrCardTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      foregroundColor: Color.lerp(foregroundColor, other.foregroundColor, t),
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t),
      surfaceTintColor: Color.lerp(surfaceTintColor, other.surfaceTintColor, t),
      elevations: lerpedElevations,
      borderRadius: const BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
      borderWidth: _lerpDouble(borderWidth, other.borderWidth, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t),
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t)!,
      margin: EdgeInsetsGeometry.lerp(margin, other.margin, t)!,
      hoverElevationDelta:
          _lerpDouble(hoverElevationDelta, other.hoverElevationDelta, t)!,
      pressedOpacity: _lerpDouble(pressedOpacity, other.pressedOpacity, t)!,
      animationDuration:
          lerpDuration(animationDuration, other.animationDuration, t),
      animationCurve: t < 0.5 ? animationCurve : other.animationCurve,
    );
  }

  /// 从主题中获取ZephyrCardTheme实例
  static ZephyrCardTheme of(BuildContext context) {
    return Theme.of(context).extension<ZephyrCardTheme>() ??
        _fallbackTheme(context);
  }

  /// 获取特定变体的高度值
  double getElevation(ZephyrCardVariant variant) {
    return elevations[variant] ?? elevations[ZephyrCardVariant.standard]!;
  }

  /// 创建一个基于当前主题的默认ZephyrCardTheme
  static ZephyrCardTheme _fallbackTheme(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ZephyrCardTheme(
      backgroundColor: theme.cardColor,
      foregroundColor: theme.colorScheme.onSurface,
      shadowColor: theme.shadowColor,
      surfaceTintColor: colorScheme.surfaceTint,
      borderColor: theme.dividerColor,
    );
  }
}

/// 在两个double值之间进行插值
double? _lerpDouble(double? a, double? b, double t) {
  if (a == null && b == null) return null;
  if (a == null) return b! * t;
  if (b == null) return a * (1.0 - t);
  return a + (b - a) * t;
}

/// 在两个Duration值之间进行插值
Duration lerpDuration(Duration a, Duration b, double t) {
  return Duration(
    milliseconds: _lerpDouble(
            a.inMilliseconds.toDouble(), b.inMilliseconds.toDouble(), t)!
        .round(),
  );
}
