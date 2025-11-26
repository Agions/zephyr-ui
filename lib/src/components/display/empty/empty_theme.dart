import 'package:flutter/material.dart';

class ZephyrEmptyTheme {
  const ZephyrEmptyTheme({
    this.imageColor,
    this.imageBackgroundColor,
    this.titleStyle,
    this.descriptionStyle,
  });

  final Color? imageColor;
  final Color? imageBackgroundColor;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;

  static ZephyrEmptyTheme of(BuildContext context) {
    final theme = Theme.of(context);
    return ZephyrEmptyTheme(
      imageColor: theme.colorScheme.onSurface.withValues(alpha: 0.3),
      imageBackgroundColor:
          theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      titleStyle: theme.textTheme.titleMedium?.copyWith(
        color: theme.colorScheme.onSurface,
        fontWeight: FontWeight.w500,
      ),
      descriptionStyle: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }

  ZephyrEmptyTheme copyWith({
    Color? imageColor,
    Color? imageBackgroundColor,
    TextStyle? titleStyle,
    TextStyle? descriptionStyle,
  }) {
    return ZephyrEmptyTheme(
      imageColor: imageColor ?? this.imageColor,
      imageBackgroundColor: imageBackgroundColor ?? this.imageBackgroundColor,
      titleStyle: titleStyle ?? this.titleStyle,
      descriptionStyle: descriptionStyle ?? this.descriptionStyle,
    );
  }
}
