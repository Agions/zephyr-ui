import 'package:flutter/material.dart';

/// 标签组件主题
class ZephyrChipTheme extends ThemeExtension<ZephyrChipTheme> {
  /// 创建标签主题
  const ZephyrChipTheme({
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.disabledBackgroundColor,
    this.textColor,
    this.selectedTextColor,
    this.disabledTextColor,
    this.borderColor,
    this.selectedBorderColor,
    this.disabledBorderColor,
    this.deleteIconColor,
    this.textStyle,
    this.borderRadius,
    this.borderWidth,
    this.padding,
    this.height,
    this.iconSize,
    this.spacing,
  });

  /// 背景色
  final Color? backgroundColor;

  /// 选中状态背景色
  final Color? selectedBackgroundColor;

  /// 禁用状态背景色
  final Color? disabledBackgroundColor;

  /// 文本颜色
  final Color? textColor;

  /// 选中状态文本颜色
  final Color? selectedTextColor;

  /// 禁用状态文本颜色
  final Color? disabledTextColor;

  /// 边框颜色
  final Color? borderColor;

  /// 选中状态边框颜色
  final Color? selectedBorderColor;

  /// 禁用状态边框颜色

  /// 创建一个默认的ZephyrChipTheme实例
  static ZephyrChipTheme fallback(BuildContext context) {
    final theme = Theme.of(context);
    return ZephyrChipTheme(
      backgroundColor: theme.chipTheme.backgroundColor,
      selectedBackgroundColor: theme.colorScheme.primary,
      disabledBackgroundColor: theme.disabledColor.withOpacity(0.1),
      textColor: theme.colorScheme.onSurface,
      selectedTextColor: theme.colorScheme.onPrimary,
      disabledTextColor: theme.disabledColor,
      borderColor: theme.dividerColor,
      selectedBorderColor: theme.colorScheme.primary,
      disabledBorderColor: theme.disabledColor,
      deleteIconColor: theme.colorScheme.onSurface,
      textStyle: theme.textTheme.bodyMedium,
      borderRadius: BorderRadius.circular(16.0),
      borderWidth: 1.0,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      height: 32.0,
      iconSize: 18.0,
      spacing: 4.0,
    );
  }
  final Color? disabledBorderColor;

  /// 删除图标颜色
  final Color? deleteIconColor;

  /// 文本样式
  final TextStyle? textStyle;

  /// 边框圆角
  final BorderRadius? borderRadius;

  /// 边框宽度
  final double? borderWidth;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 高度
  final double? height;

  /// 图标尺寸
  final double? iconSize;

  /// 元素间距
  final double? spacing;

  /// 创建默认主题
  static ZephyrChipTheme fallback(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return ZephyrChipTheme(
      backgroundColor: isDark ? colorScheme.surface : colorScheme.surfaceContainerHighest,
      selectedBackgroundColor: colorScheme.primary,
      disabledBackgroundColor: isDark ? colorScheme.surface : colorScheme.surfaceContainerHighest,
      textColor: colorScheme.onSurface,
      selectedTextColor: colorScheme.onPrimary,
      disabledTextColor: colorScheme.onSurface.withValues(alpha: 0.38),
      borderColor: colorScheme.outline,
      selectedBorderColor: colorScheme.primary,
      disabledBorderColor: colorScheme.outline.withValues(alpha: 0.38),
      deleteIconColor: colorScheme.onSurface.withValues(alpha: 0.6),
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
      borderRadius: BorderRadius.circular(16),
      borderWidth: 1.0,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      height: 32.0,
      iconSize: 16.0,
      spacing: 4,
    );
  }

  @override
  ZephyrChipTheme copyWith({
    Color? backgroundColor,
    Color? selectedBackgroundColor,
    Color? disabledBackgroundColor,
    Color? textColor,
    Color? selectedTextColor,
    Color? disabledTextColor,
    Color? borderColor,
    Color? selectedBorderColor,
    Color? disabledBorderColor,
    Color? deleteIconColor,
    TextStyle? textStyle,
    BorderRadius? borderRadius,
    double? borderWidth,
    EdgeInsetsGeometry? padding,
    double? height,
    double? iconSize,
    double? spacing,
  }) {
    return ZephyrChipTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      selectedBackgroundColor: selectedBackgroundColor ?? this.selectedBackgroundColor,
      disabledBackgroundColor: disabledBackgroundColor ?? this.disabledBackgroundColor,
      textColor: textColor ?? this.textColor,
      selectedTextColor: selectedTextColor ?? this.selectedTextColor,
      disabledTextColor: disabledTextColor ?? this.disabledTextColor,
      borderColor: borderColor ?? this.borderColor,
      selectedBorderColor: selectedBorderColor ?? this.selectedBorderColor,
      disabledBorderColor: disabledBorderColor ?? this.disabledBorderColor,
      deleteIconColor: deleteIconColor ?? this.deleteIconColor,
      textStyle: textStyle ?? this.textStyle,
      borderRadius: borderRadius ?? this.borderRadius,
      borderWidth: borderWidth ?? this.borderWidth,
      padding: padding ?? this.padding,
      height: height ?? this.height,
      iconSize: iconSize ?? this.iconSize,
      spacing: spacing ?? this.spacing,
    );
  }

  @override
  ZephyrChipTheme lerp(ThemeExtension<ZephyrChipTheme>? other, double t) {
    if (other is! ZephyrChipTheme) return this;

    return ZephyrChipTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      selectedBackgroundColor: Color.lerp(selectedBackgroundColor, other.selectedBackgroundColor, t),
      disabledBackgroundColor: Color.lerp(disabledBackgroundColor, other.disabledBackgroundColor, t),
      textColor: Color.lerp(textColor, other.textColor, t),
      selectedTextColor: Color.lerp(selectedTextColor, other.selectedTextColor, t),
      disabledTextColor: Color.lerp(disabledTextColor, other.disabledTextColor, t),
      borderColor: Color.lerp(borderColor, other.borderColor, t),
      selectedBorderColor: Color.lerp(selectedBorderColor, other.selectedBorderColor, t),
      disabledBorderColor: Color.lerp(disabledBorderColor, other.disabledBorderColor, t),
      deleteIconColor: Color.lerp(deleteIconColor, other.deleteIconColor, t),
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t),
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t),
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t),
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
      height: lerpDouble(height, other.height, t),
      iconSize: lerpDouble(iconSize, other.iconSize, t),
      spacing: lerpDouble(spacing, other.spacing, t),
    );
  }
}

/// 线性插值辅助函数
double? lerpDouble(double? a, double? b, double t) {
  if (a == null && b == null) return null;
  if (a == null) return b! * t;
  if (b == null) return a * (1.0 - t);
  return a + (b - a) * t;
}
