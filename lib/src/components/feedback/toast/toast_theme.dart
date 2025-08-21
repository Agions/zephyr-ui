import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

// Import lerpDouble from dart:ui instead of custom implementation
import 'dart:ui' as ui;

/// 提示框组件主题
class ZephyrToastTheme extends ThemeExtension<ZephyrToastTheme> {
  /// 创建提示框主题
  const ZephyrToastTheme({
    required this.backgroundColor,
    required this.successBackgroundColor,
    required this.warningBackgroundColor,
    required this.errorBackgroundColor,
    required this.infoBackgroundColor,
    required this.textColor,
    required this.successTextColor,
    required this.warningTextColor,
    required this.errorTextColor,
    required this.infoTextColor,
    required this.iconColor,
    required this.successIconColor,
    required this.warningIconColor,
    required this.errorIconColor,
    required this.infoIconColor,
    required this.shadowColor,
    required this.textStyle,
    required this.borderRadius,
    required this.padding,
    required this.margin,
    required this.elevation,
    required this.maxWidth,
    required this.iconSize,
    required this.spacing,
  });

  /// 默认背景色
  final Color backgroundColor;

  /// 成功背景色
  final Color successBackgroundColor;

  /// 警告背景色
  final Color warningBackgroundColor;

  /// 错误背景色
  final Color errorBackgroundColor;

  /// 信息背景色
  final Color infoBackgroundColor;

  /// 默认文本颜色
  final Color textColor;

  /// 成功文本颜色
  final Color successTextColor;

  /// 警告文本颜色
  final Color warningTextColor;

  /// 错误文本颜色
  final Color errorTextColor;

  /// 信息文本颜色
  final Color infoTextColor;

  /// 默认图标颜色
  final Color iconColor;

  /// 成功图标颜色
  final Color successIconColor;

  /// 警告图标颜色
  final Color warningIconColor;

  /// 错误图标颜色
  final Color errorIconColor;

  /// 信息图标颜色
  final Color infoIconColor;

  /// 阴影颜色
  final Color shadowColor;

  /// 文本样式
  final TextStyle textStyle;

  /// 边框圆角
  final BorderRadius borderRadius;

  /// 内边距
  final EdgeInsetsGeometry padding;

  /// 外边距
  final EdgeInsetsGeometry margin;

  /// 阴影高度
  final double elevation;

  /// 最大宽度
  final double maxWidth;

  /// 图标尺寸
  final double iconSize;

  /// 元素间距
  final double spacing;

  /// 从上下文获取主题
  static ZephyrToastTheme of(BuildContext context) {
    final theme = Theme.of(context).extension<ZephyrToastTheme>();
    if (theme != null) return theme;
    
    final zephyrTheme = ZephyrTheme.of(context);
    return _createDefaultTheme(zephyrTheme);
  }

