import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

// Import lerpDouble from dart:ui instead of custom implementation
import 'dart:ui' as ui;

/// 标签页组件主题
class ZephyrTabsTheme extends ThemeExtension<ZephyrTabsTheme> {
  /// 创建标签页主题
  const ZephyrTabsTheme({
    required this.backgroundColor,
    required this.indicatorColor,
    required this.selectedTabColor,
    required this.unselectedTabColor,
    required this.disabledTabColor,
    required this.borderColor,
    required this.selectedTextStyle,
    required this.unselectedTextStyle,
    required this.disabledTextStyle,
    required this.tabPadding,
    required this.indicatorHeight,
    required this.borderRadius,
    required this.tabHeight,
    required this.spacing,
  });

  /// 背景色
  final Color backgroundColor;

  /// 指示器颜色
  final Color indicatorColor;

  /// 选中标签颜色
  final Color selectedTabColor;

  /// 未选中标签颜色
  final Color unselectedTabColor;

  /// 禁用标签颜色
  final Color disabledTabColor;

  /// 边框颜色
  final Color borderColor;

  /// 选中文本样式
  final TextStyle selectedTextStyle;

  /// 未选中文本样式
  final TextStyle unselectedTextStyle;

  /// 禁用文本样式
  final TextStyle disabledTextStyle;

  /// 标签内边距
  final EdgeInsetsGeometry tabPadding;

  /// 指示器高度
  final double indicatorHeight;

  /// 边框圆角
  final BorderRadius borderRadius;

  /// 标签高度
  final double tabHeight;

  /// 标签间距
  final double spacing;

  /// 从上下文获取主题
  static ZephyrTabsTheme of(BuildContext context) {
    final theme = Theme.of(context).extension<ZephyrTabsTheme>();
    if (theme != null) return theme;
    
    final zephyrTheme = ZephyrTheme.of(context);
    return _createDefaultTheme(zephyrTheme);
  }

  /// 创建默认主题
  static ZephyrTabsTheme _createDefaultTheme(ZephyrThemeData zephyrTheme) {
    final isDark = zephyrTheme.brightness == Brightness.dark;
    
    return ZephyrTabsTheme(
      backgroundColor: isDark ? ZephyrColors.neutral800 : Colors.white,
      indicatorColor: zephyrTheme.primaryColor,
      selectedTabColor: isDark 
          ? zephyrTheme.primaryColor.withValues(alpha: 0.2)
          : zephyrTheme.primaryColor.withValues(alpha: 0.1),
      unselectedTabColor: Colors.transparent,
      disabledTabColor: isDark ? ZephyrColors.neutral700 : ZephyrColors.neutral100,
      borderColor: isDark ? ZephyrColors.neutral600 : ZephyrColors.neutral300,
      selectedTextStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightSemiBold,
        color: zephyrTheme.primaryColor,
        height: ZephyrTypography.lineHeight1_4,
      ),
      unselectedTextStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightMedium,
        color: isDark ? ZephyrColors.neutral300 : ZephyrColors.neutral600,
        height: ZephyrTypography.lineHeight1_4,
      ),
      disabledTextStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightMedium,
        color: isDark ? ZephyrColors.neutral500 : ZephyrColors.neutral400,
        height: ZephyrTypography.lineHeight1_4,
      ),
      tabPadding: const EdgeInsets.symmetric(
        horizontal: ZephyrSpacing.md,
        vertical: ZephyrSpacing.sm,
      ),
      indicatorHeight: 2.0,
      borderRadius: BorderRadius.circular(ZephyrRadius.sm),
      tabHeight: 48.0,
      spacing: ZephyrSpacing.xs,
    );
  }

  @override
  ZephyrTabsTheme copyWith({
    Color? backgroundColor,
    Color? indicatorColor,
    Color? selectedTabColor,
    Color? unselectedTabColor,
    Color? disabledTabColor,
    Color? borderColor,
    TextStyle? selectedTextStyle,
    TextStyle? unselectedTextStyle,
    TextStyle? disabledTextStyle,
    EdgeInsetsGeometry? tabPadding,
    double? indicatorHeight,
    BorderRadius? borderRadius,
    double? tabHeight,
    double? spacing,
  }) {
    return ZephyrTabsTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      indicatorColor: indicatorColor ?? this.indicatorColor,
      selectedTabColor: selectedTabColor ?? this.selectedTabColor,
      unselectedTabColor: unselectedTabColor ?? this.unselectedTabColor,
      disabledTabColor: disabledTabColor ?? this.disabledTabColor,
      borderColor: borderColor ?? this.borderColor,
      selectedTextStyle: selectedTextStyle ?? this.selectedTextStyle,
      unselectedTextStyle: unselectedTextStyle ?? this.unselectedTextStyle,
      disabledTextStyle: disabledTextStyle ?? this.disabledTextStyle,
      tabPadding: tabPadding ?? this.tabPadding,
      indicatorHeight: indicatorHeight ?? this.indicatorHeight,
      borderRadius: borderRadius ?? this.borderRadius,
      tabHeight: tabHeight ?? this.tabHeight,
      spacing: spacing ?? this.spacing,
    );
  }

  @override
  ZephyrTabsTheme lerp(ThemeExtension<ZephyrTabsTheme>? other, double t) {
    if (other is! ZephyrTabsTheme) return this;
    
    return ZephyrTabsTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ?? backgroundColor,
      indicatorColor: Color.lerp(indicatorColor, other.indicatorColor, t) ?? indicatorColor,
      selectedTabColor: Color.lerp(selectedTabColor, other.selectedTabColor, t) ?? selectedTabColor,
      unselectedTabColor: Color.lerp(unselectedTabColor, other.unselectedTabColor, t) ?? unselectedTabColor,
      disabledTabColor: Color.lerp(disabledTabColor, other.disabledTabColor, t) ?? disabledTabColor,
      borderColor: Color.lerp(borderColor, other.borderColor, t) ?? borderColor,
      selectedTextStyle: TextStyle.lerp(selectedTextStyle, other.selectedTextStyle, t) ?? selectedTextStyle,
      unselectedTextStyle: TextStyle.lerp(unselectedTextStyle, other.unselectedTextStyle, t) ?? unselectedTextStyle,
      disabledTextStyle: TextStyle.lerp(disabledTextStyle, other.disabledTextStyle, t) ?? disabledTextStyle,
      tabPadding: EdgeInsetsGeometry.lerp(tabPadding, other.tabPadding, t) ?? tabPadding,
      indicatorHeight: ui.lerpDouble(indicatorHeight, other.indicatorHeight, t) ?? indicatorHeight,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t) ?? borderRadius,
      tabHeight: ui.lerpDouble(tabHeight, other.tabHeight, t) ?? tabHeight,
      spacing: ui.lerpDouble(spacing, other.spacing, t) ?? spacing,
    );
  }
}

