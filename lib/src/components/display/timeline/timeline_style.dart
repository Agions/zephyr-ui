library velocity_timeline_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocityTimelineStyle {
  const VelocityTimelineStyle({
    this.dotSize = 12,
    this.dotColor = VelocityColors.primary,
    this.lineWidth = 2,
    this.lineColor = VelocityColors.gray200,
    this.lineOffset = 24,
    this.contentSpacing = 16,
    this.itemSpacing = 24,
    this.labelStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: VelocityColors.gray900),
    this.timeStyle = const TextStyle(fontSize: 12, color: VelocityColors.gray500),
  });

  final double dotSize;
  final Color dotColor;
  final double lineWidth;
  final Color lineColor;
  final double lineOffset;
  final double contentSpacing;
  final double itemSpacing;
  final TextStyle labelStyle;
  final TextStyle timeStyle;
}
