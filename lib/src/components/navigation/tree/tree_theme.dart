/// ZephyrUI Tree Theme
/// 
/// Defines the theme configuration for tree components.
library tree_theme;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI Tree Theme
class ZephyrTreeTheme {
  /// Creates a tree theme
  const ZephyrTreeTheme({
    this.backgroundColor = Colors.transparent,
    this.selectedColor = const Color(0xFF2196F3),
    this.highlightColor = const Color(0xFFFFC107),
    this.iconColor = const Color(0xFF616161),
    this.expandCollapseColor = const Color(0xFF9E9E9E),
    this.textColor = const Color(0xFF212121),
    this.selectedTextColor = const Color(0xFF1976D2),
    this.disabledTextColor = const Color(0xFFBDBDBD),
    this.badgeColor = const Color(0xFFFF5722),
    this.badgeTextColor = Colors.white,
    this.textStyle = const TextStyle(
      fontSize: 14,
      color: Color(0xFF212121),
    ),
    this.selectedTextStyle = const TextStyle(
      fontSize: 14,
      color: Color(0xFF1976D2),
      fontWeight: FontWeight.w500,
    ),
    this.disabledTextStyle = const TextStyle(
      fontSize: 14,
      color: Color(0xFFBDBDBD),
    ),
    this.badgeTextStyle = const TextStyle(
      fontSize: 10,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
  });

  /// Background color
  final Color backgroundColor;

  /// Selected item color
  final Color selectedColor;

  /// Highlight color for search results
  final Color highlightColor;

  /// Icon color
  final Color iconColor;

  /// Expand/collapse button color
  final Color expandCollapseColor;

  /// Text color
  final Color textColor;

  /// Selected text color
  final Color selectedTextColor;

  /// Disabled text color
  final Color disabledTextColor;

  /// Badge background color
  final Color badgeColor;

  /// Badge text color
  final Color badgeTextColor;

  /// Text style
  final TextStyle textStyle;

  /// Selected text style
  final TextStyle selectedTextStyle;

  /// Disabled text style
  final TextStyle disabledTextStyle;

  /// Badge text style
  final TextStyle badgeTextStyle;

  /// Get theme from context
  static ZephyrTreeTheme of(BuildContext context) {
    return ZephyrTheme.of(context).treeTheme ?? const ZephyrTreeTheme();
  }

  /// Create light theme
  static ZephyrTreeTheme light() {
    return const ZephyrTreeTheme(
      backgroundColor: Colors.transparent,
      selectedColor: Color(0xFF2196F3),
      highlightColor: Color(0xFFFFC107),
      iconColor: Color(0xFF616161),
      expandCollapseColor: Color(0xFF9E9E9E),
      textColor: Color(0xFF212121),
      selectedTextColor: Color(0xFF1976D2),
      disabledTextColor: Color(0xFFBDBDBD),
      badgeColor: Color(0xFFFF5722),
      badgeTextColor: Colors.white,
    );
  }

  /// Create dark theme
  static ZephyrTreeTheme dark() {
    return const ZephyrTreeTheme(
      backgroundColor: Colors.transparent,
      selectedColor: Color(0xFF64B5F6),
      highlightColor: Color(0xFFFFD54F),
      iconColor: Color(0xFFE0E0E0),
      expandCollapseColor: Color(0xFFBDBDBD),
      textColor: Color(0xFFE0E0E0),
      selectedTextColor: Color(0xFF90CAF9),
      disabledTextColor: Color(0xFF616161),
      badgeColor: Color(0xFFFF7043),
      badgeTextColor: Colors.white,
      textStyle: TextStyle(
        fontSize: 14,
        color: Color(0xFFE0E0E0),
      ),
      selectedTextStyle: TextStyle(
        fontSize: 14,
        color: Color(0xFF90CAF9),
        fontWeight: FontWeight.w500,
      ),
      disabledTextStyle: TextStyle(
        fontSize: 14,
        color: Color(0xFF616161),
      ),
    );
  }

  /// Copy theme with modifications
  ZephyrTreeTheme copyWith({
    Color? backgroundColor,
    Color? selectedColor,
    Color? highlightColor,
    Color? iconColor,
    Color? expandCollapseColor,
    Color? textColor,
    Color? selectedTextColor,
    Color? disabledTextColor,
    Color? badgeColor,
    Color? badgeTextColor,
    TextStyle? textStyle,
    TextStyle? selectedTextStyle,
    TextStyle? disabledTextStyle,
    TextStyle? badgeTextStyle,
  }) {
    return ZephyrTreeTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      selectedColor: selectedColor ?? this.selectedColor,
      highlightColor: highlightColor ?? this.highlightColor,
      iconColor: iconColor ?? this.iconColor,
      expandCollapseColor: expandCollapseColor ?? this.expandCollapseColor,
      textColor: textColor ?? this.textColor,
      selectedTextColor: selectedTextColor ?? this.selectedTextColor,
      disabledTextColor: disabledTextColor ?? this.disabledTextColor,
      badgeColor: badgeColor ?? this.badgeColor,
      badgeTextColor: badgeTextColor ?? this.badgeTextColor,
      textStyle: textStyle ?? this.textStyle,
      selectedTextStyle: selectedTextStyle ?? this.selectedTextStyle,
      disabledTextStyle: disabledTextStyle ?? this.disabledTextStyle,
      badgeTextStyle: badgeTextStyle ?? this.badgeTextStyle,
    );
  }
}