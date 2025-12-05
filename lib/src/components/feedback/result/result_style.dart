library velocity_result_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocityResultStyle {
  const VelocityResultStyle({
    this.iconSize = 72,
    this.titleStyle = const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: VelocityColors.gray900),
    this.subtitleStyle = const TextStyle(fontSize: 14, color: VelocityColors.gray500),
    this.padding = const EdgeInsets.all(32),
    this.spacing = 24,
    this.subtitleSpacing = 8,
    this.actionSpacing = 32,
  });

  final double iconSize;
  final TextStyle titleStyle;
  final TextStyle subtitleStyle;
  final EdgeInsets padding;
  final double spacing;
  final double subtitleSpacing;
  final double actionSpacing;
}
