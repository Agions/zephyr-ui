library velocity_popconfirm_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocityPopconfirmStyle {
  const VelocityPopconfirmStyle({
    this.width = 200,
    this.backgroundColor = VelocityColors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.padding = const EdgeInsets.all(12),
    this.boxShadow = const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2))],
    this.iconColor = VelocityColors.warning,
    this.titleStyle = const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: VelocityColors.gray900),
    this.contentStyle = const TextStyle(fontSize: 13, color: VelocityColors.gray600),
    this.cancelStyle = const TextStyle(fontSize: 13, color: VelocityColors.gray600),
    this.confirmStyle = const TextStyle(fontSize: 13, color: VelocityColors.white),
    this.cancelBorderColor = VelocityColors.gray300,
    this.confirmBackgroundColor = VelocityColors.primary,
  });

  final double width;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final EdgeInsets padding;
  final List<BoxShadow> boxShadow;
  final Color iconColor;
  final TextStyle titleStyle;
  final TextStyle contentStyle;
  final TextStyle cancelStyle;
  final TextStyle confirmStyle;
  final Color cancelBorderColor;
  final Color confirmBackgroundColor;
}
