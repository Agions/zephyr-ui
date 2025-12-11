library velocity_notification_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocityNotificationStyle {
  const VelocityNotificationStyle({
    this.backgroundColor = VelocityColors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.padding = const EdgeInsets.all(16),
    this.boxShadow = const [
      BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 4))
    ],
    this.titleStyle = const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: VelocityColors.gray900),
    this.messageStyle =
        const TextStyle(fontSize: 13, color: VelocityColors.gray600),
    this.iconSize = 24,
    this.iconSpacing = 12,
    this.closeColor = VelocityColors.gray400,
    this.infoColor = VelocityColors.info,
    this.successColor = VelocityColors.success,
    this.warningColor = VelocityColors.warning,
    this.errorColor = VelocityColors.error,
  });

  final Color backgroundColor;
  final BorderRadius borderRadius;
  final EdgeInsets padding;
  final List<BoxShadow> boxShadow;
  final TextStyle titleStyle;
  final TextStyle messageStyle;
  final double iconSize;
  final double iconSpacing;
  final Color closeColor;
  final Color infoColor;
  final Color successColor;
  final Color warningColor;
  final Color errorColor;
}
