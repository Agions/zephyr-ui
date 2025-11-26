import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:zephyr_ui/zephyr_ui.dart';

/// 定义ZephyrButton的视觉属性
///
/// 此主题用于ZephyrButton组件确定视觉样式，包括颜色、文本样式和尺寸。
class ZephyrButtonTheme extends ThemeExtension<ZephyrButtonTheme> {
  const ZephyrButtonTheme({
    this.primaryBackgroundColor,
    this.primaryTextColor,
    this.secondaryBackgroundColor,
    this.secondaryTextColor,
    this.outlineColor,
    this.outlineTextColor,
    this.textButtonColor,
    this.disabledBackgroundColor,
    this.disabledTextColor,
    this.borderRadius,
    this.smallPadding,
    this.mediumPadding,
    this.largePadding,
    this.smallTextStyle,
    this.mediumTextStyle,
    this.largeTextStyle,
    this.loadingColor,
    this.splashColor,
    this.elevation,
    this.disabledElevation,
  });

  /// 主要按钮的背景色
  final Color? primaryBackgroundColor;

  /// 主要按钮的文本颜色
  final Color? primaryTextColor;

  /// 次要按钮的背景色
  final Color? secondaryBackgroundColor;

  /// 次要按钮的文本颜色
  final Color? secondaryTextColor;

  /// 轮廓按钮的边框颜色
  final Color? outlineColor;

  /// 轮廓按钮的文本颜色
  final Color? outlineTextColor;

  /// 文本按钮颜色
  final Color? textButtonColor;

  /// 禁用状态的背景色
  final Color? disabledBackgroundColor;

  /// 禁用状态的文本颜色
  final Color? disabledTextColor;

  /// 按钮的圆角半径
  final double? borderRadius;

  /// 小型按钮的内边距
  final EdgeInsetsGeometry? smallPadding;

  /// 中型按钮的内边距
  final EdgeInsetsGeometry? mediumPadding;

  /// 大型按钮的内边距
  final EdgeInsetsGeometry? largePadding;

  /// 小型按钮的文本样式
  final TextStyle? smallTextStyle;

  /// 中型按钮的文本样式
  final TextStyle? mediumTextStyle;

  /// 大型按钮的文本样式
  final TextStyle? largeTextStyle;

  /// 加载状态的颜色
  final Color? loadingColor;

  /// 点击时的水波纹颜色
  final Color? splashColor;

  /// 按钮的阴影高度
  final double? elevation;

  /// 禁用状态的阴影高度
  final double? disabledElevation;

  /// 创建当前主题的副本，并替换指定字段
  @override
  ZephyrButtonTheme copyWith({
    Color? primaryBackgroundColor,
    Color? primaryTextColor,
    Color? secondaryBackgroundColor,
    Color? secondaryTextColor,
    Color? outlineColor,
    Color? outlineTextColor,
    Color? textButtonColor,
    Color? disabledBackgroundColor,
    Color? disabledTextColor,
    double? borderRadius,
    EdgeInsetsGeometry? smallPadding,
    EdgeInsetsGeometry? mediumPadding,
    EdgeInsetsGeometry? largePadding,
    TextStyle? smallTextStyle,
    TextStyle? mediumTextStyle,
    TextStyle? largeTextStyle,
    Color? loadingColor,
    Color? splashColor,
    double? elevation,
    double? disabledElevation,
  }) {
    return ZephyrButtonTheme(
      primaryBackgroundColor:
          primaryBackgroundColor ?? this.primaryBackgroundColor,
      primaryTextColor: primaryTextColor ?? this.primaryTextColor,
      secondaryBackgroundColor:
          secondaryBackgroundColor ?? this.secondaryBackgroundColor,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      outlineColor: outlineColor ?? this.outlineColor,
      outlineTextColor: outlineTextColor ?? this.outlineTextColor,
      textButtonColor: textButtonColor ?? this.textButtonColor,
      disabledBackgroundColor:
          disabledBackgroundColor ?? this.disabledBackgroundColor,
      disabledTextColor: disabledTextColor ?? this.disabledTextColor,
      borderRadius: borderRadius ?? this.borderRadius,
      smallPadding: smallPadding ?? this.smallPadding,
      mediumPadding: mediumPadding ?? this.mediumPadding,
      largePadding: largePadding ?? this.largePadding,
      smallTextStyle: smallTextStyle ?? this.smallTextStyle,
      mediumTextStyle: mediumTextStyle ?? this.mediumTextStyle,
      largeTextStyle: largeTextStyle ?? this.largeTextStyle,
      loadingColor: loadingColor ?? this.loadingColor,
      splashColor: splashColor ?? this.splashColor,
      elevation: elevation ?? this.elevation,
      disabledElevation: disabledElevation ?? this.disabledElevation,
    );
  }

