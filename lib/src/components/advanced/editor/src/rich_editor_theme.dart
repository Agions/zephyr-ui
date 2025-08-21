import 'package:flutter/material.dart';

/// Zephyr Rich Editor Theme Configuration
/// 
/// Provides comprehensive theming options for the rich text editor
/// including toolbar, content area, and formatting options.
class ZephyrRichEditorTheme {
  /// Background color of the editor
  final Color backgroundColor;
  
  /// Border color of the editor
  final Color borderColor;
  
  /// Border width of the editor
  final double borderWidth;
  
  /// Border radius of the editor
  final BorderRadius borderRadius;
  
  /// Text color in the editor
  final Color textColor;
  
  /// Placeholder text color
  final Color placeholderColor;
  
  /// Toolbar background color
  final Color toolbarBackgroundColor;
  
  /// Toolbar icon color
  final Color toolbarIconColor;
  
  /// Toolbar button background color
  final Color toolbarButtonBackgroundColor;
  
  /// Toolbar button hover color
  final Color toolbarButtonHoverColor;
  
  /// Toolbar button active color
  final Color toolbarButtonActiveColor;
  
  /// Toolbar border color
  final Color toolbarBorderColor;
  
  /// Toolbar border radius
  final BorderRadius toolbarBorderRadius;
  
  /// Selection background color
  final Color selectionBackgroundColor;
  
  /// Link color
  final Color linkColor;
  
  /// Code block background color
  final Color codeBlockBackgroundColor;
  
  /// Quote background color
  final Color quoteBackgroundColor;
  
  /// Quote border color
  final Color quoteBorderColor;
  
  /// Header text style
  final TextStyle headerStyle;
  
  /// Body text style
  final TextStyle bodyStyle;
  
  /// Code text style
  final TextStyle codeStyle;
  
  /// Quote text style
  final TextStyle quoteStyle;
  
  /// Placeholder text style
  final TextStyle placeholderStyle;

