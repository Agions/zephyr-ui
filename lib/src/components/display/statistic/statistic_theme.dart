import 'package:flutter/material.dart';

class ZephyrStatisticTheme {
  const ZephyrStatisticTheme({
    this.titleStyle,
    this.valueStyle,
    this.descriptionStyle,
    this.cardPadding = const EdgeInsets.all(16),
  });

  final TextStyle? titleStyle;
  final TextStyle? valueStyle;
  final TextStyle? descriptionStyle;
  final EdgeInsetsGeometry cardPadding;
}
