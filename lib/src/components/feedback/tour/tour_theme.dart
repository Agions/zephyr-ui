/// ZephyrUI Tour Theme
/// 
/// Defines the theme configuration for tour components.
library tour_theme;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI Tour Theme
class ZephyrTourTheme {
  /// Creates a tour theme
  const ZephyrTourTheme({
    this.elevation = 8,
    this.borderRadius = 8,
    this.headerColor = const Color(0xFF2196F3),
    this.backgroundColor = Colors.white,
    this.progressColor = const Color(0xFF2196F3),
    this.progressBackgroundColor = const Color(0xFFE0E0E0),
    this.titleStyle = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    this.contentStyle = const TextStyle(
      fontSize: 14,
      color: Colors.black87,
    ),
    this.stepNumberStyle = const TextStyle(
      fontSize: 12,
      color: Colors.white70,
    ),
    this.buttonStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    this.headerPadding = const EdgeInsets.all(16),
    this.contentPadding = const EdgeInsets.all(16),
    this.progressPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.actionPadding = const EdgeInsets.all(16),
    this.nextButtonText = 'Next',
    this.previousButtonText = 'Previous',
    this.skipButtonText = 'Skip',
    this.completeButtonText = 'Complete',
  });

  /// Card elevation
  final double elevation;

  /// Border radius
  final double borderRadius;

  /// Header background color
  final Color headerColor;

  /// Tooltip background color
  final Color backgroundColor;

  /// Progress bar color
  final Color progressColor;

  /// Progress bar background color
  final Color progressBackgroundColor;

  /// Title text style
  final TextStyle titleStyle;

  /// Content text style
  final TextStyle contentStyle;

  /// Step number text style
  final TextStyle stepNumberStyle;

  /// Button text style
  final TextStyle buttonStyle;

  /// Header padding
  final EdgeInsets headerPadding;

  /// Content padding
  final EdgeInsets contentPadding;

  /// Progress padding
  final EdgeInsets progressPadding;

  /// Action padding
  final EdgeInsets actionPadding;

  /// Next button text
  final String nextButtonText;

  /// Previous button text
  final String previousButtonText;

  /// Skip button text
  final String skipButtonText;

  /// Complete button text
  final String completeButtonText;

  /// Get theme from context
  static ZephyrTourTheme of(BuildContext context) {
    return ZephyrTheme.of(context).tourTheme ?? const ZephyrTourTheme();
  }

  /// Create light theme
  static ZephyrTourTheme light() {
    return const ZephyrTourTheme(
      elevation: 8,
      borderRadius: 8,
      headerColor: Color(0xFF2196F3),
      backgroundColor: Colors.white,
      progressColor: Color(0xFF2196F3),
      progressBackgroundColor: Color(0xFFE0E0E0),
      titleStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      contentStyle: TextStyle(
        fontSize: 14,
        color: Colors.black87,
      ),
      stepNumberStyle: TextStyle(
        fontSize: 12,
        color: Colors.white70,
      ),
      buttonStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      headerPadding: EdgeInsets.all(16),
      contentPadding: EdgeInsets.all(16),
      progressPadding: EdgeInsets.symmetric(horizontal: 16),
      actionPadding: EdgeInsets.all(16),
      nextButtonText: 'Next',
      previousButtonText: 'Previous',
      skipButtonText: 'Skip',
      completeButtonText: 'Complete',
    );
  }

  /// Create dark theme
  static ZephyrTourTheme dark() {
    return const ZephyrTourTheme(
      elevation: 8,
      borderRadius: 8,
      headerColor: Color(0xFF1976D2),
      backgroundColor: Color(0xFF1E1E1E),
      progressColor: Color(0xFF64B5F6),
      progressBackgroundColor: Color(0xFF424242),
      titleStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      contentStyle: TextStyle(
        fontSize: 14,
        color: Colors.white70,
      ),
      stepNumberStyle: TextStyle(
        fontSize: 12,
        color: Colors.white54,
      ),
      buttonStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      headerPadding: EdgeInsets.all(16),
      contentPadding: EdgeInsets.all(16),
      progressPadding: EdgeInsets.symmetric(horizontal: 16),
      actionPadding: EdgeInsets.all(16),
      nextButtonText: 'Next',
      previousButtonText: 'Previous',
      skipButtonText: 'Skip',
      completeButtonText: 'Complete',
    );
  }

  /// Copy theme with modifications
  ZephyrTourTheme copyWith({
    double? elevation,
    double? borderRadius,
    Color? headerColor,
    Color? backgroundColor,
    Color? progressColor,
    Color? progressBackgroundColor,
    TextStyle? titleStyle,
    TextStyle? contentStyle,
    TextStyle? stepNumberStyle,
    TextStyle? buttonStyle,
    EdgeInsets? headerPadding,
    EdgeInsets? contentPadding,
    EdgeInsets? progressPadding,
    EdgeInsets? actionPadding,
    String? nextButtonText,
    String? previousButtonText,
    String? skipButtonText,
    String? completeButtonText,
  }) {
    return ZephyrTourTheme(
      elevation: elevation ?? this.elevation,
      borderRadius: borderRadius ?? this.borderRadius,
      headerColor: headerColor ?? this.headerColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      progressColor: progressColor ?? this.progressColor,
      progressBackgroundColor: progressBackgroundColor ?? this.progressBackgroundColor,
      titleStyle: titleStyle ?? this.titleStyle,
      contentStyle: contentStyle ?? this.contentStyle,
      stepNumberStyle: stepNumberStyle ?? this.stepNumberStyle,
      buttonStyle: buttonStyle ?? this.buttonStyle,
      headerPadding: headerPadding ?? this.headerPadding,
      contentPadding: contentPadding ?? this.contentPadding,
      progressPadding: progressPadding ?? this.progressPadding,
      actionPadding: actionPadding ?? this.actionPadding,
      nextButtonText: nextButtonText ?? this.nextButtonText,
      previousButtonText: previousButtonText ?? this.previousButtonText,
      skipButtonText: skipButtonText ?? this.skipButtonText,
      completeButtonText: completeButtonText ?? this.completeButtonText,
    );
  }
}