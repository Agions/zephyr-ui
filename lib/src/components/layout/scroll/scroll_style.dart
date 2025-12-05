library velocity_scroll_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocityScrollToTopStyle {
  const VelocityScrollToTopStyle({
    this.backgroundColor = VelocityColors.primary,
    this.iconColor = VelocityColors.white,
    this.right = 16,
    this.bottom = 16,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  final Color backgroundColor;
  final Color iconColor;
  final double right;
  final double bottom;
  final Duration animationDuration;
}
