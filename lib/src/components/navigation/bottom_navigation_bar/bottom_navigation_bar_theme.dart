/// ZephyrUI Bottom Navigation Bar Theme
/// 
/// Defines the theme configuration for bottom navigation bar components.
library bottom_navigation_bar_theme;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI Bottom Navigation Bar Theme
class ZephyrBottomNavigationBarTheme extends ThemeExtension<ZephyrBottomNavigationBarTheme> {
  /// Creates a bottom navigation bar theme
  const ZephyrBottomNavigationBarTheme({
    required this.backgroundColor,
    required this.selectedColor,
    required this.unselectedColor,
    required this.selectedLabelStyle,
    required this.unselectedLabelStyle,
    required this.selectedIconSize,
    required this.unselectedIconSize,
    required this.itemBorderRadius,
    required this.itemPaddingVertical,
    required this.itemPaddingHorizontal,
    required this.labelSpacing,
    required this.unselectedDotColor,
    required this.dotIndicatorSpacing,
    required this.dotIndicatorBottomSpacing,
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

  /// Item border radius
  final double itemBorderRadius;

  /// Item vertical padding
  final double itemPaddingVertical;

  /// Item horizontal padding
  final double itemPaddingHorizontal;

  /// Spacing between icon and label
  final double labelSpacing;

  /// Unselected dot indicator color
  final Color unselectedDotColor;

  /// Spacing above dot indicator
  final double dotIndicatorSpacing;

  /// Spacing below dot indicator
  final double dotIndicatorBottomSpacing;

  /// Get theme from context
  static ZephyrBottomNavigationBarTheme of(BuildContext context) {
    final theme = Theme.of(context).extension<ZephyrBottomNavigationBarTheme>();
    if (theme != null) return theme;
    
    final zephyrTheme = ZephyrTheme.of(context);
    return _createDefaultTheme(zephyrTheme);
  }

  /// Create default theme
  static ZephyrBottomNavigationBarTheme _createDefaultTheme(ZephyrThemeData zephyrTheme) {
    final isDark = zephyrTheme.brightness == Brightness.dark;
    
    return ZephyrBottomNavigationBarTheme(
      backgroundColor: isDark ? ZephyrColors.neutral900 : Colors.white,
      selectedColor: zephyrTheme.primaryColor,
      unselectedColor: isDark ? ZephyrColors.neutral400 : ZephyrColors.neutral500,
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
      itemBorderRadius: ZephyrRadius.sm,
      itemPaddingVertical: ZephyrSpacing.sm,
      itemPaddingHorizontal: ZephyrSpacing.md,
      labelSpacing: ZephyrSpacing.xs,
      unselectedDotColor: isDark ? ZephyrColors.neutral600 : ZephyrColors.neutral300,
      dotIndicatorSpacing: ZephyrSpacing.sm,
      dotIndicatorBottomSpacing: ZephyrSpacing.sm,
    );
  }

  @override
  ZephyrBottomNavigationBarTheme copyWith({
    Color? backgroundColor,
    Color? selectedColor,
    Color? unselectedColor,
    TextStyle? selectedLabelStyle,
    TextStyle? unselectedLabelStyle,
    double? selectedIconSize,
    double? unselectedIconSize,
    double? itemBorderRadius,
    double? itemPaddingVertical,
    double? itemPaddingHorizontal,
    double? labelSpacing,
    Color? unselectedDotColor,
    double? dotIndicatorSpacing,
    double? dotIndicatorBottomSpacing,
  }) {
    return ZephyrBottomNavigationBarTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      selectedColor: selectedColor ?? this.selectedColor,
      unselectedColor: unselectedColor ?? this.unselectedColor,
      selectedLabelStyle: selectedLabelStyle ?? this.selectedLabelStyle,
      unselectedLabelStyle: unselectedLabelStyle ?? this.unselectedLabelStyle,
      selectedIconSize: selectedIconSize ?? this.selectedIconSize,
      unselectedIconSize: unselectedIconSize ?? this.unselectedIconSize,
      itemBorderRadius: itemBorderRadius ?? this.itemBorderRadius,
      itemPaddingVertical: itemPaddingVertical ?? this.itemPaddingVertical,
      itemPaddingHorizontal: itemPaddingHorizontal ?? this.itemPaddingHorizontal,
      labelSpacing: labelSpacing ?? this.labelSpacing,
      unselectedDotColor: unselectedDotColor ?? this.unselectedDotColor,
      dotIndicatorSpacing: dotIndicatorSpacing ?? this.dotIndicatorSpacing,
      dotIndicatorBottomSpacing: dotIndicatorBottomSpacing ?? this.dotIndicatorBottomSpacing,
    );
  }

  @override
  ZephyrBottomNavigationBarTheme lerp(ThemeExtension<ZephyrBottomNavigationBarTheme>? other, double t) {
    if (other is! ZephyrBottomNavigationBarTheme) return this;
    
    return ZephyrBottomNavigationBarTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ?? backgroundColor,
      selectedColor: Color.lerp(selectedColor, other.selectedColor, t) ?? selectedColor,
      unselectedColor: Color.lerp(unselectedColor, other.unselectedColor, t) ?? unselectedColor,
      selectedLabelStyle: TextStyle.lerp(selectedLabelStyle, other.selectedLabelStyle, t) ?? selectedLabelStyle,
      unselectedLabelStyle: TextStyle.lerp(unselectedLabelStyle, other.unselectedLabelStyle, t) ?? unselectedLabelStyle,
      selectedIconSize: lerpDouble(selectedIconSize, other.selectedIconSize, t) ?? selectedIconSize,
      unselectedIconSize: lerpDouble(unselectedIconSize, other.unselectedIconSize, t) ?? unselectedIconSize,
      itemBorderRadius: lerpDouble(itemBorderRadius, other.itemBorderRadius, t) ?? itemBorderRadius,
      itemPaddingVertical: lerpDouble(itemPaddingVertical, other.itemPaddingVertical, t) ?? itemPaddingVertical,
      itemPaddingHorizontal: lerpDouble(itemPaddingHorizontal, other.itemPaddingHorizontal, t) ?? itemPaddingHorizontal,
      labelSpacing: lerpDouble(labelSpacing, other.labelSpacing, t) ?? labelSpacing,
      unselectedDotColor: Color.lerp(unselectedDotColor, other.unselectedDotColor, t) ?? unselectedDotColor,
      dotIndicatorSpacing: lerpDouble(dotIndicatorSpacing, other.dotIndicatorSpacing, t) ?? dotIndicatorSpacing,
      dotIndicatorBottomSpacing: lerpDouble(dotIndicatorBottomSpacing, other.dotIndicatorBottomSpacing, t) ?? dotIndicatorBottomSpacing,
    );
  }
}