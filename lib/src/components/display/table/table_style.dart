library velocity_table_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocityTableStyle {
  const VelocityTableStyle({
    this.headerBackgroundColor = VelocityColors.gray100,
    this.rowBackgroundColor = VelocityColors.white,
    this.stripedColor = VelocityColors.gray50,
    this.borderColor = VelocityColors.gray200,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.cellPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.headerTextStyle = const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: VelocityColors.gray700),
    this.cellTextStyle =
        const TextStyle(fontSize: 14, color: VelocityColors.gray900),
  });

  final Color headerBackgroundColor;
  final Color rowBackgroundColor;
  final Color stripedColor;
  final Color borderColor;
  final BorderRadius borderRadius;
  final EdgeInsets cellPadding;
  final TextStyle headerTextStyle;
  final TextStyle cellTextStyle;
}
