/// ZephyrUI Rating Theme
/// 
/// Defines the theme configuration for rating components.
library rating_theme;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI Rating Theme
class ZephyrRatingTheme {
  /// Creates a rating theme
  const ZephyrRatingTheme({
    this.selectedColor = const Color(0xFFFFC107),
    this.unselectedColor = const Color(0xFFE0E0E0),
    this.hoverColor = const Color(0xFFFFD54F),
    this.disabledColor = const Color(0xFFBDBDBD),
    this.selectedIcon = Icons.star,
    this.unselectedIcon = Icons.star_border,
    this.labelStyle = const TextStyle(
      fontSize: 12,
      color: Colors.black54,
    ),
  });

  /// Color for selected rating items
  final Color selectedColor;

  /// Color for unselected rating items
  final Color unselectedColor;

  /// Color for hover state
  final Color hoverColor;

  /// Color for disabled state
  final Color disabledColor;

  /// Icon for selected rating items
  final IconData selectedIcon;

  /// Icon for unselected rating items
  final IconData unselectedIcon;

  /// Style for rating labels
  final TextStyle labelStyle;

  /// Get theme from context
  static ZephyrRatingTheme of(BuildContext context) {
    return ZephyrTheme.of(context).ratingTheme ?? const ZephyrRatingTheme();
  }

  /// Create light theme
  static ZephyrRatingTheme light() {
    return const ZephyrRatingTheme(
      selectedColor: Color(0xFFFFC107),
      unselectedColor: Color(0xFFE0E0E0),
      hoverColor: Color(0xFFFFD54F),
      disabledColor: Color(0xFFBDBDBD),
      labelStyle: TextStyle(
        fontSize: 12,
        color: Colors.black54,
      ),
    );
  }

  /// Create dark theme
  static ZephyrRatingTheme dark() {
    return const ZephyrRatingTheme(
      selectedColor: Color(0xFFFFC107),
      unselectedColor: Color(0xFF424242),
      hoverColor: Color(0xFFFFD54F),
      disabledColor: Color(0xFF616161),
      labelStyle: TextStyle(
        fontSize: 12,
        color: Colors.white70,
      ),
    );
  }

  /// Copy theme with modifications
  ZephyrRatingTheme copyWith({
    Color? selectedColor,
    Color? unselectedColor,
    Color? hoverColor,
    Color? disabledColor,
    IconData? selectedIcon,
    IconData? unselectedIcon,
    TextStyle? labelStyle,
  }) {
    return ZephyrRatingTheme(
      selectedColor: selectedColor ?? this.selectedColor,
      unselectedColor: unselectedColor ?? this.unselectedColor,
      hoverColor: hoverColor ?? this.hoverColor,
      disabledColor: disabledColor ?? this.disabledColor,
      selectedIcon: selectedIcon ?? this.selectedIcon,
      unselectedIcon: unselectedIcon ?? this.unselectedIcon,
      labelStyle: labelStyle ?? this.labelStyle,
    );
  }
}