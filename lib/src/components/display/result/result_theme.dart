import 'package:flutter/material.dart';
import 'result_types.dart';

class ZephyrResultTheme {
  const ZephyrResultTheme({
    this.successColor,
    this.errorColor,
    this.warningColor,
    this.infoColor,
    this.titleStyle,
    this.descriptionStyle,
  });

  final Color? successColor;
  final Color? errorColor;
  final Color? warningColor;
  final Color? infoColor;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;

  static ZephyrResultTheme of(BuildContext context) {
    final theme = Theme.of(context);
    return ZephyrResultTheme(
      successColor: theme.colorScheme.primary,
      errorColor: theme.colorScheme.error,
      warningColor: theme.colorScheme.tertiary,
      infoColor: theme.colorScheme.primary,
      titleStyle: theme.textTheme.titleLarge?.copyWith(
        color: theme.colorScheme.onSurface,
        fontWeight: FontWeight.w600,
      ),
      descriptionStyle: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }

  TextStyle getTitleStyle(ZephyrResultStatus status) {
    Color color;
    switch (status) {
      case ZephyrResultStatus.success:
        color = successColor!;
        break;
      case ZephyrResultStatus.error:
        color = errorColor!;
        break;
      case ZephyrResultStatus.warning:
        color = warningColor!;
        break;
      case ZephyrResultStatus.info:
      case ZephyrResultStatus.loading:
        color = infoColor!;
        break;
    }

    return titleStyle!.copyWith(color: color);
  }

  TextStyle getDescriptionStyle(ZephyrResultStatus status) {
    return descriptionStyle!;
  }

  ZephyrResultTheme copyWith({
    Color? successColor,
    Color? errorColor,
    Color? warningColor,
    Color? infoColor,
    TextStyle? titleStyle,
    TextStyle? descriptionStyle,
  }) {
    return ZephyrResultTheme(
      successColor: successColor ?? this.successColor,
      errorColor: errorColor ?? this.errorColor,
      warningColor: warningColor ?? this.warningColor,
      infoColor: infoColor ?? this.infoColor,
      titleStyle: titleStyle ?? this.titleStyle,
      descriptionStyle: descriptionStyle ?? this.descriptionStyle,
    );
  }
}
