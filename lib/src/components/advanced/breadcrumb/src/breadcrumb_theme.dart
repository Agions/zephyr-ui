import 'package:flutter/material.dart';

/// Breadcrumb theme configuration
/// 
/// Defines the visual appearance and styling for the Breadcrumb component
class ZephyrBreadcrumbTheme {
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final double? borderRadius;
  final Color? borderColor;
  final double? borderWidth;
  final double? spacing;
  final double? itemBorderRadius;
  final Color? currentItemBackgroundColor;
  final Color? currentItemBorderColor;
  final double? currentItemBorderWidth;
  final TextStyle? currentItemStyle;
  final TextStyle? clickableItemStyle;
  final TextStyle? itemStyle;
  final Color? currentIconColor;
  final Color? clickableIconColor;
  final Color? iconColor;
  final double? iconSize;
  final double? iconTextSpacing;
  final IconData? separatorIcon;
  final Color? separatorColor;
  final double? separatorSize;
  final EdgeInsets? itemPadding;

  const ZephyrBreadcrumbTheme({
    this.padding,
    this.backgroundColor,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.spacing,
    this.itemBorderRadius,
    this.currentItemBackgroundColor,
    this.currentItemBorderColor,
    this.currentItemBorderWidth,
    this.currentItemStyle,
    this.clickableItemStyle,
    this.itemStyle,
    this.currentIconColor,
    this.clickableIconColor,
    this.iconColor,
    this.iconSize,
    this.iconTextSpacing,
    this.separatorIcon,
    this.separatorColor,
    this.separatorSize,
    this.itemPadding,
  });

