library velocity_pagination_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocityPaginationStyle {
  const VelocityPaginationStyle({
    this.buttonSize = 32,
    this.buttonSpacing = const EdgeInsets.symmetric(horizontal: 4),
    this.buttonBorderRadius = const BorderRadius.all(Radius.circular(4)),
    this.buttonBackgroundColor = VelocityColors.white,
    this.activeBackgroundColor = VelocityColors.primary,
    this.borderColor = VelocityColors.gray300,
    this.textStyle = const TextStyle(fontSize: 14, color: VelocityColors.gray700),
    this.activeTextStyle = const TextStyle(fontSize: 14, color: VelocityColors.white),
    this.ellipsisStyle = const TextStyle(fontSize: 14, color: VelocityColors.gray500),
    this.arrowSize = 18,
    this.arrowColor = VelocityColors.gray700,
    this.disabledArrowColor = VelocityColors.gray300,
    this.simplePadding = const EdgeInsets.symmetric(horizontal: 16),
    this.simpleTextStyle = const TextStyle(fontSize: 14, color: VelocityColors.gray700),
  });
  final double buttonSize;
  final EdgeInsets buttonSpacing;
  final BorderRadius buttonBorderRadius;
  final Color buttonBackgroundColor;
  final Color activeBackgroundColor;
  final Color borderColor;
  final TextStyle textStyle;
  final TextStyle activeTextStyle;
  final TextStyle ellipsisStyle;
  final double arrowSize;
  final Color arrowColor;
  final Color disabledArrowColor;
  final EdgeInsets simplePadding;
  final TextStyle simpleTextStyle;
}
