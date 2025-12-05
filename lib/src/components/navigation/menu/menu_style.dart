library velocity_menu_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocityMenuStyle {
  const VelocityMenuStyle({
    this.backgroundColor = VelocityColors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.labelStyle = const TextStyle(fontSize: 14, color: VelocityColors.gray900),
    this.disabledStyle = const TextStyle(fontSize: 14, color: VelocityColors.gray400),
    this.iconSize = 20,
    this.iconColor = VelocityColors.gray600,
    this.disabledColor = VelocityColors.gray400,
    this.iconSpacing = 12,
  });
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final EdgeInsets itemPadding;
  final TextStyle labelStyle;
  final TextStyle disabledStyle;
  final double iconSize;
  final Color iconColor;
  final Color disabledColor;
  final double iconSpacing;
}
