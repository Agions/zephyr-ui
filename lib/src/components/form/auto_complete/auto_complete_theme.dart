import 'package:flutter/material.dart';

/// AutoComplete theme configuration
/// 
/// Defines the visual appearance and styling for the AutoComplete component
class ZephyrAutoCompleteTheme {
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? textColor;
  final Color? placeholderColor;
  final Color? suggestionBackgroundColor;
  final Color? suggestionHoverColor;
  final Color? suggestionTextColor;
  final Color? selectedItemBackgroundColor;
  final Color? selectedItemTextColor;
  final Color? disabledBackgroundColor;
  final Color? disabledTextColor;
  final Color? disabledBorderColor;
  final Color? clearButtonColor;
  final Color? loadingIndicatorColor;
  final Color? noResultsTextColor;
  final Color? shadowColor;
  final double? borderRadius;
  final double? borderWidth;
  final double? elevation;
  final double? suggestionMaxHeight;
  final TextStyle? inputStyle;
  final TextStyle? placeholderStyle;
  final TextStyle? suggestionStyle;
  final TextStyle? selectedItemStyle;
  final TextStyle? noResultsStyle;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? suggestionPadding;
  final BoxShadow? shadow;
  final Duration? debounceDuration;
  final int? maxSuggestions;
  final bool? showClearButton;
  final bool? showLoadingIndicator;
  final bool? enableKeyboardNavigation;
  final bool? enableAccessibilityFeatures;

  const ZephyrAutoCompleteTheme({
    this.backgroundColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.textColor,
    this.placeholderColor,
    this.suggestionBackgroundColor,
    this.suggestionHoverColor,
    this.suggestionTextColor,
    this.selectedItemBackgroundColor,
    this.selectedItemTextColor,
    this.disabledBackgroundColor,
    this.disabledTextColor,
    this.disabledBorderColor,
    this.clearButtonColor,
    this.loadingIndicatorColor,
    this.noResultsTextColor,
    this.shadowColor,
    this.borderRadius,
    this.borderWidth,
    this.elevation,
    this.suggestionMaxHeight,
    this.inputStyle,
    this.placeholderStyle,
    this.suggestionStyle,
    this.selectedItemStyle,
    this.noResultsStyle,
    this.contentPadding,
    this.suggestionPadding,
    this.shadow,
    this.debounceDuration,
    this.maxSuggestions,
    this.showClearButton,
    this.showLoadingIndicator,
    this.enableKeyboardNavigation,
    this.enableAccessibilityFeatures,
  });

