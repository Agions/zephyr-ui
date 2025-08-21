import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// Color Picker theme configuration
/// 
/// Defines the visual appearance and styling for the Color Picker component
class ZephyrColorPickerTheme {
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final Color shadowColor;
  final double shadowBlurRadius;
  final Offset shadowOffset;
  final EdgeInsetsGeometry contentPadding;
  final TextStyle labelStyle;
  final TextStyle sliderLabelStyle;
  final TextStyle sliderValueStyle;
  final ZephyrInputTheme inputTheme;
  
  // Preview settings
  final double previewBorderRadius;
  final double previewBorderWidth;
  final Color previewBorderColor;
  
  // Preset colors settings
  final double presetColorSize;
  final double presetColorBorderRadius;
  final double presetColorBorderWidth;
  final Color presetColorBorderColor;
  final double presetColorSpacing;
  final double selectedBorderWidth;
  final Color selectedBorderColor;
  
  // History colors settings
  final double historyColorSize;
  final double historyColorBorderRadius;
  final double historyColorBorderWidth;
  final Color historyColorBorderColor;
  final double historyColorSpacing;

  ZephyrColorPickerTheme({
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.shadowColor,
    required this.shadowBlurRadius,
    required this.shadowOffset,
    required this.contentPadding,
    required this.labelStyle,
    required this.sliderLabelStyle,
    required this.sliderValueStyle,
    required this.inputTheme,
    required this.previewBorderRadius,
    required this.previewBorderWidth,
    required this.previewBorderColor,
    required this.presetColorSize,
    required this.presetColorBorderRadius,
    required this.presetColorBorderWidth,
    required this.presetColorBorderColor,
    required this.presetColorSpacing,
    required this.selectedBorderWidth,
    required this.selectedBorderColor,
    required this.historyColorSize,
    required this.historyColorBorderRadius,
    required this.historyColorBorderWidth,
    required this.historyColorBorderColor,
    required this.historyColorSpacing,
  });

