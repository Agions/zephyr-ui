library velocity_select_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocitySelectStyle {
  const VelocitySelectStyle({
    this.backgroundColor = VelocityColors.white,
    this.disabledBackgroundColor = VelocityColors.gray100,
    this.dropdownColor = VelocityColors.white,
    this.borderColor = VelocityColors.gray300,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.padding = const EdgeInsets.symmetric(horizontal: 12),
    this.labelStyle = const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: VelocityColors.gray700),
    this.labelSpacing = 6,
    this.hintStyle = const TextStyle(fontSize: 14, color: VelocityColors.gray400),
    this.itemStyle = const TextStyle(fontSize: 14, color: VelocityColors.gray900),
    this.disabledItemStyle = const TextStyle(fontSize: 14, color: VelocityColors.gray400),
    this.iconColor = VelocityColors.gray500,
  });

  final Color backgroundColor;
  final Color disabledBackgroundColor;
  final Color dropdownColor;
  final Color borderColor;
  final BorderRadius borderRadius;
  final EdgeInsets padding;
  final TextStyle labelStyle;
  final double labelSpacing;
  final TextStyle hintStyle;
  final TextStyle itemStyle;
  final TextStyle disabledItemStyle;
  final Color iconColor;
}
