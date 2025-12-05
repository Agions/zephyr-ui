library velocity_search_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocitySearchStyle {
  const VelocitySearchStyle({
    this.height = 40,
    this.backgroundColor = VelocityColors.gray100,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.borderColor = Colors.transparent,
    this.iconSize = 20,
    this.iconColor = VelocityColors.gray400,
    this.iconPadding = 12,
    this.clearIconSize = 18,
    this.clearIconColor = VelocityColors.gray400,
    this.textStyle = const TextStyle(fontSize: 15, color: VelocityColors.gray900),
    this.placeholderStyle = const TextStyle(fontSize: 15, color: VelocityColors.gray400),
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
    this.cancelStyle = const TextStyle(fontSize: 15, color: VelocityColors.primary),
    this.cancelSpacing = 12,
  });

  final double height;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final Color borderColor;
  final double iconSize;
  final Color iconColor;
  final double iconPadding;
  final double clearIconSize;
  final Color clearIconColor;
  final TextStyle textStyle;
  final TextStyle placeholderStyle;
  final EdgeInsets contentPadding;
  final TextStyle cancelStyle;
  final double cancelSpacing;
}
