/// VelocityUI 复选框样式
library velocity_checkbox_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocityCheckboxStyle {
  const VelocityCheckboxStyle({
    this.activeColor = VelocityColors.primary,
    this.checkColor = VelocityColors.white,
    this.borderColor = VelocityColors.gray400,
    this.disabledBorderColor = VelocityColors.gray300,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
    this.labelStyle = const TextStyle(fontSize: 14, color: VelocityColors.gray700),
    this.disabledLabelColor = VelocityColors.gray400,
    this.labelSpacing = 8,
  });

  final Color activeColor;
  final Color checkColor;
  final Color borderColor;
  final Color disabledBorderColor;
  final BorderRadius borderRadius;
  final TextStyle labelStyle;
  final Color disabledLabelColor;
  final double labelSpacing;
}
