library velocity_collapse_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocityCollapseStyle {
  const VelocityCollapseStyle({
    this.backgroundColor = VelocityColors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.border,
    this.headerPadding = const EdgeInsets.all(16),
    this.contentPadding = const EdgeInsets.fromLTRB(16, 0, 16, 16),
    this.titleStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: VelocityColors.gray900),
    this.iconColor = VelocityColors.gray500,
    this.iconSize = 24,
    this.leadingSpacing = 12,
  });

  final Color backgroundColor;
  final BorderRadius borderRadius;
  final Border? border;
  final EdgeInsets headerPadding;
  final EdgeInsets contentPadding;
  final TextStyle titleStyle;
  final Color iconColor;
  final double iconSize;
  final double leadingSpacing;
}
