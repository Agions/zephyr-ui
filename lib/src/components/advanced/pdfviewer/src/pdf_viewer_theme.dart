import 'package:flutter/material.dart';

/// ZephyrUI PDF Viewer Theme Configuration
/// 
/// Provides styling options for PDF viewer components including colors,
/// fonts, and control panel styling.
class ZephyrPDFViewerTheme {
  /// Primary color
  final Color primaryColor;
  
  /// Secondary color
  final Color secondaryColor;
  
  /// Background color
  final Color backgroundColor;
  
  /// Page background color
  final Color pageBackgroundColor;
  
  /// Text color
  final Color textColor;
  
  /// Secondary text color
  final Color secondaryTextColor;
  
  /// Border color
  final Color borderColor;
  
  /// Control bar background color
  final Color controlBarBackgroundColor;
  
  /// Search bar background color
  final Color searchBarBackgroundColor;
  
  /// Modal background color
  final Color modalBackgroundColor;
  
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
  const ZephyrPDFViewerTheme.light()
      : primaryColor = const Color(0xFF3B82F6),
        secondaryColor = const Color(0xFF6B7280),
        backgroundColor = const Color(0xFFF9FAFB),
        pageBackgroundColor = Colors.white,
        textColor = const Color(0xFF1F2937),
        secondaryTextColor = const Color(0xFF6B7280),
        borderColor = const Color(0xFFE5E7EB),
        controlBarBackgroundColor = const Color(0xFFF3F4F6),
        searchBarBackgroundColor = const Color(0xFFFFFFFF),
        modalBackgroundColor = const Color(0xFFFFFFFF),
        buttonBackgroundColor = const Color(0xFF3B82F6),
        buttonTextColor = Colors.white,
        buttonIconColor = const Color(0xFF374151),
        disabledButtonIconColor = const Color(0xFFD1D5DB),
        successColor = const Color(0xFF10B981),
        errorColor = const Color(0xFFEF4444);

  /// Creates a dark theme
  const ZephyrPDFViewerTheme.dark()
      : primaryColor = const Color(0xFF60A5FA),
        secondaryColor = const Color(0xFF9CA3AF),
        backgroundColor = const Color(0xFF111827),
        pageBackgroundColor = const Color(0xFF1F2937),
        textColor = const Color(0xFFF9FAFB),
        secondaryTextColor = const Color(0xFF9CA3AF),
        borderColor = const Color(0xFF374151),
        controlBarBackgroundColor = const Color(0xFF374151),
        searchBarBackgroundColor = const Color(0xFF1F2937),
        modalBackgroundColor = const Color(0xFF1F2937),
        buttonBackgroundColor = const Color(0xFF60A5FA),
        buttonTextColor = Colors.white,
        buttonIconColor = const Color(0xFFF9FAFB),
        disabledButtonIconColor = const Color(0xFF4B5563),
        successColor = const Color(0xFF34D399),
        errorColor = const Color(0xFFF87171);

  /// Creates a custom theme
  const ZephyrPDFViewerTheme({
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.pageBackgroundColor,
    required this.textColor,
    required this.secondaryTextColor,
    required this.borderColor,
    required this.controlBarBackgroundColor,
    required this.searchBarBackgroundColor,
    required this.modalBackgroundColor,
    required this.buttonBackgroundColor,
    required this.buttonTextColor,
    required this.buttonIconColor,
    required this.disabledButtonIconColor,
    required this.successColor,
    required this.errorColor,
  });

  /// Gets theme from context
  static ZephyrPDFViewerTheme of(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark 
        ? const ZephyrPDFViewerTheme.dark() 
        : const ZephyrPDFViewerTheme.light();
  }

  /// Creates a copy of the theme with specified properties
  ZephyrPDFViewerTheme copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? backgroundColor,
    Color? pageBackgroundColor,
    Color? textColor,
    Color? secondaryTextColor,
    Color? borderColor,
    Color? controlBarBackgroundColor,
    Color? searchBarBackgroundColor,
    Color? modalBackgroundColor,
    Color? buttonBackgroundColor,
    Color? buttonTextColor,
    Color? buttonIconColor,
    Color? disabledButtonIconColor,
    Color? successColor,
    Color? errorColor,
  }) {
    return ZephyrPDFViewerTheme(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      pageBackgroundColor: pageBackgroundColor ?? this.pageBackgroundColor,
      textColor: textColor ?? this.textColor,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      borderColor: borderColor ?? this.borderColor,
      controlBarBackgroundColor: controlBarBackgroundColor ?? this.controlBarBackgroundColor,
      searchBarBackgroundColor: searchBarBackgroundColor ?? this.searchBarBackgroundColor,
      modalBackgroundColor: modalBackgroundColor ?? this.modalBackgroundColor,
      buttonBackgroundColor: buttonBackgroundColor ?? this.buttonBackgroundColor,
      buttonTextColor: buttonTextColor ?? this.buttonTextColor,
      buttonIconColor: buttonIconColor ?? this.buttonIconColor,
      disabledButtonIconColor: disabledButtonIconColor ?? this.disabledButtonIconColor,
      successColor: successColor ?? this.successColor,
      errorColor: errorColor ?? this.errorColor,
    );
  }

  /// Merges with another theme
  ZephyrPDFViewerTheme merge(ZephyrPDFViewerTheme other) {
    return copyWith(
      primaryColor: other.primaryColor,
      secondaryColor: other.secondaryColor,
      backgroundColor: other.backgroundColor,
      pageBackgroundColor: other.pageBackgroundColor,
      textColor: other.textColor,
      secondaryTextColor: other.secondaryTextColor,
      borderColor: other.borderColor,
      controlBarBackgroundColor: other.controlBarBackgroundColor,
      searchBarBackgroundColor: other.searchBarBackgroundColor,
      modalBackgroundColor: other.modalBackgroundColor,
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
    return other is ZephyrPDFViewerTheme &&
        other.primaryColor == primaryColor &&
        other.secondaryColor == secondaryColor &&
        other.backgroundColor == backgroundColor &&
        other.pageBackgroundColor == pageBackgroundColor &&
        other.textColor == textColor &&
        other.secondaryTextColor == secondaryTextColor &&
        other.borderColor == borderColor &&
        other.controlBarBackgroundColor == controlBarBackgroundColor &&
        other.searchBarBackgroundColor == searchBarBackgroundColor &&
        other.modalBackgroundColor == modalBackgroundColor &&
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
      pageBackgroundColor,
      textColor,
      secondaryTextColor,
      borderColor,
      controlBarBackgroundColor,
      searchBarBackgroundColor,
      modalBackgroundColor,
      buttonBackgroundColor,
      buttonTextColor,
      buttonIconColor,
      disabledButtonIconColor,
      successColor,
      errorColor,
    ]);
  }
}