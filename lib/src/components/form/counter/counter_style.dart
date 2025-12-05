library velocity_counter_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocityCounterStyle {
  const VelocityCounterStyle({
    this.height = 32,
    this.buttonSize = 32,
    this.inputWidth = 48,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
    this.borderColor = VelocityColors.gray300,
    this.buttonBackgroundColor = VelocityColors.gray100,
    this.disabledButtonColor = VelocityColors.gray50,
    this.inputBackgroundColor = VelocityColors.white,
    this.iconSize = 18,
    this.iconColor = VelocityColors.gray700,
    this.disabledIconColor = VelocityColors.gray300,
    this.inputStyle = const TextStyle(fontSize: 14, color: VelocityColors.gray900),
  });

  final double height;
  final double buttonSize;
  final double inputWidth;
  final BorderRadius borderRadius;
  final Color borderColor;
  final Color buttonBackgroundColor;
  final Color disabledButtonColor;
  final Color inputBackgroundColor;
  final double iconSize;
  final Color iconColor;
  final Color disabledIconColor;
  final TextStyle inputStyle;
}
