import 'package:flutter/material.dart';

class ZephyrTooltipTheme {
  const ZephyrTooltipTheme({
    this.backgroundColor,
    this.textStyle,
    this.borderRadius,
    this.arrowSize,
    this.padding,
  });

  final Color? backgroundColor;
  final TextStyle? textStyle;
  final double? borderRadius;
  final double? arrowSize;
  final EdgeInsets? padding;

  static ZephyrTooltipTheme of(BuildContext context) {
    final theme = Theme.of(context);
    return ZephyrTooltipTheme(
      backgroundColor: theme.colorScheme.inverseSurface,
      textStyle: theme.textTheme.bodySmall?.copyWith(
        color: theme.colorScheme.onInverseSurface,
      ),
      borderRadius: 6.0,
      arrowSize: 8.0,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }

  ZephyrTooltipTheme copyWith({
    Color? backgroundColor,
    TextStyle? textStyle,
    double? borderRadius,
    double? arrowSize,
    EdgeInsets? padding,
  }) {
    return ZephyrTooltipTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textStyle: textStyle ?? this.textStyle,
      borderRadius: borderRadius ?? this.borderRadius,
      arrowSize: arrowSize ?? this.arrowSize,
      padding: padding ?? this.padding,
    );
  }
}
