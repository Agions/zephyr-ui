library velocity_stepper_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocityStepperStyle {
  const VelocityStepperStyle({
    this.iconSize = 28,
    this.connectorThickness = 2,
    this.labelSpacing = 8,
    this.finishColor = VelocityColors.success,
    this.processColor = VelocityColors.primary,
    this.waitColor = VelocityColors.gray400,
    this.errorColor = VelocityColors.error,
    this.titleStyle = const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    this.subtitleStyle = const TextStyle(fontSize: 12, color: VelocityColors.gray500),
  });

  final double iconSize;
  final double connectorThickness;
  final double labelSpacing;
  final Color finishColor;
  final Color processColor;
  final Color waitColor;
  final Color errorColor;
  final TextStyle titleStyle;
  final TextStyle subtitleStyle;
}
