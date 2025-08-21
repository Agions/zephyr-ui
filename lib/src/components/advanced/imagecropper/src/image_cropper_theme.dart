import 'package:flutter/material.dart';

/// ZephyrUI Image Cropper Theme Configuration
/// 
/// Provides styling options for image cropper components including colors,
/// borders, and control panel styling.
class ZephyrImageCropperTheme {
  /// Background color
  final Color backgroundColor;
  
  /// Crop border color
  final Color cropBorderColor;
  
  /// Crop border width
  final double cropBorderWidth;
  
  /// Handle color
  final Color handleColor;
  
  /// Handle border color
  final Color handleBorderColor;
  
  /// Grid color
  final Color gridColor;
  
  /// Grid width
  final double gridWidth;
  
  /// Control panel background color
  final Color controlPanelBackgroundColor;
  
  /// Button background color
  final Color buttonBackgroundColor;
  
  /// Button text color
  final Color buttonTextColor;
  
  /// Button icon color
  final Color buttonIconColor;
  
  /// Success color for notifications
  final Color successColor;
  
  /// Error color for notifications
  final Color errorColor;

  /// Creates a light theme
  const ZephyrImageCropperTheme.light()
      : backgroundColor = Colors.black,
        cropBorderColor = Colors.white,
        cropBorderWidth = 2.0,
        handleColor = Colors.white,
        handleBorderColor = Colors.black,
        gridColor = const Color(0x4DFFFFFF),
        gridWidth = 1.0,
        controlPanelBackgroundColor = const Color(0xFFF3F4F6),
        buttonBackgroundColor = const Color(0xFF3B82F6),
        buttonTextColor = Colors.white,
        buttonIconColor = Colors.white,
        successColor = const Color(0xFF10B981),
        errorColor = const Color(0xFFEF4444);

  /// Creates a dark theme
  const ZephyrImageCropperTheme.dark()
      : backgroundColor = Colors.white,
        cropBorderColor = Colors.black,
        cropBorderWidth = 2.0,
        handleColor = Colors.black,
        handleBorderColor = Colors.white,
        gridColor = const Color(0x4D000000),
        gridWidth = 1.0,
        controlPanelBackgroundColor = const Color(0xFF374151),
        buttonBackgroundColor = const Color(0xFF60A5FA),
        buttonTextColor = Colors.white,
        buttonIconColor = Colors.white,
        successColor = const Color(0xFF34D399),
        errorColor = const Color(0xFFF87171);

  /// Creates a custom theme
  const ZephyrImageCropperTheme({
    required this.backgroundColor,
    required this.cropBorderColor,
    required this.cropBorderWidth,
    required this.handleColor,
    required this.handleBorderColor,
    required this.gridColor,
    required this.gridWidth,
    required this.controlPanelBackgroundColor,
    required this.buttonBackgroundColor,
    required this.buttonTextColor,
    required this.buttonIconColor,
    required this.successColor,
    required this.errorColor,
  });

  /// Gets theme from context
  static ZephyrImageCropperTheme of(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark 
        ? const ZephyrImageCropperTheme.dark() 
        : const ZephyrImageCropperTheme.light();
  }

  /// Creates a copy of the theme with specified properties
  ZephyrImageCropperTheme copyWith({
    Color? backgroundColor,
    Color? cropBorderColor,
    double? cropBorderWidth,
    Color? handleColor,
    Color? handleBorderColor,
    Color? gridColor,
    double? gridWidth,
    Color? controlPanelBackgroundColor,
    Color? buttonBackgroundColor,
    Color? buttonTextColor,
    Color? buttonIconColor,
    Color? successColor,
    Color? errorColor,
  }) {
    return ZephyrImageCropperTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      cropBorderColor: cropBorderColor ?? this.cropBorderColor,
      cropBorderWidth: cropBorderWidth ?? this.cropBorderWidth,
      handleColor: handleColor ?? this.handleColor,
      handleBorderColor: handleBorderColor ?? this.handleBorderColor,
      gridColor: gridColor ?? this.gridColor,
      gridWidth: gridWidth ?? this.gridWidth,
      controlPanelBackgroundColor: controlPanelBackgroundColor ?? this.controlPanelBackgroundColor,
      buttonBackgroundColor: buttonBackgroundColor ?? this.buttonBackgroundColor,
      buttonTextColor: buttonTextColor ?? this.buttonTextColor,
      buttonIconColor: buttonIconColor ?? this.buttonIconColor,
      successColor: successColor ?? this.successColor,
      errorColor: errorColor ?? this.errorColor,
    );
  }

  /// Merges with another theme
  ZephyrImageCropperTheme merge(ZephyrImageCropperTheme other) {
    return copyWith(
      backgroundColor: other.backgroundColor,
      cropBorderColor: other.cropBorderColor,
      cropBorderWidth: other.cropBorderWidth,
      handleColor: other.handleColor,
      handleBorderColor: other.handleBorderColor,
      gridColor: other.gridColor,
      gridWidth: other.gridWidth,
      controlPanelBackgroundColor: other.controlPanelBackgroundColor,
      buttonBackgroundColor: other.buttonBackgroundColor,
      buttonTextColor: other.buttonTextColor,
      buttonIconColor: other.buttonIconColor,
      successColor: other.successColor,
      errorColor: other.errorColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ZephyrImageCropperTheme &&
        other.backgroundColor == backgroundColor &&
        other.cropBorderColor == cropBorderColor &&
        other.cropBorderWidth == cropBorderWidth &&
        other.handleColor == handleColor &&
        other.handleBorderColor == handleBorderColor &&
        other.gridColor == gridColor &&
        other.gridWidth == gridWidth &&
        other.controlPanelBackgroundColor == controlPanelBackgroundColor &&
        other.buttonBackgroundColor == buttonBackgroundColor &&
        other.buttonTextColor == buttonTextColor &&
        other.buttonIconColor == buttonIconColor &&
        other.successColor == successColor &&
        other.errorColor == errorColor;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      backgroundColor,
      cropBorderColor,
      cropBorderWidth,
      handleColor,
      handleBorderColor,
      gridColor,
      gridWidth,
      controlPanelBackgroundColor,
      buttonBackgroundColor,
      buttonTextColor,
      buttonIconColor,
      successColor,
      errorColor,
    ]);
  }
}