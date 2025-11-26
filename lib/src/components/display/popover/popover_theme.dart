import 'package:flutter/material.dart';

class ZephyrPopoverTheme {
  const ZephyrPopoverTheme({
    this.backgroundColor,
    this.borderColor,
    this.titleStyle,
    this.contentStyle,
    this.borderRadius,
    this.padding,
    this.elevation,
    this.boxShadow,
  });

  final Color? backgroundColor;
  final Color? borderColor;
  final TextStyle? titleStyle;
  final TextStyle? contentStyle;
  final double? borderRadius;
  final EdgeInsets? padding;
  final double? elevation;
  final List<BoxShadow>? boxShadow;

  static ZephyrPopoverTheme of(BuildContext context) {
    final theme = Theme.of(context);
    return ZephyrPopoverTheme(
      backgroundColor: theme.colorScheme.surface,
      borderColor: theme.colorScheme.outline,
      titleStyle: theme.textTheme.titleMedium?.copyWith(
        color: theme.colorScheme.onSurface,
        fontWeight: FontWeight.w600,
      ),
      contentStyle: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurface,
      ),
      borderRadius: 8.0,
      padding: const EdgeInsets.all(16),
      elevation: 8.0,
      boxShadow: [
        const BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
        const BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }

  ZephyrPopoverTheme copyWith({
    Color? backgroundColor,
    Color? borderColor,
    TextStyle? titleStyle,
    TextStyle? contentStyle,
    double? borderRadius,
    EdgeInsets? padding,
    double? elevation,
    List<BoxShadow>? boxShadow,
  }) {
    return ZephyrPopoverTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      titleStyle: titleStyle ?? this.titleStyle,
      contentStyle: contentStyle ?? this.contentStyle,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      elevation: elevation ?? this.elevation,
      boxShadow: boxShadow ?? this.boxShadow,
    );
  }
}
