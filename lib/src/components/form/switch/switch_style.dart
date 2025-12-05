/// VelocityUI 开关样式
library velocity_switch_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocitySwitchStyle {
  const VelocitySwitchStyle({
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.thumbColor,
    this.labelStyle,
    this.disabledLabelColor,
    this.labelSpacing,
  });

  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final Color? thumbColor;
  final TextStyle? labelStyle;
  final Color? disabledLabelColor;
  final double? labelSpacing;

  factory VelocitySwitchStyle.defaults() {
    return VelocitySwitchStyle(
      activeTrackColor: VelocityColors.primary,
      inactiveTrackColor: VelocityColors.gray300,
      thumbColor: VelocityColors.white,
      labelStyle: const TextStyle(fontSize: 14, color: VelocityColors.gray700),
      disabledLabelColor: VelocityColors.gray400,
      labelSpacing: 8,
    );
  }
}
