library velocity_slider_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocitySliderStyle {
  const VelocitySliderStyle({
    this.activeColor = VelocityColors.primary,
    this.inactiveColor = VelocityColors.gray200,
    this.thumbColor = VelocityColors.primary,
    this.disabledActiveColor = VelocityColors.gray400,
    this.disabledInactiveColor = VelocityColors.gray200,
    this.disabledThumbColor = VelocityColors.gray400,
    this.overlayColor,
    this.trackHeight = 4,
    this.thumbRadius = 10,
    this.overlayRadius = 20,
    this.labelStyle =
        const TextStyle(fontSize: 12, color: VelocityColors.white),
  });

  final Color activeColor;
  final Color inactiveColor;
  final Color thumbColor;
  final Color disabledActiveColor;
  final Color disabledInactiveColor;
  final Color disabledThumbColor;
  final Color? overlayColor;
  final double trackHeight;
  final double thumbRadius;
  final double overlayRadius;
  final TextStyle labelStyle;
}
