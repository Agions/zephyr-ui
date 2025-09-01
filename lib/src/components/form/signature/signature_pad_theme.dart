import 'package:flutter/material.dart';

/// ZephyrUI Signature Pad Theme Configuration
/// 
/// Provides styling options for signature pad components including colors,
/// borders, and button styling.
class ZephyrSignaturePadTheme {
  /// Pen color
  final Color penColor;
  
  /// Background color
  final Color backgroundColor;
  
  /// Border color
  final Color borderColor;
  
  /// Border width
  final double borderWidth;
  
  /// Border radius
  final BorderRadius borderRadius;
  
  /// Placeholder color
  final Color placeholderColor;
  
  /// Button icon color
  final Color buttonIconColor;
  
  /// Disabled button icon color
  final Color disabledButtonIconColor;
  
  /// Success color for notifications
  final Color successColor;
  
  /// Error color for notifications
  final Color errorColor;

  /// Creates a light theme
  const ZephyrSignaturePadTheme.light()
      : penColor = Colors.black,
        backgroundColor = Colors.white,
        borderColor = const Color(0xFFE5E7EB),
        borderWidth = 1.0,
        borderRadius = const BorderRadius.all(Radius.circular(8)),
        placeholderColor = const Color(0xFF9CA3AF),
        buttonIconColor = const Color(0xFF374151),
        disabledButtonIconColor = const Color(0xFFD1D5DB),
        successColor = const Color(0xFF10B981),
        errorColor = const Color(0xFFEF4444);

  /// Creates a dark theme
  const ZephyrSignaturePadTheme.dark()
      : penColor = Colors.white,
        backgroundColor = const Color(0xFF1F2937),
        borderColor = const Color(0xFF374151),
        borderWidth = 1.0,
        borderRadius = const BorderRadius.all(Radius.circular(8)),
        placeholderColor = const Color(0xFF6B7280),
        buttonIconColor = const Color(0xFFF9FAFB),
        disabledButtonIconColor = const Color(0xFF4B5563),
        successColor = const Color(0xFF34D399),
        errorColor = const Color(0xFFF87171);

  /// Creates a custom theme
  const ZephyrSignaturePadTheme({
    required this.penColor,
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.placeholderColor,
    required this.buttonIconColor,
    required this.disabledButtonIconColor,
    required this.successColor,
    required this.errorColor,
  });

  /// Gets theme from context
  static ZephyrSignaturePadTheme of(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark 
        ? const ZephyrSignaturePadTheme.dark() 
        : const ZephyrSignaturePadTheme.light();
  }

  /// Creates a copy of the theme with specified properties
  ZephyrSignaturePadTheme copyWith({
    Color? penColor,
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    BorderRadius? borderRadius,
    Color? placeholderColor,
    Color? buttonIconColor,
    Color? disabledButtonIconColor,
    Color? successColor,
    Color? errorColor,
  }) {
    return ZephyrSignaturePadTheme(
      penColor: penColor ?? this.penColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      placeholderColor: placeholderColor ?? this.placeholderColor,
      buttonIconColor: buttonIconColor ?? this.buttonIconColor,
      disabledButtonIconColor: disabledButtonIconColor ?? this.disabledButtonIconColor,
      successColor: successColor ?? this.successColor,
      errorColor: errorColor ?? this.errorColor,
    );
  }

  /// Merges with another theme
  ZephyrSignaturePadTheme merge(ZephyrSignaturePadTheme other) {
    return copyWith(
      penColor: other.penColor,
      backgroundColor: other.backgroundColor,
      borderColor: other.borderColor,
      borderWidth: other.borderWidth,
      borderRadius: other.borderRadius,
      placeholderColor: other.placeholderColor,
      buttonIconColor: other.buttonIconColor,
      disabledButtonIconColor: other.disabledButtonIconColor,
      successColor: other.successColor,
      errorColor: other.errorColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ZephyrSignaturePadTheme &&
        other.penColor == penColor &&
        other.backgroundColor == backgroundColor &&
        other.borderColor == borderColor &&
        other.borderWidth == borderWidth &&
        other.borderRadius == borderRadius &&
        other.placeholderColor == placeholderColor &&
        other.buttonIconColor == buttonIconColor &&
        other.disabledButtonIconColor == disabledButtonIconColor &&
        other.successColor == successColor &&
        other.errorColor == errorColor;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      penColor,
      backgroundColor,
      borderColor,
      borderWidth,
      borderRadius,
      placeholderColor,
      buttonIconColor,
      disabledButtonIconColor,
      successColor,
      errorColor,
    ]);
  }
}