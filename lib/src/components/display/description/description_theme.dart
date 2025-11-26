import 'package:flutter/material.dart';

enum ZephyrDescriptionSize {
  small,
  defaultSize,
  large,
}

enum ZephyrDescriptionLayout {
  horizontal,
  vertical,
}

class ZephyrDescriptionTheme {
  const ZephyrDescriptionTheme({
    this.borderColor,
    this.borderRadius,
    this.headerBackgroundColor,
    this.labelStyle,
    this.contentStyle,
    this.smallLabelStyle,
    this.smallContentStyle,
    this.largeLabelStyle,
    this.largeContentStyle,
  });

  final Color? borderColor;
  final double? borderRadius;
  final Color? headerBackgroundColor;
  final TextStyle? labelStyle;
  final TextStyle? contentStyle;
  final TextStyle? smallLabelStyle;
  final TextStyle? smallContentStyle;
  final TextStyle? largeLabelStyle;
  final TextStyle? largeContentStyle;

  static ZephyrDescriptionTheme of(BuildContext context) {
    final theme = Theme.of(context);
    return ZephyrDescriptionTheme(
      borderColor: theme.colorScheme.outline,
      borderRadius: 8.0,
      headerBackgroundColor: theme.colorScheme.surfaceContainerHighest,
      labelStyle: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w500,
      ),
      contentStyle: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurface,
      ),
      smallLabelStyle: theme.textTheme.bodySmall?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w500,
      ),
      smallContentStyle: theme.textTheme.bodySmall?.copyWith(
        color: theme.colorScheme.onSurface,
      ),
      largeLabelStyle: theme.textTheme.titleSmall?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w500,
      ),
      largeContentStyle: theme.textTheme.titleSmall?.copyWith(
        color: theme.colorScheme.onSurface,
      ),
    );
  }

  TextStyle getLabelStyle(ZephyrDescriptionSize size) {
    switch (size) {
      case ZephyrDescriptionSize.small:
        return smallLabelStyle!;
      case ZephyrDescriptionSize.defaultSize:
        return labelStyle!;
      case ZephyrDescriptionSize.large:
        return largeLabelStyle!;
    }
  }

  TextStyle getContentStyle(ZephyrDescriptionSize size) {
    switch (size) {
      case ZephyrDescriptionSize.small:
        return smallContentStyle!;
      case ZephyrDescriptionSize.defaultSize:
        return contentStyle!;
      case ZephyrDescriptionSize.large:
        return largeContentStyle!;
    }
  }

  ZephyrDescriptionTheme copyWith({
    Color? borderColor,
    double? borderRadius,
    Color? headerBackgroundColor,
    TextStyle? labelStyle,
    TextStyle? contentStyle,
    TextStyle? smallLabelStyle,
    TextStyle? smallContentStyle,
    TextStyle? largeLabelStyle,
    TextStyle? largeContentStyle,
  }) {
    return ZephyrDescriptionTheme(
      borderColor: borderColor ?? this.borderColor,
      borderRadius: borderRadius ?? this.borderRadius,
      headerBackgroundColor:
          headerBackgroundColor ?? this.headerBackgroundColor,
      labelStyle: labelStyle ?? this.labelStyle,
      contentStyle: contentStyle ?? this.contentStyle,
      smallLabelStyle: smallLabelStyle ?? this.smallLabelStyle,
      smallContentStyle: smallContentStyle ?? this.smallContentStyle,
      largeLabelStyle: largeLabelStyle ?? this.largeLabelStyle,
      largeContentStyle: largeContentStyle ?? this.largeContentStyle,
    );
  }
}
