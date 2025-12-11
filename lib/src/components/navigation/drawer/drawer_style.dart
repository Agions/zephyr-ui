library velocity_drawer_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocityDrawerStyle {
  const VelocityDrawerStyle({
    this.backgroundColor = VelocityColors.white,
    this.width = 280,
    this.itemsPadding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.labelStyle =
        const TextStyle(fontSize: 14, color: VelocityColors.gray700),
    this.selectedLabelStyle = const TextStyle(
        fontSize: 14,
        color: VelocityColors.primary,
        fontWeight: FontWeight.w500),
    this.iconColor = VelocityColors.gray500,
    this.selectedColor = VelocityColors.primary,
    this.selectedBackgroundColor = VelocityColors.primaryLight,
    this.itemBorderRadius = const BorderRadius.all(Radius.circular(8)),
    this.dividerColor = VelocityColors.gray200,
    this.dividerHeight = 16,
  });

  final Color backgroundColor;
  final double width;
  final EdgeInsets itemsPadding;
  final TextStyle labelStyle;
  final TextStyle selectedLabelStyle;
  final Color iconColor;
  final Color selectedColor;
  final Color selectedBackgroundColor;
  final BorderRadius itemBorderRadius;
  final Color dividerColor;
  final double dividerHeight;
}
