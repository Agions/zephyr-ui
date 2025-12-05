library velocity_list_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocityListTileStyle {
  const VelocityListTileStyle({
    this.backgroundColor = VelocityColors.white,
    this.selectedColor = VelocityColors.primaryLight,
    this.splashColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.densePadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.titleStyle = const TextStyle(fontSize: 16, color: VelocityColors.gray900),
    this.subtitleStyle = const TextStyle(fontSize: 14, color: VelocityColors.gray500),
    this.leadingSpacing = 16,
    this.trailingSpacing = 16,
    this.subtitleSpacing = 4,
  });

  final Color backgroundColor;
  final Color selectedColor;
  final Color? splashColor;
  final EdgeInsets padding;
  final EdgeInsets densePadding;
  final TextStyle titleStyle;
  final TextStyle subtitleStyle;
  final double leadingSpacing;
  final double trailingSpacing;
  final double subtitleSpacing;
}

class VelocityListGroupStyle {
  const VelocityListGroupStyle({
    this.backgroundColor = VelocityColors.white,
    this.borderRadius,
    this.headerStyle = const TextStyle(fontSize: 13, color: VelocityColors.gray500, fontWeight: FontWeight.w500),
    this.headerPadding = const EdgeInsets.only(left: 16, bottom: 8, top: 16),
    this.dividerColor = VelocityColors.gray200,
    this.dividerIndent = 16,
  });

  final Color backgroundColor;
  final BorderRadius? borderRadius;
  final TextStyle headerStyle;
  final EdgeInsets headerPadding;
  final Color dividerColor;
  final double dividerIndent;
}
