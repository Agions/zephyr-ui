library velocity_segmented_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocitySegmentedStyle {
  const VelocitySegmentedStyle({
    this.backgroundColor = VelocityColors.gray100,
    this.activeBackgroundColor = VelocityColors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.segmentBorderRadius = const BorderRadius.all(Radius.circular(6)),
    this.padding = const EdgeInsets.all(4),
    this.segmentPadding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.textStyle =
        const TextStyle(fontSize: 14, color: VelocityColors.gray600),
    this.activeTextStyle = const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: VelocityColors.gray900),
    this.textColor = VelocityColors.gray600,
    this.activeTextColor = VelocityColors.gray900,
    this.iconSize = 18,
    this.iconSpacing = 6,
    this.animationDuration = const Duration(milliseconds: 200),
    this.activeShadow = const [
      BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 1))
    ],
  });
  final Color backgroundColor;
  final Color activeBackgroundColor;
  final BorderRadius borderRadius;
  final BorderRadius segmentBorderRadius;
  final EdgeInsets padding;
  final EdgeInsets segmentPadding;
  final TextStyle textStyle;
  final TextStyle activeTextStyle;
  final Color textColor;
  final Color activeTextColor;
  final double iconSize;
  final double iconSpacing;
  final Duration animationDuration;
  final List<BoxShadow>? activeShadow;
}
