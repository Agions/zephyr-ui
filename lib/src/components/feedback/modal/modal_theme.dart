import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

// Import lerpDouble from dart:ui instead of custom implementation
import 'dart:ui' as ui;

/// 模态框组件主题
class ZephyrModalTheme extends ThemeExtension<ZephyrModalTheme> {
  /// 创建模态框主题
  const ZephyrModalTheme({
    required this.backgroundColor,
    required this.barrierColor,
    required this.shadowColor,
    required this.borderRadius,
    required this.elevation,
    required this.padding,
    required this.margin,
    required this.maxWidth,
    required this.maxHeight,
    required this.titleTextStyle,
    required this.contentTextStyle,
    required this.actionSpacing,
    required this.contentSpacing,
  });

  /// 背景色
  final Color backgroundColor;

  /// 遮罩层颜色
  final Color barrierColor;

  /// 阴影颜色
  final Color shadowColor;

  /// 边框圆角
  final BorderRadius borderRadius;

  /// 阴影高度
  final double elevation;

  /// 内边距
  final EdgeInsetsGeometry padding;

  /// 外边距
  final EdgeInsetsGeometry margin;

  /// 最大宽度
  final double maxWidth;

  /// 最大高度
  final double maxHeight;

  /// 标题文本样式
  final TextStyle titleTextStyle;

  /// 内容文本样式
  final TextStyle contentTextStyle;

  /// 操作按钮间距
  final double actionSpacing;

  /// 内容间距
  final double contentSpacing;

  /// 从上下文获取主题
  static ZephyrModalTheme of(BuildContext context) {
    final theme = Theme.of(context).extension<ZephyrModalTheme>();
    if (theme != null) return theme;
    
    final zephyrTheme = ZephyrTheme.of(context);
    return _createDefaultTheme(zephyrTheme);
  }

  /// 创建默认主题
  static ZephyrModalTheme _createDefaultTheme(ZephyrThemeData zephyrTheme) {
    final isDark = zephyrTheme.brightness == Brightness.dark;
    
    return ZephyrModalTheme(
      backgroundColor: isDark ? ZephyrColors.neutral800 : Colors.white,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      shadowColor: isDark ? Colors.black.withValues(alpha: 0.3) : Colors.black.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(ZephyrRadius.lg),
      elevation: 8.0,
      padding: const EdgeInsets.all(ZephyrSpacing.lg),
      margin: const EdgeInsets.all(ZephyrSpacing.lg),
      maxWidth: 600.0,
      maxHeight: 800.0,
      titleTextStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize20,
        fontWeight: ZephyrTypography.fontWeightSemiBold,
        color: isDark ? ZephyrColors.neutral100 : ZephyrColors.neutral900,
        height: ZephyrTypography.lineHeight1_4,
      ),
      contentTextStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize16,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: isDark ? ZephyrColors.neutral200 : ZephyrColors.neutral700,
        height: ZephyrTypography.lineHeight1_5,
      ),
      actionSpacing: ZephyrSpacing.sm,
      contentSpacing: ZephyrSpacing.md,
    );
  }

  @override
  ZephyrModalTheme copyWith({
    Color? backgroundColor,
    Color? barrierColor,
    Color? shadowColor,
    BorderRadius? borderRadius,
    double? elevation,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? maxWidth,
    double? maxHeight,
    TextStyle? titleTextStyle,
    TextStyle? contentTextStyle,
    double? actionSpacing,
    double? contentSpacing,
  }) {
    return ZephyrModalTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      barrierColor: barrierColor ?? this.barrierColor,
      shadowColor: shadowColor ?? this.shadowColor,
      borderRadius: borderRadius ?? this.borderRadius,
      elevation: elevation ?? this.elevation,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      maxWidth: maxWidth ?? this.maxWidth,
      maxHeight: maxHeight ?? this.maxHeight,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      contentTextStyle: contentTextStyle ?? this.contentTextStyle,
      actionSpacing: actionSpacing ?? this.actionSpacing,
      contentSpacing: contentSpacing ?? this.contentSpacing,
    );
  }

  @override
  ZephyrModalTheme lerp(ThemeExtension<ZephyrModalTheme>? other, double t) {
    if (other is! ZephyrModalTheme) return this;
    
    return ZephyrModalTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ?? backgroundColor,
      barrierColor: Color.lerp(barrierColor, other.barrierColor, t) ?? barrierColor,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t) ?? shadowColor,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t) ?? borderRadius,
      elevation: ui.lerpDouble(elevation, other.elevation, t) ?? elevation,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t) ?? padding,
      margin: EdgeInsetsGeometry.lerp(margin, other.margin, t) ?? margin,
      maxWidth: ui.lerpDouble(maxWidth, other.maxWidth, t) ?? maxWidth,
      maxHeight: ui.lerpDouble(maxHeight, other.maxHeight, t) ?? maxHeight,
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t) ?? titleTextStyle,
      contentTextStyle: TextStyle.lerp(contentTextStyle, other.contentTextStyle, t) ?? contentTextStyle,
      actionSpacing: ui.lerpDouble(actionSpacing, other.actionSpacing, t) ?? actionSpacing,
      contentSpacing: ui.lerpDouble(contentSpacing, other.contentSpacing, t) ?? contentSpacing,
    );
  }
}

