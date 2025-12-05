library velocity_tooltip_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocityTooltipStyle {
  const VelocityTooltipStyle({
    this.backgroundColor = VelocityColors.gray900,
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
    this.boxShadow,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.margin = const EdgeInsets.all(8),
    this.textStyle = const TextStyle(fontSize: 13, color: VelocityColors.white),
    this.verticalOffset = 12,
    this.waitDuration = const Duration(milliseconds: 500),
    this.showDuration = const Duration(seconds: 2),
  });

  final Color backgroundColor;
  final BorderRadius borderRadius;
  final List<BoxShadow>? boxShadow;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final TextStyle textStyle;
  final double verticalOffset;
  final Duration waitDuration;
  final Duration showDuration;
}
