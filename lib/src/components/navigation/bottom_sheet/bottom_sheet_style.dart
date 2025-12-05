library velocity_bottom_sheet_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocityBottomSheetStyle {
  const VelocityBottomSheetStyle({
    this.backgroundColor = VelocityColors.white,
    this.borderRadius = const BorderRadius.vertical(top: Radius.circular(16)),
    this.handleWidth = 40,
    this.handleHeight = 4,
    this.handleMargin = const EdgeInsets.only(top: 12),
    this.handleColor = VelocityColors.gray300,
    this.headerPadding = const EdgeInsets.fromLTRB(16, 12, 16, 0),
    this.contentPadding = const EdgeInsets.all(16),
    this.titleStyle = const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: VelocityColors.gray900),
    this.closeIconColor = VelocityColors.gray500,
    this.closeIconSize = 24,
    this.actionTextColor = VelocityColors.gray900,
    this.actionIconColor = VelocityColors.gray600,
    this.destructiveColor = VelocityColors.error,
    this.dividerColor = VelocityColors.gray200,
    this.cancelStyle = const TextStyle(fontSize: 16, color: VelocityColors.gray500),
  });

  final Color backgroundColor;
  final BorderRadius borderRadius;
  final double handleWidth;
  final double handleHeight;
  final EdgeInsets handleMargin;
  final Color handleColor;
  final EdgeInsets headerPadding;
  final EdgeInsets contentPadding;
  final TextStyle titleStyle;
  final Color closeIconColor;
  final double closeIconSize;
  final Color actionTextColor;
  final Color actionIconColor;
  final Color destructiveColor;
  final Color dividerColor;
  final TextStyle cancelStyle;
}
