library velocity_progress_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocityProgressStyle {
  const VelocityProgressStyle({
    this.color = VelocityColors.primary,
    this.backgroundColor = VelocityColors.gray200,
    this.height = 8,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
    this.gradient,
    this.circularSize = 48,
    this.strokeWidth = 4,
    this.labelStyle = const TextStyle(fontSize: 12, color: VelocityColors.gray600),
    this.labelSpacing = 8,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  final Color color;
  final Color backgroundColor;
  final double height;
  final BorderRadius borderRadius;
  final Gradient? gradient;
  final double circularSize;
  final double strokeWidth;
  final TextStyle labelStyle;
  final double labelSpacing;
  final Duration animationDuration;
}

class VelocityStepProgressStyle {
  const VelocityStepProgressStyle({
    this.activeColor = VelocityColors.primary,
    this.inactiveColor = VelocityColors.gray200,
    this.borderColor = VelocityColors.gray400,
    this.stepSize = 24,
    this.labelStyle = const TextStyle(fontSize: 12),
  });

  final Color activeColor;
  final Color inactiveColor;
  final Color borderColor;
  final double stepSize;
  final TextStyle labelStyle;
}