  /// Factory constructor for light theme
  factory ZephyrAutoCompleteTheme.light() {
    return const ZephyrAutoCompleteTheme(
      backgroundColor: Colors.white,
      borderColor: Color(0xFFD1D5DB),
      focusedBorderColor: Color(0xFF3B82F6),
      errorBorderColor: Color(0xFFEF4444),
      textColor: Color(0xFF1F2937),
      placeholderColor: Color(0xFF9CA3AF),
      suggestionBackgroundColor: Colors.white,
      suggestionHoverColor: Color(0xFFF3F4F6),
      suggestionTextColor: Color(0xFF1F2937),
      selectedItemBackgroundColor: Color(0xFF3B82F6),
      selectedItemTextColor: Colors.white,
      disabledBackgroundColor: Color(0xFFF9FAFB),
      disabledTextColor: Color(0xFF9CA3AF),
      disabledBorderColor: Color(0xFFE5E7EB),
      clearButtonColor: Color(0xFF6B7280),
      loadingIndicatorColor: Color(0xFF3B82F6),
      noResultsTextColor: Color(0xFF6B7280),
      shadowColor: Color(0x1A000000),
      borderRadius: 8.0,
      borderWidth: 1.0,
      elevation: 4.0,
      suggestionMaxHeight: 300.0,
      inputStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Color(0xFF1F2937),
      ),
      placeholderStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Color(0xFF9CA3AF),
      ),
      suggestionStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Color(0xFF1F2937),
      ),
      selectedItemStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      noResultsStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Color(0xFF6B7280),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      suggestionPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shadow: const const BoxShadow(
        color: Color(0x1A000000),
        blurRadius: 8,
        offset: Offset(0, 2),
      ),
      debounceDuration: Duration(milliseconds: 300),
      maxSuggestions: 10,
      showClearButton: true,
      showLoadingIndicator: true,
      enableKeyboardNavigation: true,
      enableAccessibilityFeatures: true,
    );
  }

  /// Factory constructor for dark theme
  factory ZephyrAutoCompleteTheme.dark() {
    return const ZephyrAutoCompleteTheme(
      backgroundColor: Color(0xFF1F2937),
      borderColor: Color(0xFF374151),
      focusedBorderColor: Color(0xFF60A5FA),
      errorBorderColor: Color(0xFFEF4444),
      textColor: Color(0xFFF9FAFB),
      placeholderColor: Color(0xFF9CA3AF),
      suggestionBackgroundColor: Color(0xFF1F2937),
      suggestionHoverColor: Color(0xFF374151),
      suggestionTextColor: Color(0xFFF9FAFB),
      selectedItemBackgroundColor: Color(0xFF60A5FA),
      selectedItemTextColor: Colors.white,
      disabledBackgroundColor: Color(0xFF111827),
      disabledTextColor: Color(0xFF6B7280),
      disabledBorderColor: Color(0xFF374151),
      clearButtonColor: Color(0xFF9CA3AF),
      loadingIndicatorColor: Color(0xFF60A5FA),
      noResultsTextColor: Color(0xFF9CA3AF),
      shadowColor: Color(0x1AFFFFFF),
      borderRadius: 8.0,
      borderWidth: 1.0,
      elevation: 4.0,
      suggestionMaxHeight: 300.0,
      inputStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Color(0xFFF9FAFB),
      ),
      placeholderStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Color(0xFF9CA3AF),
      ),
      suggestionStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Color(0xFFF9FAFB),
      ),
      selectedItemStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      noResultsStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Color(0xFF9CA3AF),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      suggestionPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shadow: const const BoxShadow(
        color: Color(0x1AFFFFFF),
        blurRadius: 8,
        offset: Offset(0, 2),
      ),
      debounceDuration: Duration(milliseconds: 300),
      maxSuggestions: 10,
      showClearButton: true,
      showLoadingIndicator: true,
      enableKeyboardNavigation: true,
      enableAccessibilityFeatures: true,
    );
  }

  /// Factory constructor for custom theme
  factory ZephyrAutoCompleteTheme.custom({
    Color? backgroundColor,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    Color? textColor,
    Color? placeholderColor,
    Color? suggestionBackgroundColor,
    Color? suggestionHoverColor,
    Color? suggestionTextColor,
    Color? selectedItemBackgroundColor,
    Color? selectedItemTextColor,
    Color? disabledBackgroundColor,
    Color? disabledTextColor,
    Color? disabledBorderColor,
    Color? clearButtonColor,
    Color? loadingIndicatorColor,
    Color? noResultsTextColor,
    Color? shadowColor,
    double? borderRadius,
    double? borderWidth,
    double? elevation,
    double? suggestionMaxHeight,
    TextStyle? inputStyle,
    TextStyle? placeholderStyle,
    TextStyle? suggestionStyle,
    TextStyle? selectedItemStyle,
    TextStyle? noResultsStyle,
    EdgeInsetsGeometry? contentPadding,
    EdgeInsetsGeometry? suggestionPadding,
    BoxShadow? shadow,
    Duration? debounceDuration,
    int? maxSuggestions,
    bool? showClearButton,
    bool? showLoadingIndicator,
    bool? enableKeyboardNavigation,
    bool? enableAccessibilityFeatures,
  }) {
    final baseTheme = ZephyrAutoCompleteTheme.light();
    return ZephyrAutoCompleteTheme(
      backgroundColor: backgroundColor ?? baseTheme.backgroundColor,
      borderColor: borderColor ?? baseTheme.borderColor,
      focusedBorderColor: focusedBorderColor ?? baseTheme.focusedBorderColor,
      errorBorderColor: errorBorderColor ?? baseTheme.errorBorderColor,
      textColor: textColor ?? baseTheme.textColor,
      placeholderColor: placeholderColor ?? baseTheme.placeholderColor,
      suggestionBackgroundColor: suggestionBackgroundColor ?? baseTheme.suggestionBackgroundColor,
      suggestionHoverColor: suggestionHoverColor ?? baseTheme.suggestionHoverColor,
      suggestionTextColor: suggestionTextColor ?? baseTheme.suggestionTextColor,
      selectedItemBackgroundColor: selectedItemBackgroundColor ?? baseTheme.selectedItemBackgroundColor,
      selectedItemTextColor: selectedItemTextColor ?? baseTheme.selectedItemTextColor,
      disabledBackgroundColor: disabledBackgroundColor ?? baseTheme.disabledBackgroundColor,
      disabledTextColor: disabledTextColor ?? baseTheme.disabledTextColor,
      disabledBorderColor: disabledBorderColor ?? baseTheme.disabledBorderColor,
      clearButtonColor: clearButtonColor ?? baseTheme.clearButtonColor,
      loadingIndicatorColor: loadingIndicatorColor ?? baseTheme.loadingIndicatorColor,
      noResultsTextColor: noResultsTextColor ?? baseTheme.noResultsTextColor,
      shadowColor: shadowColor ?? baseTheme.shadowColor,
      borderRadius: borderRadius ?? baseTheme.borderRadius,
      borderWidth: borderWidth ?? baseTheme.borderWidth,
      elevation: elevation ?? baseTheme.elevation,
      suggestionMaxHeight: suggestionMaxHeight ?? baseTheme.suggestionMaxHeight,
      inputStyle: inputStyle ?? baseTheme.inputStyle,
      placeholderStyle: placeholderStyle ?? baseTheme.placeholderStyle,
      suggestionStyle: suggestionStyle ?? baseTheme.suggestionStyle,
      selectedItemStyle: selectedItemStyle ?? baseTheme.selectedItemStyle,
      noResultsStyle: noResultsStyle ?? baseTheme.noResultsStyle,
      contentPadding: contentPadding ?? baseTheme.contentPadding,
      suggestionPadding: suggestionPadding ?? baseTheme.suggestionPadding,
      shadow: shadow ?? baseTheme.shadow,
      debounceDuration: debounceDuration ?? baseTheme.debounceDuration,
      maxSuggestions: maxSuggestions ?? baseTheme.maxSuggestions,
      showClearButton: showClearButton ?? baseTheme.showClearButton,
      showLoadingIndicator: showLoadingIndicator ?? baseTheme.showLoadingIndicator,
      enableKeyboardNavigation: enableKeyboardNavigation ?? baseTheme.enableKeyboardNavigation,
      enableAccessibilityFeatures: enableAccessibilityFeatures ?? baseTheme.enableAccessibilityFeatures,
    );
  }

  /// Copy with modifications
  ZephyrAutoCompleteTheme copyWith({
    Color? backgroundColor,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    Color? textColor,
    Color? placeholderColor,
    Color? suggestionBackgroundColor,
    Color? suggestionHoverColor,
    Color? suggestionTextColor,
    Color? selectedItemBackgroundColor,
    Color? selectedItemTextColor,
    Color? disabledBackgroundColor,
    Color? disabledTextColor,
    Color? disabledBorderColor,
    Color? clearButtonColor,
    Color? loadingIndicatorColor,
    Color? noResultsTextColor,
    Color? shadowColor,
    double? borderRadius,
    double? borderWidth,
    double? elevation,
    double? suggestionMaxHeight,
    TextStyle? inputStyle,
    TextStyle? placeholderStyle,
    TextStyle? suggestionStyle,
    TextStyle? selectedItemStyle,
    TextStyle? noResultsStyle,
    EdgeInsetsGeometry? contentPadding,
    EdgeInsetsGeometry? suggestionPadding,
    BoxShadow? shadow,
    Duration? debounceDuration,
    int? maxSuggestions,
    bool? showClearButton,
    bool? showLoadingIndicator,
    bool? enableKeyboardNavigation,
    bool? enableAccessibilityFeatures,
  }) {
    return ZephyrAutoCompleteTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      focusedBorderColor: focusedBorderColor ?? this.focusedBorderColor,
      errorBorderColor: errorBorderColor ?? this.errorBorderColor,
      textColor: textColor ?? this.textColor,
      placeholderColor: placeholderColor ?? this.placeholderColor,
      suggestionBackgroundColor: suggestionBackgroundColor ?? this.suggestionBackgroundColor,
      suggestionHoverColor: suggestionHoverColor ?? this.suggestionHoverColor,
      suggestionTextColor: suggestionTextColor ?? this.suggestionTextColor,
      selectedItemBackgroundColor: selectedItemBackgroundColor ?? this.selectedItemBackgroundColor,
      selectedItemTextColor: selectedItemTextColor ?? this.selectedItemTextColor,
      disabledBackgroundColor: disabledBackgroundColor ?? this.disabledBackgroundColor,
      disabledTextColor: disabledTextColor ?? this.disabledTextColor,
      disabledBorderColor: disabledBorderColor ?? this.disabledBorderColor,
      clearButtonColor: clearButtonColor ?? this.clearButtonColor,
      loadingIndicatorColor: loadingIndicatorColor ?? this.loadingIndicatorColor,
      noResultsTextColor: noResultsTextColor ?? this.noResultsTextColor,
      shadowColor: shadowColor ?? this.shadowColor,
      borderRadius: borderRadius ?? this.borderRadius,
      borderWidth: borderWidth ?? this.borderWidth,
      elevation: elevation ?? this.elevation,
      suggestionMaxHeight: suggestionMaxHeight ?? this.suggestionMaxHeight,
      inputStyle: inputStyle ?? this.inputStyle,
      placeholderStyle: placeholderStyle ?? this.placeholderStyle,
      suggestionStyle: suggestionStyle ?? this.suggestionStyle,
      selectedItemStyle: selectedItemStyle ?? this.selectedItemStyle,
      noResultsStyle: noResultsStyle ?? this.noResultsStyle,
      contentPadding: contentPadding ?? this.contentPadding,
      suggestionPadding: suggestionPadding ?? this.suggestionPadding,
      shadow: shadow ?? this.shadow,
      debounceDuration: debounceDuration ?? this.debounceDuration,
      maxSuggestions: maxSuggestions ?? this.maxSuggestions,
      showClearButton: showClearButton ?? this.showClearButton,
      showLoadingIndicator: showLoadingIndicator ?? this.showLoadingIndicator,
      enableKeyboardNavigation: enableKeyboardNavigation ?? this.enableKeyboardNavigation,
      enableAccessibilityFeatures: enableAccessibilityFeatures ?? this.enableAccessibilityFeatures,
    );
  }

  /// Merge with another theme
  ZephyrAutoCompleteTheme merge(ZephyrAutoCompleteTheme other) {
    return copyWith(
      backgroundColor: other.backgroundColor,
      borderColor: other.borderColor,
      focusedBorderColor: other.focusedBorderColor,
      errorBorderColor: other.errorBorderColor,
      textColor: other.textColor,
      placeholderColor: other.placeholderColor,
      suggestionBackgroundColor: other.suggestionBackgroundColor,
      suggestionHoverColor: other.suggestionHoverColor,
      suggestionTextColor: other.suggestionTextColor,
      selectedItemBackgroundColor: other.selectedItemBackgroundColor,
      selectedItemTextColor: other.selectedItemTextColor,
      disabledBackgroundColor: other.disabledBackgroundColor,
      disabledTextColor: other.disabledTextColor,
      disabledBorderColor: other.disabledBorderColor,
      clearButtonColor: other.clearButtonColor,
      loadingIndicatorColor: other.loadingIndicatorColor,
      noResultsTextColor: other.noResultsTextColor,
      shadowColor: other.shadowColor,
      borderRadius: other.borderRadius,
      borderWidth: other.borderWidth,
      elevation: other.elevation,
      suggestionMaxHeight: other.suggestionMaxHeight,
      inputStyle: other.inputStyle,
      placeholderStyle: other.placeholderStyle,
      suggestionStyle: other.suggestionStyle,
      selectedItemStyle: other.selectedItemStyle,
      noResultsStyle: other.noResultsStyle,
      contentPadding: other.contentPadding,
      suggestionPadding: other.suggestionPadding,
      shadow: other.shadow,
      debounceDuration: other.debounceDuration,
      maxSuggestions: other.maxSuggestions,
      showClearButton: other.showClearButton,
      showLoadingIndicator: other.showLoadingIndicator,
      enableKeyboardNavigation: other.enableKeyboardNavigation,
      enableAccessibilityFeatures: other.enableAccessibilityFeatures,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ZephyrAutoCompleteTheme &&
        other.backgroundColor == backgroundColor &&
        other.borderColor == borderColor &&
        other.focusedBorderColor == focusedBorderColor &&
        other.errorBorderColor == errorBorderColor &&
        other.textColor == textColor &&
        other.placeholderColor == placeholderColor &&
        other.suggestionBackgroundColor == suggestionBackgroundColor &&
        other.suggestionHoverColor == suggestionHoverColor &&
        other.suggestionTextColor == suggestionTextColor &&
        other.selectedItemBackgroundColor == selectedItemBackgroundColor &&
        other.selectedItemTextColor == selectedItemTextColor &&
        other.disabledBackgroundColor == disabledBackgroundColor &&
        other.disabledTextColor == disabledTextColor &&
        other.disabledBorderColor == disabledBorderColor &&
        other.clearButtonColor == clearButtonColor &&
        other.loadingIndicatorColor == loadingIndicatorColor &&
        other.noResultsTextColor == noResultsTextColor &&
        other.shadowColor == shadowColor &&
        other.borderRadius == borderRadius &&
        other.borderWidth == borderWidth &&
        other.elevation == elevation &&
        other.suggestionMaxHeight == suggestionMaxHeight &&
        other.inputStyle == inputStyle &&
        other.placeholderStyle == placeholderStyle &&
        other.suggestionStyle == suggestionStyle &&
        other.selectedItemStyle == selectedItemStyle &&
        other.noResultsStyle == noResultsStyle &&
        other.contentPadding == contentPadding &&
        other.suggestionPadding == suggestionPadding &&
        other.shadow == shadow &&
        other.debounceDuration == debounceDuration &&
        other.maxSuggestions == maxSuggestions &&
        other.showClearButton == showClearButton &&
        other.showLoadingIndicator == showLoadingIndicator &&
        other.enableKeyboardNavigation == enableKeyboardNavigation &&
        other.enableAccessibilityFeatures == enableAccessibilityFeatures;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      backgroundColor,
      borderColor,
      focusedBorderColor,
      errorBorderColor,
      textColor,
      placeholderColor,
      suggestionBackgroundColor,
      suggestionHoverColor,
      suggestionTextColor,
      selectedItemBackgroundColor,
      selectedItemTextColor,
      disabledBackgroundColor,
      disabledTextColor,
      disabledBorderColor,
      clearButtonColor,
      loadingIndicatorColor,
      noResultsTextColor,
      shadowColor,
      borderRadius,
      borderWidth,
      elevation,
      suggestionMaxHeight,
      inputStyle,
      placeholderStyle,
      suggestionStyle,
      selectedItemStyle,
      noResultsStyle,
      contentPadding,
      suggestionPadding,
      shadow,
      debounceDuration,
      maxSuggestions,
      showClearButton,
      showLoadingIndicator,
      enableKeyboardNavigation,
      enableAccessibilityFeatures,
    ]);
  }
}