  /// Factory constructor for light theme
  factory ZephyrBreadcrumbTheme.light() {
    return const ZephyrBreadcrumbTheme(
      padding: EdgeInsets.all(8.0),
      backgroundColor: Colors.white,
      borderRadius: 6.0,
      borderColor: Color(0xFFD1D5DB),
      borderWidth: 1.0,
      spacing: 8.0,
      itemBorderRadius: 4.0,
      currentItemBackgroundColor: Color(0xFFEFF6FF),
      currentItemBorderColor: Color(0xFF3B82F6),
      currentItemBorderWidth: 1.0,
      currentItemStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF1F2937),
      ),
      clickableItemStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Color(0xFF3B82F6),
      ),
      itemStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Color(0xFF6B7280),
      ),
      currentIconColor: Color(0xFF1F2937),
      clickableIconColor: Color(0xFF3B82F6),
      iconColor: Color(0xFF6B7280),
      iconSize: 16.0,
      iconTextSpacing: 6.0,
      separatorIcon: Icons.chevron_right,
      separatorColor: Color(0xFF9CA3AF),
      separatorSize: 18.0,
      itemPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
    );
  }

  /// Factory constructor for dark theme
  factory ZephyrBreadcrumbTheme.dark() {
    return const ZephyrBreadcrumbTheme(
      padding: EdgeInsets.all(8.0),
      backgroundColor: Color(0xFF1F2937),
      borderRadius: 6.0,
      borderColor: Color(0xFF374151),
      borderWidth: 1.0,
      spacing: 8.0,
      itemBorderRadius: 4.0,
      currentItemBackgroundColor: Color(0xFF1E40AF),
      currentItemBorderColor: Color(0xFF3B82F6),
      currentItemBorderWidth: 1.0,
      currentItemStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFFBFDBFE),
      ),
      clickableItemStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Color(0xFF93C5FD),
      ),
      itemStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Color(0xFF9CA3AF),
      ),
      currentIconColor: Color(0xFFBFDBFE),
      clickableIconColor: Color(0xFF93C5FD),
      iconColor: Color(0xFF6B7280),
      iconSize: 16.0,
      iconTextSpacing: 6.0,
      separatorIcon: Icons.chevron_right,
      separatorColor: Color(0xFF4B5563),
      separatorSize: 18.0,
      itemPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
    );
  }

  /// Factory constructor for custom theme
  factory ZephyrBreadcrumbTheme.custom({
    EdgeInsets? padding,
    Color? backgroundColor,
    double? borderRadius,
    Color? borderColor,
    double? borderWidth,
    double? spacing,
    double? itemBorderRadius,
    Color? currentItemBackgroundColor,
    Color? currentItemBorderColor,
    double? currentItemBorderWidth,
    TextStyle? currentItemStyle,
    TextStyle? clickableItemStyle,
    TextStyle? itemStyle,
    Color? currentIconColor,
    Color? clickableIconColor,
    Color? iconColor,
    double? iconSize,
    double? iconTextSpacing,
    IconData? separatorIcon,
    Color? separatorColor,
    double? separatorSize,
    EdgeInsets? itemPadding,
  }) {
    final baseTheme = ZephyrBreadcrumbTheme.light();
    return ZephyrBreadcrumbTheme(
      padding: padding ?? baseTheme.padding,
      backgroundColor: backgroundColor ?? baseTheme.backgroundColor,
      borderRadius: borderRadius ?? baseTheme.borderRadius,
      borderColor: borderColor ?? baseTheme.borderColor,
      borderWidth: borderWidth ?? baseTheme.borderWidth,
      spacing: spacing ?? baseTheme.spacing,
      itemBorderRadius: itemBorderRadius ?? baseTheme.itemBorderRadius,
      currentItemBackgroundColor: currentItemBackgroundColor ?? baseTheme.currentItemBackgroundColor,
      currentItemBorderColor: currentItemBorderColor ?? baseTheme.currentItemBorderColor,
      currentItemBorderWidth: currentItemBorderWidth ?? baseTheme.currentItemBorderWidth,
      currentItemStyle: currentItemStyle ?? baseTheme.currentItemStyle,
      clickableItemStyle: clickableItemStyle ?? baseTheme.clickableItemStyle,
      itemStyle: itemStyle ?? baseTheme.itemStyle,
      currentIconColor: currentIconColor ?? baseTheme.currentIconColor,
      clickableIconColor: clickableIconColor ?? baseTheme.clickableIconColor,
      iconColor: iconColor ?? baseTheme.iconColor,
      iconSize: iconSize ?? baseTheme.iconSize,
      iconTextSpacing: iconTextSpacing ?? baseTheme.iconTextSpacing,
      separatorIcon: separatorIcon ?? baseTheme.separatorIcon,
      separatorColor: separatorColor ?? baseTheme.separatorColor,
      separatorSize: separatorSize ?? baseTheme.separatorSize,
      itemPadding: itemPadding ?? baseTheme.itemPadding,
    );
  }

  /// Copy with modifications
  ZephyrBreadcrumbTheme copyWith({
    EdgeInsets? padding,
    Color? backgroundColor,
    double? borderRadius,
    Color? borderColor,
    double? borderWidth,
    double? spacing,
    double? itemBorderRadius,
    Color? currentItemBackgroundColor,
    Color? currentItemBorderColor,
    double? currentItemBorderWidth,
    TextStyle? currentItemStyle,
    TextStyle? clickableItemStyle,
    TextStyle? itemStyle,
    Color? currentIconColor,
    Color? clickableIconColor,
    Color? iconColor,
    double? iconSize,
    double? iconTextSpacing,
    IconData? separatorIcon,
    Color? separatorColor,
    double? separatorSize,
    EdgeInsets? itemPadding,
  }) {
    return ZephyrBreadcrumbTheme(
      padding: padding ?? this.padding,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      spacing: spacing ?? this.spacing,
      itemBorderRadius: itemBorderRadius ?? this.itemBorderRadius,
      currentItemBackgroundColor: currentItemBackgroundColor ?? this.currentItemBackgroundColor,
      currentItemBorderColor: currentItemBorderColor ?? this.currentItemBorderColor,
      currentItemBorderWidth: currentItemBorderWidth ?? this.currentItemBorderWidth,
      currentItemStyle: currentItemStyle ?? this.currentItemStyle,
      clickableItemStyle: clickableItemStyle ?? this.clickableItemStyle,
      itemStyle: itemStyle ?? this.itemStyle,
      currentIconColor: currentIconColor ?? this.currentIconColor,
      clickableIconColor: clickableIconColor ?? this.clickableIconColor,
      iconColor: iconColor ?? this.iconColor,
      iconSize: iconSize ?? this.iconSize,
      iconTextSpacing: iconTextSpacing ?? this.iconTextSpacing,
      separatorIcon: separatorIcon ?? this.separatorIcon,
      separatorColor: separatorColor ?? this.separatorColor,
      separatorSize: separatorSize ?? this.separatorSize,
      itemPadding: itemPadding ?? this.itemPadding,
    );
  }

  /// Merge with another theme
  ZephyrBreadcrumbTheme merge(ZephyrBreadcrumbTheme other) {
    return copyWith(
      padding: other.padding,
      backgroundColor: other.backgroundColor,
      borderRadius: other.borderRadius,
      borderColor: other.borderColor,
      borderWidth: other.borderWidth,
      spacing: other.spacing,
      itemBorderRadius: other.itemBorderRadius,
      currentItemBackgroundColor: other.currentItemBackgroundColor,
      currentItemBorderColor: other.currentItemBorderColor,
      currentItemBorderWidth: other.currentItemBorderWidth,
      currentItemStyle: other.currentItemStyle,
      clickableItemStyle: other.clickableItemStyle,
      itemStyle: other.itemStyle,
      currentIconColor: other.currentIconColor,
      clickableIconColor: other.clickableIconColor,
      iconColor: other.iconColor,
      iconSize: other.iconSize,
      iconTextSpacing: other.iconTextSpacing,
      separatorIcon: other.separatorIcon,
      separatorColor: other.separatorColor,
      separatorSize: other.separatorSize,
      itemPadding: other.itemPadding,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ZephyrBreadcrumbTheme &&
        other.padding == padding &&
        other.backgroundColor == backgroundColor &&
        other.borderRadius == borderRadius &&
        other.borderColor == borderColor &&
        other.borderWidth == borderWidth &&
        other.spacing == spacing &&
        other.itemBorderRadius == itemBorderRadius &&
        other.currentItemBackgroundColor == currentItemBackgroundColor &&
        other.currentItemBorderColor == currentItemBorderColor &&
        other.currentItemBorderWidth == currentItemBorderWidth &&
        other.currentItemStyle == currentItemStyle &&
        other.clickableItemStyle == clickableItemStyle &&
        other.itemStyle == itemStyle &&
        other.currentIconColor == currentIconColor &&
        other.clickableIconColor == clickableIconColor &&
        other.iconColor == iconColor &&
        other.iconSize == iconSize &&
        other.iconTextSpacing == iconTextSpacing &&
        other.separatorIcon == separatorIcon &&
        other.separatorColor == separatorColor &&
        other.separatorSize == separatorSize &&
        other.itemPadding == itemPadding;
  }

  @override
  int get hashCode {
    return Object.hash(
      padding,
      backgroundColor,
      borderRadius,
      borderColor,
      borderWidth,
      spacing,
      itemBorderRadius,
      currentItemBackgroundColor,
      currentItemBorderColor,
      currentItemBorderWidth,
      currentItemStyle,
      clickableItemStyle,
      itemStyle,
      currentIconColor,
      clickableIconColor,
      iconColor,
      iconSize,
      iconTextSpacing,
      separatorIcon,
      separatorColor,
    );
  }
}