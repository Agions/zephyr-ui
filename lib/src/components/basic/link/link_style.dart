library velocity_link_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocityLinkStyle {
  const VelocityLinkStyle({
    this.color = VelocityColors.primary,
    this.disabledColor = VelocityColors.gray400,
    this.textStyle = const TextStyle(fontSize: 14),
    this.iconSize = 16,
    this.iconSpacing = 4,
  });
  final Color color;
  final Color disabledColor;
  final TextStyle textStyle;
  final double iconSize;
  final double iconSpacing;
}
