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

  factory VelocitySwitchStyle.defaults() {
    return const VelocitySwitchStyle(
      activeTrackColor: VelocityColors.primary,
      inactiveTrackColor: VelocityColors.gray300,
      thumbColor: VelocityColors.white,
      labelStyle: TextStyle(fontSize: 14, color: VelocityColors.gray700),
      disabledLabelColor: VelocityColors.gray400,
      labelSpacing: 8,
    );
  }

  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final Color? thumbColor;
  final TextStyle? labelStyle;
  final Color? disabledLabelColor;
  final double? labelSpacing;
}
