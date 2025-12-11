/// VelocityUI 单选框样式
library velocity_radio_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocityRadioStyle {
  const VelocityRadioStyle({
    this.activeColor,
    this.inactiveColor,
    this.disabledColor,
    this.labelStyle,
    this.disabledLabelColor,
    this.labelSpacing,
  });

  factory VelocityRadioStyle.defaults() {
    return const VelocityRadioStyle(
      activeColor: VelocityColors.primary,
      inactiveColor: VelocityColors.gray400,
      disabledColor: VelocityColors.gray300,
      labelStyle: TextStyle(fontSize: 14, color: VelocityColors.gray700),
      disabledLabelColor: VelocityColors.gray400,
      labelSpacing: 8,
    );
  }

  final Color? activeColor;
  final Color? inactiveColor;
  final Color? disabledColor;
  final TextStyle? labelStyle;
  final Color? disabledLabelColor;
  final double? labelSpacing;
}
