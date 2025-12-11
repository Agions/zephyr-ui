/// VelocityUI 导航栏样式
library velocity_navbar_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocityNavbarStyle {
  const VelocityNavbarStyle({
    this.backgroundColor = VelocityColors.white,
    this.foregroundColor = VelocityColors.gray900,
    this.titleStyle =
        const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    this.elevation = 0.5,
    this.shadowColor,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final TextStyle titleStyle;
  final double elevation;
  final Color? shadowColor;
}

class VelocityBottomNavbarStyle {
  const VelocityBottomNavbarStyle({
    this.backgroundColor = VelocityColors.white,
    this.selectedColor = VelocityColors.primary,
    this.unselectedColor = VelocityColors.gray500,
    this.selectedFontSize = 12,
    this.unselectedFontSize = 12,
    this.elevation = 8,
  });

  final Color backgroundColor;
  final Color selectedColor;
  final Color unselectedColor;
  final double selectedFontSize;
  final double unselectedFontSize;
  final double elevation;
}
