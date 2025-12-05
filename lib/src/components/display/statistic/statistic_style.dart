library velocity_statistic_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocityStatisticStyle {
  const VelocityStatisticStyle({
    this.titleStyle = const TextStyle(fontSize: 14, color: VelocityColors.gray500),
    this.valueStyle = const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: VelocityColors.gray900),
    this.suffixStyle = const TextStyle(fontSize: 14, color: VelocityColors.gray600),
    this.trendStyle = const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    this.titleSpacing = 8,
    this.prefixSpacing = 4,
    this.suffixSpacing = 4,
    this.trendSpacing = 8,
    this.trendIconSize = 16,
    this.upColor = VelocityColors.success,
    this.downColor = VelocityColors.error,
  });

  final TextStyle titleStyle;
  final TextStyle valueStyle;
  final TextStyle suffixStyle;
  final TextStyle trendStyle;
  final double titleSpacing;
  final double prefixSpacing;
  final double suffixSpacing;
  final double trendSpacing;
  final double trendIconSize;
  final Color upColor;
  final Color downColor;
}

class VelocityCountdownStyle {
  const VelocityCountdownStyle({
    this.textStyle = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: VelocityColors.gray900),
  });

  final TextStyle textStyle;
}
