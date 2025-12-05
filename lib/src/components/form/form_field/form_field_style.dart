library velocity_form_field_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocityFormFieldStyle {
  const VelocityFormFieldStyle({
    this.labelStyle = const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: VelocityColors.gray700),
    this.helperStyle = const TextStyle(fontSize: 12, color: VelocityColors.gray500),
    this.errorStyle = const TextStyle(fontSize: 12, color: VelocityColors.error),
    this.requiredColor = VelocityColors.error,
    this.labelSpacing = 6,
    this.helperSpacing = 4,
    this.labelWidth = 100,
    this.horizontalLabelOffset = 10,
  });

  final TextStyle labelStyle;
  final TextStyle helperStyle;
  final TextStyle errorStyle;
  final Color requiredColor;
  final double labelSpacing;
  final double helperSpacing;
  final double labelWidth;
  final double horizontalLabelOffset;
}