  /// 在两个ZephyrButtonTheme实例之间进行插值
  @override
  ZephyrButtonTheme lerp(ThemeExtension<ZephyrButtonTheme>? other, double t) {
    if (other is! ZephyrButtonTheme) {
      return this;
    }

    return ZephyrButtonTheme(
      primaryBackgroundColor:
          Color.lerp(primaryBackgroundColor, other.primaryBackgroundColor, t),
      primaryTextColor: Color.lerp(primaryTextColor, other.primaryTextColor, t),
      secondaryBackgroundColor: Color.lerp(
          secondaryBackgroundColor, other.secondaryBackgroundColor, t),
      secondaryTextColor:
          Color.lerp(secondaryTextColor, other.secondaryTextColor, t),
      outlineColor: Color.lerp(outlineColor, other.outlineColor, t),
      outlineTextColor: Color.lerp(outlineTextColor, other.outlineTextColor, t),
      textButtonColor: Color.lerp(textButtonColor, other.textButtonColor, t),
      disabledBackgroundColor:
          Color.lerp(disabledBackgroundColor, other.disabledBackgroundColor, t),
      disabledTextColor:
          Color.lerp(disabledTextColor, other.disabledTextColor, t),
      borderRadius: ui.lerpDouble(borderRadius, other.borderRadius, t),
      smallPadding:
          EdgeInsetsGeometry.lerp(smallPadding, other.smallPadding, t),
      mediumPadding:
          EdgeInsetsGeometry.lerp(mediumPadding, other.mediumPadding, t),
      largePadding:
          EdgeInsetsGeometry.lerp(largePadding, other.largePadding, t),
      smallTextStyle: TextStyle.lerp(smallTextStyle, other.smallTextStyle, t),
      mediumTextStyle:
          TextStyle.lerp(mediumTextStyle, other.mediumTextStyle, t),
      largeTextStyle: TextStyle.lerp(largeTextStyle, other.largeTextStyle, t),
      loadingColor: Color.lerp(loadingColor, other.loadingColor, t),
      splashColor: Color.lerp(splashColor, other.splashColor, t),
      elevation: ui.lerpDouble(elevation, other.elevation, t),
      disabledElevation:
          ui.lerpDouble(disabledElevation, other.disabledElevation, t),
    );
  }

  /// 从主题中获取ZephyrButtonTheme实例
  static ZephyrButtonTheme of(BuildContext context) {
    return Theme.of(context).extension<ZephyrButtonTheme>() ??
        _fallbackTheme(context);
  }

  /// 基于父主题解析主题并返回默认值
  /// 当值未指定时返回默认值（保持向后兼容）
  static ZephyrButtonTheme resolve(
    BuildContext context,
    ZephyrButtonTheme? theme,
  ) {
    if (theme != null) {
      return theme;
    }
    return _fallbackTheme(context);
  }

  /// 创建一个基于当前主题的默认ZephyrButtonTheme
  static ZephyrButtonTheme _fallbackTheme(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ZephyrButtonTheme(
      primaryBackgroundColor: colorScheme.primary,
      primaryTextColor: colorScheme.onPrimary,
      secondaryBackgroundColor: colorScheme.secondary,
      secondaryTextColor: colorScheme.onSecondary,
      outlineColor: colorScheme.primary,
      outlineTextColor: colorScheme.primary,
      textButtonColor: colorScheme.primary,
      disabledBackgroundColor: ZephyrColors.neutral300,
      disabledTextColor: ZephyrColors.neutral600,
      borderRadius: ZephyrRadius.sm,
      smallPadding: const EdgeInsets.symmetric(
          horizontal: ZephyrSpacing.sm, vertical: ZephyrSpacing.xs),
      mediumPadding: const EdgeInsets.symmetric(
          horizontal: ZephyrSpacing.md, vertical: ZephyrSpacing.sm),
      largePadding: const EdgeInsets.symmetric(
          horizontal: ZephyrSpacing.lg, vertical: ZephyrSpacing.md),
      smallTextStyle: textTheme.labelSmall,
      mediumTextStyle: textTheme.labelMedium,
      largeTextStyle: textTheme.labelLarge,
      loadingColor: colorScheme.onPrimary,
      splashColor: Colors.white.withValues(alpha: 0.3),
      elevation: ZephyrElevation.sm,
      disabledElevation: 0.0,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ZephyrButtonTheme &&
        other.primaryBackgroundColor == primaryBackgroundColor &&
        other.primaryTextColor == primaryTextColor &&
        other.secondaryBackgroundColor == secondaryBackgroundColor &&
        other.secondaryTextColor == secondaryTextColor &&
        other.outlineColor == outlineColor &&
        other.outlineTextColor == outlineTextColor &&
        other.textButtonColor == textButtonColor &&
        other.disabledBackgroundColor == disabledBackgroundColor &&
        other.disabledTextColor == disabledTextColor &&
        other.borderRadius == borderRadius &&
        other.smallPadding == smallPadding &&
        other.mediumPadding == mediumPadding &&
        other.largePadding == largePadding &&
        other.smallTextStyle == smallTextStyle &&
        other.mediumTextStyle == mediumTextStyle &&
        other.largeTextStyle == largeTextStyle &&
        other.loadingColor == loadingColor &&
        other.splashColor == splashColor &&
        other.elevation == elevation &&
        other.disabledElevation == disabledElevation;
  }

  @override
  int get hashCode {
    return Object.hash(
      primaryBackgroundColor,
      primaryTextColor,
      secondaryBackgroundColor,
      secondaryTextColor,
      outlineColor,
      outlineTextColor,
      textButtonColor,
      disabledBackgroundColor,
      disabledTextColor,
      borderRadius,
      Object.hash(
        smallPadding,
        mediumPadding,
        largePadding,
        smallTextStyle,
        mediumTextStyle,
        largeTextStyle,
        loadingColor,
        splashColor,
        elevation,
        disabledElevation,
      ),
    );
  }
}