  /// 创建默认主题
  static ZephyrToastTheme _createDefaultTheme(ZephyrThemeData zephyrTheme) {
    final isDark = zephyrTheme.brightness == Brightness.dark;
    
    return ZephyrToastTheme(
      backgroundColor: isDark ? ZephyrColors.neutral800 : Colors.white,
      successBackgroundColor: ZephyrColors.success500,
      warningBackgroundColor: ZephyrColors.warning500,
      errorBackgroundColor: ZephyrColors.error500,
      infoBackgroundColor: ZephyrColors.info500,
      textColor: isDark ? ZephyrColors.neutral100 : ZephyrColors.neutral900,
      successTextColor: Colors.white,
      warningTextColor: Colors.white,
      errorTextColor: Colors.white,
      infoTextColor: Colors.white,
      iconColor: isDark ? ZephyrColors.neutral300 : ZephyrColors.neutral600,
      successIconColor: Colors.white,
      warningIconColor: Colors.white,
      errorIconColor: Colors.white,
      infoIconColor: Colors.white,
      shadowColor: isDark ? Colors.black.withValues(alpha: 0.3) : Colors.black.withValues(alpha: 0.1),
      textStyle: const TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightMedium,
        height: ZephyrTypography.lineHeight1_4,
      ),
      borderRadius: BorderRadius.circular(ZephyrRadius.md),
      padding: const EdgeInsets.all(ZephyrSpacing.md),
      margin: const EdgeInsets.all(ZephyrSpacing.md),
      elevation: 4.0,
      maxWidth: 400.0,
      iconSize: 20.0,
      spacing: ZephyrSpacing.sm,
    );
  }

  @override
  ZephyrToastTheme copyWith({
    Color? backgroundColor,
    Color? successBackgroundColor,
    Color? warningBackgroundColor,
    Color? errorBackgroundColor,
    Color? infoBackgroundColor,
    Color? textColor,
    Color? successTextColor,
    Color? warningTextColor,
    Color? errorTextColor,
    Color? infoTextColor,
    Color? iconColor,
    Color? successIconColor,
    Color? warningIconColor,
    Color? errorIconColor,
    Color? infoIconColor,
    Color? shadowColor,
    TextStyle? textStyle,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? elevation,
    double? maxWidth,
    double? iconSize,
    double? spacing,
  }) {
    return ZephyrToastTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      successBackgroundColor: successBackgroundColor ?? this.successBackgroundColor,
      warningBackgroundColor: warningBackgroundColor ?? this.warningBackgroundColor,
      errorBackgroundColor: errorBackgroundColor ?? this.errorBackgroundColor,
      infoBackgroundColor: infoBackgroundColor ?? this.infoBackgroundColor,
      textColor: textColor ?? this.textColor,
      successTextColor: successTextColor ?? this.successTextColor,
      warningTextColor: warningTextColor ?? this.warningTextColor,
      errorTextColor: errorTextColor ?? this.errorTextColor,
      infoTextColor: infoTextColor ?? this.infoTextColor,
      iconColor: iconColor ?? this.iconColor,
      successIconColor: successIconColor ?? this.successIconColor,
      warningIconColor: warningIconColor ?? this.warningIconColor,
      errorIconColor: errorIconColor ?? this.errorIconColor,
      infoIconColor: infoIconColor ?? this.infoIconColor,
      shadowColor: shadowColor ?? this.shadowColor,
      textStyle: textStyle ?? this.textStyle,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      elevation: elevation ?? this.elevation,
      maxWidth: maxWidth ?? this.maxWidth,
      iconSize: iconSize ?? this.iconSize,
      spacing: spacing ?? this.spacing,
    );
  }

  @override
  ZephyrToastTheme lerp(ThemeExtension<ZephyrToastTheme>? other, double t) {
    if (other is! ZephyrToastTheme) return this;
    
    return ZephyrToastTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ?? backgroundColor,
      successBackgroundColor: Color.lerp(successBackgroundColor, other.successBackgroundColor, t) ?? successBackgroundColor,
      warningBackgroundColor: Color.lerp(warningBackgroundColor, other.warningBackgroundColor, t) ?? warningBackgroundColor,
      errorBackgroundColor: Color.lerp(errorBackgroundColor, other.errorBackgroundColor, t) ?? errorBackgroundColor,
      infoBackgroundColor: Color.lerp(infoBackgroundColor, other.infoBackgroundColor, t) ?? infoBackgroundColor,
      textColor: Color.lerp(textColor, other.textColor, t) ?? textColor,
      successTextColor: Color.lerp(successTextColor, other.successTextColor, t) ?? successTextColor,
      warningTextColor: Color.lerp(warningTextColor, other.warningTextColor, t) ?? warningTextColor,
      errorTextColor: Color.lerp(errorTextColor, other.errorTextColor, t) ?? errorTextColor,
      infoTextColor: Color.lerp(infoTextColor, other.infoTextColor, t) ?? infoTextColor,
      iconColor: Color.lerp(iconColor, other.iconColor, t) ?? iconColor,
      successIconColor: Color.lerp(successIconColor, other.successIconColor, t) ?? successIconColor,
      warningIconColor: Color.lerp(warningIconColor, other.warningIconColor, t) ?? warningIconColor,
      errorIconColor: Color.lerp(errorIconColor, other.errorIconColor, t) ?? errorIconColor,
      infoIconColor: Color.lerp(infoIconColor, other.infoIconColor, t) ?? infoIconColor,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t) ?? shadowColor,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t) ?? textStyle,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t) ?? borderRadius,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t) ?? padding,
      margin: EdgeInsetsGeometry.lerp(margin, other.margin, t) ?? margin,
      elevation: ui.lerpDouble(elevation, other.elevation, t) ?? elevation,
      maxWidth: ui.lerpDouble(maxWidth, other.maxWidth, t) ?? maxWidth,
      iconSize: ui.lerpDouble(iconSize, other.iconSize, t) ?? iconSize,
      spacing: ui.lerpDouble(spacing, other.spacing, t) ?? spacing,
    );
  }
}