  /// Factory constructor for light theme
  factory ZephyrColorPickerTheme.light() {
    return ZephyrColorPickerTheme(
      backgroundColor: const Color(0xFFFFFFFF),
      borderColor: const Color(0xFFD1D5DB),
      borderWidth: 1.0,
      borderRadius: 8.0,
      shadowColor: const Color(0x1A000000),
      shadowBlurRadius: 8.0,
      shadowOffset: const Offset(0, 2),
      contentPadding: const EdgeInsets.all(16),
      labelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF1F2937),
      ),
      sliderLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Color(0xFF6B7280),
      ),
      sliderValueStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Color(0xFF1F2937),
      ),
      inputTheme: const ZephyrInputTheme(
        backgroundColor: Color(0xFFFFFFFF),
        borderColor: Color(0xFFD1D5DB),
        focusedBorderColor: Color(0xFF3B82F6),
        errorBorderColor: Color(0xFFEF4444),
        errorBackgroundColor: Color(0xFFFFF0F0),
        textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Color(0xFF1F2937),
        ),
        labelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color(0xFF6B7280),
        ),
        placeholderStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Color(0xFF9CA3AF),
        ),
        helperTextStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: Color(0xFF6B7280),
        ),
        errorTextStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: Color(0xFFEF4444),
        ),
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      previewBorderRadius: 8.0,
      previewBorderWidth: 1.0,
      previewBorderColor: const Color(0xFFD1D5DB),
      presetColorSize: 32.0,
      presetColorBorderRadius: 4.0,
      presetColorBorderWidth: 1.0,
      presetColorBorderColor: const Color(0xFFD1D5DB),
      presetColorSpacing: 8.0,
      selectedBorderWidth: 2.0,
      selectedBorderColor: const Color(0xFF3B82F6),
      historyColorSize: 24.0,
      historyColorBorderRadius: 4.0,
      historyColorBorderWidth: 1.0,
      historyColorBorderColor: const Color(0xFFD1D5DB),
      historyColorSpacing: 6.0,
    );
  }

  /// Factory constructor for dark theme
  factory ZephyrColorPickerTheme.dark() {
    return ZephyrColorPickerTheme(
      backgroundColor: const Color(0xFF1F2937),
      borderColor: const Color(0xFF374151),
      borderWidth: 1.0,
      borderRadius: 8.0,
      shadowColor: const Color(0x1AFFFFFF),
      shadowBlurRadius: 8.0,
      shadowOffset: const Offset(0, 2),
      contentPadding: const EdgeInsets.all(16),
      labelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFFF9FAFB),
      ),
      sliderLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Color(0xFF9CA3AF),
      ),
      sliderValueStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Color(0xFFF9FAFB),
      ),
      inputTheme: const ZephyrInputTheme(
        backgroundColor: Color(0xFF1F2937),
        borderColor: Color(0xFF4B5563),
        focusedBorderColor: Color(0xFF60A5FA),
        errorBorderColor: Color(0xFFEF4444),
        errorBackgroundColor: Color(0xFF3F1212),
        textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Color(0xFFF9FAFB),
        ),
        labelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color(0xFF9CA3AF),
        ),
        placeholderStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Color(0xFF6B7280),
        ),
        helperTextStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: Color(0xFF9CA3AF),
        ),
        errorTextStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: Color(0xFFEF4444),
        ),
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      previewBorderRadius: 8.0,
      previewBorderWidth: 1.0,
      previewBorderColor: const Color(0xFF374151),
      presetColorSize: 32.0,
      presetColorBorderRadius: 4.0,
      presetColorBorderWidth: 1.0,
      presetColorBorderColor: const Color(0xFF374151),
      presetColorSpacing: 8.0,
      selectedBorderWidth: 2.0,
      selectedBorderColor: const Color(0xFF60A5FA),
      historyColorSize: 24.0,
      historyColorBorderRadius: 4.0,
      historyColorBorderWidth: 1.0,
      historyColorBorderColor: const Color(0xFF374151),
      historyColorSpacing: 6.0,
    );
  }

  /// Factory constructor for custom theme
  factory ZephyrColorPickerTheme.custom({
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    Color? shadowColor,
    double? shadowBlurRadius,
    Offset? shadowOffset,
    EdgeInsetsGeometry? contentPadding,
    TextStyle? labelStyle,
    TextStyle? sliderLabelStyle,
    TextStyle? sliderValueStyle,
    ZephyrInputTheme? inputTheme,
    double? previewBorderRadius,
    double? previewBorderWidth,
    Color? previewBorderColor,
    double? presetColorSize,
    double? presetColorBorderRadius,
    double? presetColorBorderWidth,
    Color? presetColorBorderColor,
    double? presetColorSpacing,
    double? selectedBorderWidth,
    Color? selectedBorderColor,
    double? historyColorSize,
    double? historyColorBorderRadius,
    double? historyColorBorderWidth,
    Color? historyColorBorderColor,
    double? historyColorSpacing,
  }) {
    final baseTheme = ZephyrColorPickerTheme.light();
    return ZephyrColorPickerTheme(
      backgroundColor: backgroundColor ?? baseTheme.backgroundColor,
      borderColor: borderColor ?? baseTheme.borderColor,
      borderWidth: borderWidth ?? baseTheme.borderWidth,
      borderRadius: borderRadius ?? baseTheme.borderRadius,
      shadowColor: shadowColor ?? baseTheme.shadowColor,
      shadowBlurRadius: shadowBlurRadius ?? baseTheme.shadowBlurRadius,
      shadowOffset: shadowOffset ?? baseTheme.shadowOffset,
      contentPadding: contentPadding ?? baseTheme.contentPadding,
      labelStyle: labelStyle ?? baseTheme.labelStyle,
      sliderLabelStyle: sliderLabelStyle ?? baseTheme.sliderLabelStyle,
      sliderValueStyle: sliderValueStyle ?? baseTheme.sliderValueStyle,
      inputTheme: inputTheme ?? baseTheme.inputTheme,
      previewBorderRadius: previewBorderRadius ?? baseTheme.previewBorderRadius,
      previewBorderWidth: previewBorderWidth ?? baseTheme.previewBorderWidth,
      previewBorderColor: previewBorderColor ?? baseTheme.previewBorderColor,
      presetColorSize: presetColorSize ?? baseTheme.presetColorSize,
      presetColorBorderRadius: presetColorBorderRadius ?? baseTheme.presetColorBorderRadius,
      presetColorBorderWidth: presetColorBorderWidth ?? baseTheme.presetColorBorderWidth,
      presetColorBorderColor: presetColorBorderColor ?? baseTheme.presetColorBorderColor,
      presetColorSpacing: presetColorSpacing ?? baseTheme.presetColorSpacing,
      selectedBorderWidth: selectedBorderWidth ?? baseTheme.selectedBorderWidth,
      selectedBorderColor: selectedBorderColor ?? baseTheme.selectedBorderColor,
      historyColorSize: historyColorSize ?? baseTheme.historyColorSize,
      historyColorBorderRadius: historyColorBorderRadius ?? baseTheme.historyColorBorderRadius,
      historyColorBorderWidth: historyColorBorderWidth ?? baseTheme.historyColorBorderWidth,
      historyColorBorderColor: historyColorBorderColor ?? baseTheme.historyColorBorderColor,
      historyColorSpacing: historyColorSpacing ?? baseTheme.historyColorSpacing,
    );
  }

  /// Copy with modifications
  ZephyrColorPickerTheme copyWith({
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    Color? shadowColor,
    double? shadowBlurRadius,
    Offset? shadowOffset,
    EdgeInsetsGeometry? contentPadding,
    TextStyle? labelStyle,
    TextStyle? sliderLabelStyle,
    TextStyle? sliderValueStyle,
    ZephyrInputTheme? inputTheme,
    double? previewBorderRadius,
    double? previewBorderWidth,
    Color? previewBorderColor,
    double? presetColorSize,
    double? presetColorBorderRadius,
    double? presetColorBorderWidth,
    Color? presetColorBorderColor,
    double? presetColorSpacing,
    double? selectedBorderWidth,
    Color? selectedBorderColor,
    double? historyColorSize,
    double? historyColorBorderRadius,
    double? historyColorBorderWidth,
    Color? historyColorBorderColor,
    double? historyColorSpacing,
  }) {
    return ZephyrColorPickerTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      shadowColor: shadowColor ?? this.shadowColor,
      shadowBlurRadius: shadowBlurRadius ?? this.shadowBlurRadius,
      shadowOffset: shadowOffset ?? this.shadowOffset,
      contentPadding: contentPadding ?? this.contentPadding,
      labelStyle: labelStyle ?? this.labelStyle,
      sliderLabelStyle: sliderLabelStyle ?? this.sliderLabelStyle,
      sliderValueStyle: sliderValueStyle ?? this.sliderValueStyle,
      inputTheme: inputTheme ?? this.inputTheme,
      previewBorderRadius: previewBorderRadius ?? this.previewBorderRadius,
      previewBorderWidth: previewBorderWidth ?? this.previewBorderWidth,
      previewBorderColor: previewBorderColor ?? this.previewBorderColor,
      presetColorSize: presetColorSize ?? this.presetColorSize,
      presetColorBorderRadius: presetColorBorderRadius ?? this.presetColorBorderRadius,
      presetColorBorderWidth: presetColorBorderWidth ?? this.presetColorBorderWidth,
      presetColorBorderColor: presetColorBorderColor ?? this.presetColorBorderColor,
      presetColorSpacing: presetColorSpacing ?? this.presetColorSpacing,
      selectedBorderWidth: selectedBorderWidth ?? this.selectedBorderWidth,
      selectedBorderColor: selectedBorderColor ?? this.selectedBorderColor,
      historyColorSize: historyColorSize ?? this.historyColorSize,
      historyColorBorderRadius: historyColorBorderRadius ?? this.historyColorBorderRadius,
      historyColorBorderWidth: historyColorBorderWidth ?? this.historyColorBorderWidth,
      historyColorBorderColor: historyColorBorderColor ?? this.historyColorBorderColor,
      historyColorSpacing: historyColorSpacing ?? this.historyColorSpacing,
    );
  }

  /// Merge with another theme
  ZephyrColorPickerTheme merge(ZephyrColorPickerTheme other) {
    return copyWith(
      backgroundColor: other.backgroundColor,
      borderColor: other.borderColor,
      borderWidth: other.borderWidth,
      borderRadius: other.borderRadius,
      shadowColor: other.shadowColor,
      shadowBlurRadius: other.shadowBlurRadius,
      shadowOffset: other.shadowOffset,
      contentPadding: other.contentPadding,
      labelStyle: other.labelStyle,
      sliderLabelStyle: other.sliderLabelStyle,
      sliderValueStyle: other.sliderValueStyle,
      inputTheme: other.inputTheme,
      previewBorderRadius: other.previewBorderRadius,
      previewBorderWidth: other.previewBorderWidth,
      previewBorderColor: other.previewBorderColor,
      presetColorSize: other.presetColorSize,
      presetColorBorderRadius: other.presetColorBorderRadius,
      presetColorBorderWidth: other.presetColorBorderWidth,
      presetColorBorderColor: other.presetColorBorderColor,
      presetColorSpacing: other.presetColorSpacing,
      selectedBorderWidth: other.selectedBorderWidth,
      selectedBorderColor: other.selectedBorderColor,
      historyColorSize: other.historyColorSize,
      historyColorBorderRadius: other.historyColorBorderRadius,
      historyColorBorderWidth: other.historyColorBorderWidth,
      historyColorBorderColor: other.historyColorBorderColor,
      historyColorSpacing: other.historyColorSpacing,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ZephyrColorPickerTheme &&
        other.backgroundColor == backgroundColor &&
        other.borderColor == borderColor &&
        other.borderWidth == borderWidth &&
        other.borderRadius == borderRadius &&
        other.shadowColor == shadowColor &&
        other.shadowBlurRadius == shadowBlurRadius &&
        other.shadowOffset == shadowOffset &&
        other.contentPadding == contentPadding &&
        other.labelStyle == labelStyle &&
        other.sliderLabelStyle == sliderLabelStyle &&
        other.sliderValueStyle == sliderValueStyle &&
        other.inputTheme == inputTheme &&
        other.previewBorderRadius == previewBorderRadius &&
        other.previewBorderWidth == previewBorderWidth &&
        other.previewBorderColor == previewBorderColor &&
        other.presetColorSize == presetColorSize &&
        other.presetColorBorderRadius == presetColorBorderRadius &&
        other.presetColorBorderWidth == presetColorBorderWidth &&
        other.presetColorBorderColor == presetColorBorderColor &&
        other.presetColorSpacing == presetColorSpacing &&
        other.selectedBorderWidth == selectedBorderWidth &&
        other.selectedBorderColor == selectedBorderColor &&
        other.historyColorSize == historyColorSize &&
        other.historyColorBorderRadius == historyColorBorderRadius &&
        other.historyColorBorderWidth == historyColorBorderWidth &&
        other.historyColorBorderColor == historyColorBorderColor &&
        other.historyColorSpacing == historyColorSpacing;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      backgroundColor,
      borderColor,
      borderWidth,
      borderRadius,
      shadowColor,
      shadowBlurRadius,
      shadowOffset,
      contentPadding,
      labelStyle,
      sliderLabelStyle,
      sliderValueStyle,
      inputTheme,
      previewBorderRadius,
      previewBorderWidth,
      previewBorderColor,
      presetColorSize,
      presetColorBorderRadius,
      presetColorBorderWidth,
      presetColorBorderColor,
      presetColorSpacing,
      selectedBorderWidth,
      selectedBorderColor,
      historyColorSize,
      historyColorBorderRadius,
      historyColorBorderWidth,
      historyColorBorderColor,
      historyColorSpacing,
    ]);
  }
}