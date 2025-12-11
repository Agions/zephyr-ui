library velocity_chip_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocityChipStyle {
  const VelocityChipStyle({
    this.backgroundColor = VelocityColors.primary,
    this.foregroundColor = VelocityColors.white,
    this.disabledBackgroundColor = VelocityColors.gray200,
    this.disabledForegroundColor = VelocityColors.gray400,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.border,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    this.labelStyle =
        const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
    this.iconSize = 16,
    this.spacing = 6,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final Color disabledBackgroundColor;
  final Color disabledForegroundColor;
  final BorderRadius borderRadius;
  final Border? border;
  final EdgeInsets padding;
  final TextStyle labelStyle;
  final double iconSize;
  final double spacing;

  factory VelocityChipStyle.fromType(dynamic type, {bool selected = false}) {
    final typeName = type.toString().split('.').last;
    switch (typeName) {
      case 'outlined':
        return VelocityChipStyle(
          backgroundColor: selected
              ? VelocityColors.primaryLight
              : VelocityColors.transparent,
          foregroundColor: VelocityColors.primary,
          border: Border.all(color: VelocityColors.primary),
        );
      case 'tonal':
        return VelocityChipStyle(
          backgroundColor:
              selected ? VelocityColors.primary : VelocityColors.primaryLight,
          foregroundColor:
              selected ? VelocityColors.white : VelocityColors.primary,
        );
      default:
        return VelocityChipStyle(
          backgroundColor:
              selected ? VelocityColors.primary : VelocityColors.gray200,
          foregroundColor:
              selected ? VelocityColors.white : VelocityColors.gray700,
        );
    }
  }
}
