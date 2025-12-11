library velocity_action_sheet_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocityActionSheetStyle {
  const VelocityActionSheetStyle({
    this.backgroundColor = VelocityColors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.margin = const EdgeInsets.all(8),
    this.headerPadding = const EdgeInsets.all(16),
    this.actionPadding = const EdgeInsets.symmetric(vertical: 16),
    this.titleStyle = const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: VelocityColors.gray700),
    this.messageStyle =
        const TextStyle(fontSize: 13, color: VelocityColors.gray500),
    this.actionStyle =
        const TextStyle(fontSize: 18, color: VelocityColors.primary),
    this.destructiveStyle =
        const TextStyle(fontSize: 18, color: VelocityColors.error),
    this.cancelStyle = const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: VelocityColors.primary),
    this.dividerColor = VelocityColors.gray200,
    this.cancelSpacing = 8,
  });

  final Color backgroundColor;
  final BorderRadius borderRadius;
  final EdgeInsets margin;
  final EdgeInsets headerPadding;
  final EdgeInsets actionPadding;
  final TextStyle titleStyle;
  final TextStyle messageStyle;
  final TextStyle actionStyle;
  final TextStyle destructiveStyle;
  final TextStyle cancelStyle;
  final Color dividerColor;
  final double cancelSpacing;
}
