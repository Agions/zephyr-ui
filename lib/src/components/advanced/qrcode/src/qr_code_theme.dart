import 'package:flutter/material.dart';

/// ZephyrUI QR Code Theme Configuration
/// 
/// Provides styling options for QR code components including colors,
/// borders, and export button styling.
class ZephyrQRCodeTheme {
  /// Foreground color
  final Color foregroundColor;
  
  /// Background color
  final Color backgroundColor;
  
  /// Border color
  final Color borderColor;
  
  /// Border width
  final double borderWidth;
  
  /// Border radius
  final BorderRadius borderRadius;
  
  /// Padding
  final EdgeInsets padding;
  
  /// Export button background color
  final Color exportButtonBackgroundColor;
  
  /// Export button text color
  final Color exportButtonTextColor;
  
  /// Export button icon color
  final Color exportButtonIconColor;
  
  /// Success color for notifications
  final Color successColor;
  
  /// Error color for notifications
  final Color errorColor;

  /// Creates a light theme
  const ZephyrQRCodeTheme.light()
      : foregroundColor = Colors.black,
        backgroundColor = Colors.white,
        borderColor = const Color(0xFFE5E7EB),
        borderWidth = 1.0,
        borderRadius = const BorderRadius.all(Radius.circular(8)),
        padding = const EdgeInsets.all(16),
        exportButtonBackgroundColor = const Color(0xFFF3F4F6),
        exportButtonTextColor = const Color(0xFF374151),
        exportButtonIconColor = const Color(0xFF6B7280),
        successColor = const Color(0xFF10B981),
        errorColor = const Color(0xFFEF4444);

  /// Creates a dark theme
  const ZephyrQRCodeTheme.dark()
      : foregroundColor = Colors.white,
        backgroundColor = const Color(0xFF1F2937),
        borderColor = const Color(0xFF374151),
        borderWidth = 1.0,
        borderRadius = const BorderRadius.all(Radius.circular(8)),
        padding = const EdgeInsets.all(16),
        exportButtonBackgroundColor = const Color(0xFF374151),
        exportButtonTextColor = const Color(0xFFF9FAFB),
        exportButtonIconColor = const Color(0xFF9CA3AF),
        successColor = const Color(0xFF34D399),
        errorColor = const Color(0xFFF87171);

  /// Creates a custom theme
  const ZephyrQRCodeTheme({
    required this.foregroundColor,
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.padding,
    required this.exportButtonBackgroundColor,
    required this.exportButtonTextColor,
    required this.exportButtonIconColor,
    required this.successColor,
    required this.errorColor,
  });

  /// Gets theme from context
  static ZephyrQRCodeTheme of(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark 
        ? const ZephyrQRCodeTheme.dark() 
        : const ZephyrQRCodeTheme.light();
  }

  /// Creates a copy of the theme with specified properties
  ZephyrQRCodeTheme copyWith({
    Color? foregroundColor,
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    Color? exportButtonBackgroundColor,
    Color? exportButtonTextColor,
    Color? exportButtonIconColor,
    Color? successColor,
    Color? errorColor,
  }) {
    return ZephyrQRCodeTheme(
      foregroundColor: foregroundColor ?? this.foregroundColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      exportButtonBackgroundColor: exportButtonBackgroundColor ?? this.exportButtonBackgroundColor,
      exportButtonTextColor: exportButtonTextColor ?? this.exportButtonTextColor,
      exportButtonIconColor: exportButtonIconColor ?? this.exportButtonIconColor,
      successColor: successColor ?? this.successColor,
      errorColor: errorColor ?? this.errorColor,
    );
  }

  /// Merges with another theme
  ZephyrQRCodeTheme merge(ZephyrQRCodeTheme other) {
    return copyWith(
      foregroundColor: other.foregroundColor,
      backgroundColor: other.backgroundColor,
      borderColor: other.borderColor,
      borderWidth: other.borderWidth,
      borderRadius: other.borderRadius,
      padding: other.padding,
      exportButtonBackgroundColor: other.exportButtonBackgroundColor,
      exportButtonTextColor: other.exportButtonTextColor,
      exportButtonIconColor: other.exportButtonIconColor,
      successColor: other.successColor,
      errorColor: other.errorColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ZephyrQRCodeTheme &&
        other.foregroundColor == foregroundColor &&
        other.backgroundColor == backgroundColor &&
        other.borderColor == borderColor &&
        other.borderWidth == borderWidth &&
        other.borderRadius == borderRadius &&
        other.padding == padding &&
        other.exportButtonBackgroundColor == exportButtonBackgroundColor &&
        other.exportButtonTextColor == exportButtonTextColor &&
        other.exportButtonIconColor == exportButtonIconColor &&
        other.successColor == successColor &&
        other.errorColor == errorColor;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      foregroundColor,
      backgroundColor,
      borderColor,
      borderWidth,
      borderRadius,
      padding,
      exportButtonBackgroundColor,
      exportButtonTextColor,
      exportButtonIconColor,
      successColor,
      errorColor,
    ]);
  }
}