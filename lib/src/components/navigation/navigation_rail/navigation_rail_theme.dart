/// ZephyrUI Navigation Rail Theme
/// 
/// Defines the theme configuration for navigation rail components.
library navigation_rail_theme;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI Navigation Rail Theme
class ZephyrNavigationRailTheme extends ThemeExtension<ZephyrNavigationRailTheme> {
  /// Creates a navigation rail theme
  const ZephyrNavigationRailTheme({
    required this.backgroundColor,
    required this.selectedColor,
    required this.unselectedColor,
    required this.selectedLabelStyle,
    required this.unselectedLabelStyle,
    required this.selectedIconSize,
    required this.unselectedIconSize,
    required this.itemHeight,
    required this.itemPadding,
    required this.itemBorderRadius,
    required this.labelSpacing,
    required this.indicatorColor,
    required this.leadingPadding,
    required this.trailingPadding,
    required this.toggleButtonSpacing,
  });

  /// Background color
  final Color backgroundColor;

  /// Selected item color
  final Color selectedColor;

  /// Unselected item color
  final Color unselectedColor;

  /// Selected label text style
  final TextStyle selectedLabelStyle;

  /// Unselected label text style
  final TextStyle unselectedLabelStyle;

  /// Selected icon size
  final double selectedIconSize;

  /// Unselected icon size
  final double unselectedIconSize;

  /// Item height
  final double itemHeight;

  /// Item padding
  final EdgeInsetsGeometry itemPadding;

  /// Item border radius
  final BorderRadius itemBorderRadius;

  /// Spacing between icon and label
  final double labelSpacing;

  /// Indicator color
  final Color indicatorColor;

  /// Leading widget padding
  final EdgeInsetsGeometry leadingPadding;

  /// Trailing widget padding
  final EdgeInsetsGeometry trailingPadding;

  /// Toggle button spacing
  final double toggleButtonSpacing;

  /// Get theme from context
  static ZephyrNavigationRailTheme of(BuildContext context) {
    final theme = Theme.of(context).extension<ZephyrNavigationRailTheme>();
    if (theme != null) return theme;
    
    final zephyrTheme = ZephyrTheme.of(context);
    return _createDefaultTheme(zephyrTheme);
  }

  /// Create default theme
  static ZephyrNavigationRailTheme _createDefaultTheme(ZephyrThemeData zephyrTheme) {
    final isDark = zephyrTheme.brightness == Brightness.dark;
    
    return ZephyrNavigationRailTheme(
      backgroundColor: isDark ? ZephyrColors.neutral900 : Colors.white,
      selectedColor: zephyrTheme.primaryColor,
      unselectedColor: isDark ? ZephyrColors.neutral400 : ZephyrColors.neutral600,
      selectedLabelStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize12,
        fontWeight: ZephyrTypography.fontWeightMedium,
        height: ZephyrTypography.lineHeight1_4,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize12,
        fontWeight: ZephyrTypography.fontWeightRegular,
        height: ZephyrTypography.lineHeight1_4,
      ),
      selectedIconSize: 24.0,
      unselectedIconSize: 24.0,
      itemHeight: 72.0,
      itemPadding: const EdgeInsets.symmetric(
        horizontal: ZephyrSpacing.md,
        vertical: ZephyrSpacing.sm,
      ),
      itemBorderRadius: BorderRadius.circular(ZephyrRadius.sm),
      labelSpacing: ZephyrSpacing.sm,
      indicatorColor: zephyrTheme.primaryColor.withValues(alpha: 0.12),
      leadingPadding: const EdgeInsets.all(ZephyrSpacing.md),
      trailingPadding: const EdgeInsets.all(ZephyrSpacing.md),
      toggleButtonSpacing: ZephyrSpacing.sm,
    );
  }

  @override
  ZephyrNavigationRailTheme copyWith({
    Color? backgroundColor,
    Color? selectedColor,
    Color? unselectedColor,
    TextStyle? selectedLabelStyle,
    TextStyle? unselectedLabelStyle,
    double? selectedIconSize,
    double? unselectedIconSize,
    double? itemHeight,
    EdgeInsetsGeometry? itemPadding,
    BorderRadius? itemBorderRadius,
    double? labelSpacing,
    Color? indicatorColor,
    EdgeInsetsGeometry? leadingPadding,
    EdgeInsetsGeometry? trailingPadding,
    double? toggleButtonSpacing,
  }) {
    return ZephyrNavigationRailTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      selectedColor: selectedColor ?? this.selectedColor,
      unselectedColor: unselectedColor ?? this.unselectedColor,
      selectedLabelStyle: selectedLabelStyle ?? this.selectedLabelStyle,
      unselectedLabelStyle: unselectedLabelStyle ?? this.unselectedLabelStyle,
      selectedIconSize: selectedIconSize ?? this.selectedIconSize,
      unselectedIconSize: unselectedIconSize ?? this.unselectedIconSize,
      itemHeight: itemHeight ?? this.itemHeight,
      itemPadding: itemPadding ?? this.itemPadding,
      itemBorderRadius: itemBorderRadius ?? this.itemBorderRadius,
      labelSpacing: labelSpacing ?? this.labelSpacing,
      indicatorColor: indicatorColor ?? this.indicatorColor,
      leadingPadding: leadingPadding ?? this.leadingPadding,
      trailingPadding: trailingPadding ?? this.trailingPadding,
      toggleButtonSpacing: toggleButtonSpacing ?? this.toggleButtonSpacing,
    );
  }

  @override
  ZephyrNavigationRailTheme lerp(ThemeExtension<ZephyrNavigationRailTheme>? other, double t) {
    if (other is! ZephyrNavigationRailTheme) return this;
    
    return ZephyrNavigationRailTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ?? backgroundColor,
      selectedColor: Color.lerp(selectedColor, other.selectedColor, t) ?? selectedColor,
      unselectedColor: Color.lerp(unselectedColor, other.unselectedColor, t) ?? unselectedColor,
      selectedLabelStyle: TextStyle.lerp(selectedLabelStyle, other.selectedLabelStyle, t) ?? selectedLabelStyle,
      unselectedLabelStyle: TextStyle.lerp(unselectedLabelStyle, other.unselectedLabelStyle, t) ?? unselectedLabelStyle,
      selectedIconSize: lerpDouble(selectedIconSize, other.selectedIconSize, t) ?? selectedIconSize,
      unselectedIconSize: lerpDouble(unselectedIconSize, other.unselectedIconSize, t) ?? unselectedIconSize,
      itemHeight: lerpDouble(itemHeight, other.itemHeight, t) ?? itemHeight,
      itemPadding: EdgeInsetsGeometry.lerp(itemPadding, other.itemPadding, t) ?? itemPadding,
      itemBorderRadius: BorderRadius.lerp(itemBorderRadius, other.itemBorderRadius, t) ?? itemBorderRadius,
      labelSpacing: lerpDouble(labelSpacing, other.labelSpacing, t) ?? labelSpacing,
      indicatorColor: Color.lerp(indicatorColor, other.indicatorColor, t) ?? indicatorColor,
      leadingPadding: EdgeInsetsGeometry.lerp(leadingPadding, other.leadingPadding, t) ?? leadingPadding,
      trailingPadding: EdgeInsetsGeometry.lerp(trailingPadding, other.trailingPadding, t) ?? trailingPadding,
      toggleButtonSpacing: lerpDouble(toggleButtonSpacing, other.toggleButtonSpacing, t) ?? toggleButtonSpacing,
    );
  }
}