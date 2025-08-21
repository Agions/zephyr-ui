/// ZephyrUI Breadcrumb Theme
/// 
/// Defines the theme configuration for breadcrumb components.
library breadcrumb_theme;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI Breadcrumb Theme
class ZephyrBreadcrumbTheme extends ThemeExtension<ZephyrBreadcrumbTheme> {
  /// Creates a breadcrumb theme
  const ZephyrBreadcrumbTheme({
    required this.itemStyle,
    required this.currentItemStyle,
    required this.disabledItemStyle,
    required this.separatorStyle,
    required this.separatorIconSize,
    required this.itemPadding,
    required this.itemBorderRadius,
    required this.currentItemBackgroundColor,
  });

  /// Style for regular items
  final TextStyle itemStyle;

  /// Style for current item
  final TextStyle currentItemStyle;

  /// Style for disabled items
  final TextStyle disabledItemStyle;

  /// Style for separators
  final TextStyle separatorStyle;

  /// Size of separator icons
  final double separatorIconSize;

  /// Padding for items
  final EdgeInsetsGeometry itemPadding;

  /// Border radius for items
  final BorderRadius itemBorderRadius;

  /// Background color for current item
  final Color currentItemBackgroundColor;

  /// Get theme from context
  static ZephyrBreadcrumbTheme of(BuildContext context) {
    final theme = Theme.of(context).extension<ZephyrBreadcrumbTheme>();
    if (theme != null) return theme;
    
    final zephyrTheme = ZephyrTheme.of(context);
    return _createDefaultTheme(zephyrTheme);
  }

  /// Create default theme
  static ZephyrBreadcrumbTheme _createDefaultTheme(ZephyrThemeData zephyrTheme) {
    final isDark = zephyrTheme.brightness == Brightness.dark;
    
    return ZephyrBreadcrumbTheme(
      itemStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: isDark ? ZephyrColors.neutral300 : ZephyrColors.neutral600,
        height: ZephyrTypography.lineHeight1_4,
      ),
      currentItemStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightMedium,
        color: isDark ? ZephyrColors.neutral100 : ZephyrColors.neutral900,
        height: ZephyrTypography.lineHeight1_4,
      ),
      disabledItemStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: isDark ? ZephyrColors.neutral500 : ZephyrColors.neutral400,
        height: ZephyrTypography.lineHeight1_4,
      ),
      separatorStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: isDark ? ZephyrColors.neutral500 : ZephyrColors.neutral400,
      ),
      separatorIconSize: 16.0,
      itemPadding: const EdgeInsets.symmetric(
        horizontal: ZephyrSpacing.sm,
        vertical: ZephyrSpacing.xs,
      ),
      itemBorderRadius: BorderRadius.circular(ZephyrRadius.sm),
      currentItemBackgroundColor: isDark 
          ? ZephyrColors.neutral800.withValues(alpha: 0.5)
          : ZephyrColors.neutral100.withValues(alpha: 0.5),
    );
  }

  @override
  ZephyrBreadcrumbTheme copyWith({
    TextStyle? itemStyle,
    TextStyle? currentItemStyle,
    TextStyle? disabledItemStyle,
    TextStyle? separatorStyle,
    double? separatorIconSize,
    EdgeInsetsGeometry? itemPadding,
    BorderRadius? itemBorderRadius,
    Color? currentItemBackgroundColor,
  }) {
    return ZephyrBreadcrumbTheme(
      itemStyle: itemStyle ?? this.itemStyle,
      currentItemStyle: currentItemStyle ?? this.currentItemStyle,
      disabledItemStyle: disabledItemStyle ?? this.disabledItemStyle,
      separatorStyle: separatorStyle ?? this.separatorStyle,
      separatorIconSize: separatorIconSize ?? this.separatorIconSize,
      itemPadding: itemPadding ?? this.itemPadding,
      itemBorderRadius: itemBorderRadius ?? this.itemBorderRadius,
      currentItemBackgroundColor: currentItemBackgroundColor ?? this.currentItemBackgroundColor,
    );
  }

  @override
  ZephyrBreadcrumbTheme lerp(ThemeExtension<ZephyrBreadcrumbTheme>? other, double t) {
    if (other is! ZephyrBreadcrumbTheme) return this;
    
    return ZephyrBreadcrumbTheme(
      itemStyle: TextStyle.lerp(itemStyle, other.itemStyle, t) ?? itemStyle,
      currentItemStyle: TextStyle.lerp(currentItemStyle, other.currentItemStyle, t) ?? currentItemStyle,
      disabledItemStyle: TextStyle.lerp(disabledItemStyle, other.disabledItemStyle, t) ?? disabledItemStyle,
      separatorStyle: TextStyle.lerp(separatorStyle, other.separatorStyle, t) ?? separatorStyle,
      separatorIconSize: lerpDouble(separatorIconSize, other.separatorIconSize, t) ?? separatorIconSize,
      itemPadding: EdgeInsetsGeometry.lerp(itemPadding, other.itemPadding, t) ?? itemPadding,
      itemBorderRadius: BorderRadius.lerp(itemBorderRadius, other.itemBorderRadius, t) ?? itemBorderRadius,
      currentItemBackgroundColor: Color.lerp(currentItemBackgroundColor, other.currentItemBackgroundColor, t) ?? currentItemBackgroundColor,
    );
  }
}