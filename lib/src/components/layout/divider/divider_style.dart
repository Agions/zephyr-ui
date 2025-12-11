/// VelocityUI 分隔线样式
library velocity_divider_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocityDividerStyle {
  const VelocityDividerStyle(
      {this.color, this.thickness, this.length, this.margin});

  factory VelocityDividerStyle.defaults() {
    return const VelocityDividerStyle(
        color: VelocityColors.gray200,
        thickness: 1,
        margin: EdgeInsets.symmetric(vertical: 8));
  }
  final Color? color;
  final double? thickness;
  final double? length;
  final EdgeInsets? margin;
}
