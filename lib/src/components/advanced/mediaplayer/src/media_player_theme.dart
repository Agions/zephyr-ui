import 'package:flutter/material.dart';

/// ZephyrUI Media Player Theme Configuration
/// 
/// Provides styling options for media player components including colors,
/// fonts, and control styling.
class ZephyrMediaPlayerTheme {
  /// Primary color
  final Color primaryColor;
  
  /// Secondary color
  final Color secondaryColor;
  
  /// Background color
  final Color backgroundColor;
  
  /// Text color
  final Color textColor;
  
  /// Secondary text color
  final Color secondaryTextColor;
  
  /// Control color
  final Color controlColor;
  
  /// Inactive control color
  final Color inactiveControlColor;
  
  /// Progress bar color
  final Color progressBarColor;
  
  /// Buffer bar color
  final Color bufferBarColor;
  
  /// Button background color
  final Color buttonBackgroundColor;
  
  /// Button text color
  final Color buttonTextColor;
  
  /// Button icon color
  final Color buttonIconColor;
  
  /// Disabled button icon color
  final Color disabledButtonIconColor;
  
  /// Success color for notifications
  final Color successColor;
  
  /// Error color for notifications
  final Color errorColor;

  /// Creates a light theme
  const ZephyrMediaPlayerTheme.light()
      : primaryColor = const Color(0xFF3B82F6),
        secondaryColor = const Color(0xFF6B7280),
        backgroundColor = const Color(0xFFF9FAFB),
        textColor = const Color(0xFF1F2937),
        secondaryTextColor = const Color(0xFF6B7280),
        controlColor = Colors.white,
        inactiveControlColor = const Color(0x99FFFFFF),
        progressBarColor = const Color(0xFF3B82F6),
        bufferBarColor = const Color(0xFFE5E7EB),
        buttonBackgroundColor = const Color(0xFF3B82F6),
        buttonTextColor = Colors.white,
        buttonIconColor = Colors.white,
        disabledButtonIconColor = const Color(0xFFD1D5DB),
        successColor = const Color(0xFF10B981),
        errorColor = const Color(0xFFEF4444);

  /// Creates a dark theme
  const ZephyrMediaPlayerTheme.dark()
      : primaryColor = const Color(0xFF60A5FA),
        secondaryColor = const Color(0xFF9CA3AF),
        backgroundColor = const Color(0xFF111827),
        textColor = const Color(0xFFF9FAFB),
        secondaryTextColor = const Color(0xFF9CA3AF),
        controlColor = const Color(0xFFF9FAFB),
        inactiveControlColor = const Color(0x99F9FAFB),
        progressBarColor = const Color(0xFF60A5FA),
        bufferBarColor = const Color(0xFF374151),
        buttonBackgroundColor = const Color(0xFF60A5FA),
        buttonTextColor = Colors.white,
        buttonIconColor = Colors.white,
        disabledButtonIconColor = const Color(0xFF4B5563),
        successColor = const Color(0xFF34D399),
        errorColor = const Color(0xFFF87171);

  /// Creates a custom theme
  const ZephyrMediaPlayerTheme({
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.textColor,
    required this.secondaryTextColor,
    required this.controlColor,
    required this.inactiveControlColor,
    required this.progressBarColor,
    required this.bufferBarColor,
    required this.buttonBackgroundColor,
    required this.buttonTextColor,
    required this.buttonIconColor,
    required this.disabledButtonIconColor,
    required this.successColor,
    required this.errorColor,
  });

  /// Gets theme from context
  static ZephyrMediaPlayerTheme of(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark 
        ? const ZephyrMediaPlayerTheme.dark() 
        : const ZephyrMediaPlayerTheme.light();
  }

  /// Creates a copy of the theme with specified properties
  ZephyrMediaPlayerTheme copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? backgroundColor,
    Color? textColor,
    Color? secondaryTextColor,
    Color? controlColor,
    Color? inactiveControlColor,
    Color? progressBarColor,
    Color? bufferBarColor,
    Color? buttonBackgroundColor,
    Color? buttonTextColor,
    Color? buttonIconColor,
    Color? disabledButtonIconColor,
    Color? successColor,
    Color? errorColor,
  }) {
    return ZephyrMediaPlayerTheme(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      controlColor: controlColor ?? this.controlColor,
      inactiveControlColor: inactiveControlColor ?? this.inactiveControlColor,
      progressBarColor: progressBarColor ?? this.progressBarColor,
      bufferBarColor: bufferBarColor ?? this.bufferBarColor,
      buttonBackgroundColor: buttonBackgroundColor ?? this.buttonBackgroundColor,
      buttonTextColor: buttonTextColor ?? this.buttonTextColor,
      buttonIconColor: buttonIconColor ?? this.buttonIconColor,
      disabledButtonIconColor: disabledButtonIconColor ?? this.disabledButtonIconColor,
      successColor: successColor ?? this.successColor,
      errorColor: errorColor ?? this.errorColor,
    );
  }

  /// Merges with another theme
  ZephyrMediaPlayerTheme merge(ZephyrMediaPlayerTheme other) {
    return copyWith(
      primaryColor: other.primaryColor,
      secondaryColor: other.secondaryColor,
      backgroundColor: other.backgroundColor,
      textColor: other.textColor,
      secondaryTextColor: other.secondaryTextColor,
      controlColor: other.controlColor,
      inactiveControlColor: other.inactiveControlColor,
      progressBarColor: other.progressBarColor,
      bufferBarColor: other.bufferBarColor,
      buttonBackgroundColor: other.buttonBackgroundColor,
      buttonTextColor: other.buttonTextColor,
      buttonIconColor: other.buttonIconColor,
      disabledButtonIconColor: other.disabledButtonIconColor,
      successColor: other.successColor,
      errorColor: other.errorColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ZephyrMediaPlayerTheme &&
        other.primaryColor == primaryColor &&
        other.secondaryColor == secondaryColor &&
        other.backgroundColor == backgroundColor &&
        other.textColor == textColor &&
        other.secondaryTextColor == secondaryTextColor &&
        other.controlColor == controlColor &&
        other.inactiveControlColor == inactiveControlColor &&
        other.progressBarColor == progressBarColor &&
        other.bufferBarColor == bufferBarColor &&
        other.buttonBackgroundColor == buttonBackgroundColor &&
        other.buttonTextColor == buttonTextColor &&
        other.buttonIconColor == buttonIconColor &&
        other.disabledButtonIconColor == disabledButtonIconColor &&
        other.successColor == successColor &&
        other.errorColor == errorColor;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      primaryColor,
      secondaryColor,
      backgroundColor,
      textColor,
      secondaryTextColor,
      controlColor,
      inactiveControlColor,
      progressBarColor,
      bufferBarColor,
      buttonBackgroundColor,
      buttonTextColor,
      buttonIconColor,
      disabledButtonIconColor,
      successColor,
      errorColor,
    ]);
  }
}