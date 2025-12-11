/// VelocityUI 对话框样式
library velocity_dialog_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocityDialogStyle {
  const VelocityDialogStyle({
    this.backgroundColor = VelocityColors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.titleStyle = const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: VelocityColors.gray900),
    this.contentStyle =
        const TextStyle(fontSize: 14, color: VelocityColors.gray600),
    this.confirmButtonStyle = const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: VelocityColors.primary),
    this.cancelButtonStyle =
        const TextStyle(fontSize: 14, color: VelocityColors.gray500),
  });

  final Color backgroundColor;
  final BorderRadius borderRadius;
  final TextStyle titleStyle;
  final TextStyle contentStyle;
  final TextStyle confirmButtonStyle;
  final TextStyle cancelButtonStyle;
}