  /// Creates a light theme for the rich editor
  const ZephyrRichEditorTheme.light()
      : backgroundColor = Colors.white,
        borderColor = const Color(0xFFE5E7EB),
        borderWidth = 1.0,
        borderRadius = const BorderRadius.all(Radius.circular(8)),
        textColor = const Color(0xFF1F2937),
        placeholderColor = const Color(0xFF9CA3AF),
        toolbarBackgroundColor = const Color(0xFFF9FAFB),
        toolbarIconColor = const Color(0xFF6B7280),
        toolbarButtonBackgroundColor = Colors.transparent,
        toolbarButtonHoverColor = const Color(0xFFF3F4F6),
        toolbarButtonActiveColor = const Color(0xFF3B82F6),
        toolbarBorderColor = const Color(0xFFE5E7EB),
        toolbarBorderRadius = const BorderRadius.all(Radius.circular(6)),
        selectionBackgroundColor = const Color(0x333B82F6),
        linkColor = const Color(0xFF3B82F6),
        codeBlockBackgroundColor = const Color(0xFFF3F4F6),
        quoteBackgroundColor = const Color(0xFFF9FAFB),
        quoteBorderColor = const Color(0xFFE5E7EB),
        headerStyle = const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1F2937),
        ),
        bodyStyle = const TextStyle(
          fontSize: 16,
          height: 1.5,
          color: Color(0xFF1F2937),
        ),
        codeStyle = const TextStyle(
          fontFamily: 'monospace',
          fontSize: 14,
          color: Color(0xFFDC2626),
          backgroundColor: Color(0xFFF3F4F6),
        ),
        quoteStyle = const TextStyle(
          fontSize: 16,
          fontStyle: FontStyle.italic,
          color: Color(0xFF6B7280),
        ),
        placeholderStyle = const TextStyle(
          fontSize: 16,
          color: Color(0xFF9CA3AF),
        );

  /// Creates a dark theme for the rich editor
  const ZephyrRichEditorTheme.dark()
      : backgroundColor = const Color(0xFF1F2937),
        borderColor = const Color(0xFF374151),
        borderWidth = 1.0,
        borderRadius = const BorderRadius.all(Radius.circular(8)),
        textColor = const Color(0xFFF9FAFB),
        placeholderColor = const Color(0xFF6B7280),
        toolbarBackgroundColor = const Color(0xFF111827),
        toolbarIconColor = const Color(0xFF9CA3AF),
        toolbarButtonBackgroundColor = Colors.transparent,
        toolbarButtonHoverColor = const Color(0xFF374151),
        toolbarButtonActiveColor = const Color(0xFF60A5FA),
        toolbarBorderColor = const Color(0xFF374151),
        toolbarBorderRadius = const BorderRadius.all(Radius.circular(6)),
        selectionBackgroundColor = const Color(0x3360A5FA),
        linkColor = const Color(0xFF60A5FA),
        codeBlockBackgroundColor = const Color(0xFF374151),
        quoteBackgroundColor = const Color(0xFF111827),
        quoteBorderColor = const Color(0xFF374151),
        headerStyle = const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFFF9FAFB),
        ),
        bodyStyle = const TextStyle(
          fontSize: 16,
          height: 1.5,
          color: Color(0xFFF9FAFB),
        ),
        codeStyle = const TextStyle(
          fontFamily: 'monospace',
          fontSize: 14,
          color: Color(0xFFF87171),
          backgroundColor: Color(0xFF374151),
        ),
        quoteStyle = const TextStyle(
          fontSize: 16,
          fontStyle: FontStyle.italic,
          color: Color(0xFF9CA3AF),
        ),
        placeholderStyle = const TextStyle(
          fontSize: 16,
          color: Color(0xFF6B7280),
        );

  /// Creates a custom theme for the rich editor
  const ZephyrRichEditorTheme({
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.textColor,
    required this.placeholderColor,
    required this.toolbarBackgroundColor,
    required this.toolbarIconColor,
    required this.toolbarButtonBackgroundColor,
    required this.toolbarButtonHoverColor,
    required this.toolbarButtonActiveColor,
    required this.toolbarBorderColor,
    required this.toolbarBorderRadius,
    required this.selectionBackgroundColor,
    required this.linkColor,
    required this.codeBlockBackgroundColor,
    required this.quoteBackgroundColor,
    required this.quoteBorderColor,
    required this.headerStyle,
    required this.bodyStyle,
    required this.codeStyle,
    required this.quoteStyle,
    required this.placeholderStyle,
  });

  /// Creates a copy of this theme with the specified fields replaced
  ZephyrRichEditorTheme copyWith({
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    BorderRadius? borderRadius,
    Color? textColor,
    Color? placeholderColor,
    Color? toolbarBackgroundColor,
    Color? toolbarIconColor,
    Color? toolbarButtonBackgroundColor,
    Color? toolbarButtonHoverColor,
    Color? toolbarButtonActiveColor,
    Color? toolbarBorderColor,
    BorderRadius? toolbarBorderRadius,
    Color? selectionBackgroundColor,
    Color? linkColor,
    Color? codeBlockBackgroundColor,
    Color? quoteBackgroundColor,
    Color? quoteBorderColor,
    TextStyle? headerStyle,
    TextStyle? bodyStyle,
    TextStyle? codeStyle,
    TextStyle? quoteStyle,
    TextStyle? placeholderStyle,
  }) {
    return ZephyrRichEditorTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      textColor: textColor ?? this.textColor,
      placeholderColor: placeholderColor ?? this.placeholderColor,
      toolbarBackgroundColor: toolbarBackgroundColor ?? this.toolbarBackgroundColor,
      toolbarIconColor: toolbarIconColor ?? this.toolbarIconColor,
      toolbarButtonBackgroundColor: toolbarButtonBackgroundColor ?? this.toolbarButtonBackgroundColor,
      toolbarButtonHoverColor: toolbarButtonHoverColor ?? this.toolbarButtonHoverColor,
      toolbarButtonActiveColor: toolbarButtonActiveColor ?? this.toolbarButtonActiveColor,
      toolbarBorderColor: toolbarBorderColor ?? this.toolbarBorderColor,
      toolbarBorderRadius: toolbarBorderRadius ?? this.toolbarBorderRadius,
      selectionBackgroundColor: selectionBackgroundColor ?? this.selectionBackgroundColor,
      linkColor: linkColor ?? this.linkColor,
      codeBlockBackgroundColor: codeBlockBackgroundColor ?? this.codeBlockBackgroundColor,
      quoteBackgroundColor: quoteBackgroundColor ?? this.quoteBackgroundColor,
      quoteBorderColor: quoteBorderColor ?? this.quoteBorderColor,
      headerStyle: headerStyle ?? this.headerStyle,
      bodyStyle: bodyStyle ?? this.bodyStyle,
      codeStyle: codeStyle ?? this.codeStyle,
      quoteStyle: quoteStyle ?? this.quoteStyle,
      placeholderStyle: placeholderStyle ?? this.placeholderStyle,
    );
  }

  /// Merges this theme with another theme
  ZephyrRichEditorTheme merge(ZephyrRichEditorTheme other) {
    return copyWith(
      backgroundColor: other.backgroundColor,
      borderColor: other.borderColor,
      borderWidth: other.borderWidth,
      borderRadius: other.borderRadius,
      textColor: other.textColor,
      placeholderColor: other.placeholderColor,
      toolbarBackgroundColor: other.toolbarBackgroundColor,
      toolbarIconColor: other.toolbarIconColor,
      toolbarButtonBackgroundColor: other.toolbarButtonBackgroundColor,
      toolbarButtonHoverColor: other.toolbarButtonHoverColor,
      toolbarButtonActiveColor: other.toolbarButtonActiveColor,
      toolbarBorderColor: other.toolbarBorderColor,
      toolbarBorderRadius: other.toolbarBorderRadius,
      selectionBackgroundColor: other.selectionBackgroundColor,
      linkColor: other.linkColor,
      codeBlockBackgroundColor: other.codeBlockBackgroundColor,
      quoteBackgroundColor: other.quoteBackgroundColor,
      quoteBorderColor: other.quoteBorderColor,
      headerStyle: other.headerStyle,
      bodyStyle: other.bodyStyle,
      codeStyle: other.codeStyle,
      quoteStyle: other.quoteStyle,
      placeholderStyle: other.placeholderStyle,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ZephyrRichEditorTheme &&
        other.backgroundColor == backgroundColor &&
        other.borderColor == borderColor &&
        other.borderWidth == borderWidth &&
        other.borderRadius == borderRadius &&
        other.textColor == textColor &&
        other.placeholderColor == placeholderColor &&
        other.toolbarBackgroundColor == toolbarBackgroundColor &&
        other.toolbarIconColor == toolbarIconColor &&
        other.toolbarButtonBackgroundColor == toolbarButtonBackgroundColor &&
        other.toolbarButtonHoverColor == toolbarButtonHoverColor &&
        other.toolbarButtonActiveColor == toolbarButtonActiveColor &&
        other.toolbarBorderColor == toolbarBorderColor &&
        other.toolbarBorderRadius == toolbarBorderRadius &&
        other.selectionBackgroundColor == selectionBackgroundColor &&
        other.linkColor == linkColor &&
        other.codeBlockBackgroundColor == codeBlockBackgroundColor &&
        other.quoteBackgroundColor == quoteBackgroundColor &&
        other.quoteBorderColor == quoteBorderColor &&
        other.headerStyle == headerStyle &&
        other.bodyStyle == bodyStyle &&
        other.codeStyle == codeStyle &&
        other.quoteStyle == quoteStyle &&
        other.placeholderStyle == placeholderStyle;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      backgroundColor,
      borderColor,
      borderWidth,
      borderRadius,
      textColor,
      placeholderColor,
      toolbarBackgroundColor,
      toolbarIconColor,
      toolbarButtonBackgroundColor,
      toolbarButtonHoverColor,
      toolbarButtonActiveColor,
      toolbarBorderColor,
      toolbarBorderRadius,
      selectionBackgroundColor,
      linkColor,
      codeBlockBackgroundColor,
      quoteBackgroundColor,
      quoteBorderColor,
      headerStyle,
      bodyStyle,
      codeStyle,
      quoteStyle,
      placeholderStyle,
    ]);
  }

  static custom({required MaterialColor backgroundColor, required Color textColor, required Color toolbarBackgroundColor, required Color toolbarIconColor, required TextStyle headerStyle, required TextStyle bodyStyle, required TextStyle codeStyle, required TextStyle quoteStyle, required TextStyle placeholderStyle}) {}
}