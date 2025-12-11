/// VelocityUI 输入框样式
library velocity_input_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

/// 输入框样式配置
class VelocityInputStyle {
  const VelocityInputStyle({
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
    this.helperStyle,
    this.errorStyle,
    this.fillColor = VelocityColors.white,
    this.disabledFillColor = VelocityColors.gray100,
    this.borderColor = VelocityColors.gray300,
    this.focusedBorderColor = VelocityColors.primary,
    this.errorBorderColor = VelocityColors.error,
    this.disabledBorderColor = VelocityColors.gray200,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    this.iconSize = 20,
    this.iconColor = VelocityColors.gray500,
    this.labelSpacing = 6,
    this.helperSpacing = 4,
    this.filled = true,
  });

  factory VelocityInputStyle.defaults() {
    return const VelocityInputStyle(
      textStyle:
          TextStyle(fontSize: 14, color: VelocityColors.textPrimaryLight),
      hintStyle: TextStyle(fontSize: 14, color: VelocityColors.gray400),
      labelStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: VelocityColors.gray700),
      helperStyle: TextStyle(fontSize: 12, color: VelocityColors.gray500),
      errorStyle: TextStyle(fontSize: 12, color: VelocityColors.error),
    );
  }

  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? helperStyle;
  final TextStyle? errorStyle;
  final Color fillColor;
  final Color disabledFillColor;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;
  final Color disabledBorderColor;
  final BorderRadius borderRadius;
  final EdgeInsets contentPadding;
  final double iconSize;
  final Color iconColor;
  final double labelSpacing;
  final double helperSpacing;
  final bool filled;
}
