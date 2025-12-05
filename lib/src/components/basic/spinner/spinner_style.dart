library velocity_spinner_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocitySpinnerStyle {
  const VelocitySpinnerStyle({
    this.color = VelocityColors.primary,
    this.strokeWidth = 3,
  });

  final Color color;
  final double strokeWidth;
}
