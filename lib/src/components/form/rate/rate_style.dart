library velocity_rate_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocityRateStyle {
  const VelocityRateStyle({
    this.size = 24,
    this.spacing = 4,
    this.activeColor = VelocityColors.warning,
    this.inactiveColor = VelocityColors.gray300,
    this.disabledColor = VelocityColors.gray400,
    this.defaultIcon = Icons.star,
  });

  final double size;
  final double spacing;
  final Color activeColor;
  final Color inactiveColor;
  final Color disabledColor;
  final IconData defaultIcon;
}
