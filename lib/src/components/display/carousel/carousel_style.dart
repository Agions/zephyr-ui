library velocity_carousel_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocityCarouselStyle {
  const VelocityCarouselStyle({
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.indicatorSize = 6,
    this.activeIndicatorWidth = 18,
    this.indicatorSpacing = 8,
    this.indicatorBottom = 16,
    this.indicatorColor = VelocityColors.white,
    this.activeIndicatorColor = VelocityColors.primary,
  });

  final BorderRadius borderRadius;
  final EdgeInsets itemPadding;
  final double indicatorSize;
  final double activeIndicatorWidth;
  final double indicatorSpacing;
  final double indicatorBottom;
  final Color indicatorColor;
  final Color activeIndicatorColor;
}
