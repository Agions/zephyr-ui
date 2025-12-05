library velocity_empty_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocityEmptyStyle {
  const VelocityEmptyStyle({
    this.iconSize = 64,
    this.iconColor = VelocityColors.gray300,
    this.titleStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: VelocityColors.gray600),
    this.descriptionStyle = const TextStyle(fontSize: 14, color: VelocityColors.gray400),
    this.actionStyle = const TextStyle(fontSize: 14, color: VelocityColors.primary),
    this.padding = const EdgeInsets.all(32),
    this.spacing = 16,
    this.actionSpacing = 24,
  });

  final double iconSize;
  final Color iconColor;
  final TextStyle titleStyle;
  final TextStyle descriptionStyle;
  final TextStyle actionStyle;
  final EdgeInsets padding;
  final double spacing;
  final double actionSpacing;
}
