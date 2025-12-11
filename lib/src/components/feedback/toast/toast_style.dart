/// VelocityUI Toast样式
library velocity_toast_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocityToastStyle {
  const VelocityToastStyle(
      {this.backgroundColor,
      this.textStyle,
      this.padding,
      this.borderRadius,
      this.boxShadow,
      this.icon,
      this.iconSize,
      this.iconColor,
      this.iconSpacing});
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;
  final double? iconSpacing;

  factory VelocityToastStyle.fromType(dynamic type) {
    final typeName = type.toString().split('.').last;
    IconData icon;
    Color color;
    switch (typeName) {
      case 'success':
        icon = Icons.check_circle;
        color = VelocityColors.success;
        break;
      case 'warning':
        icon = Icons.warning;
        color = VelocityColors.warning;
        break;
      case 'error':
        icon = Icons.error;
        color = VelocityColors.error;
        break;
      default:
        icon = Icons.info;
        color = VelocityColors.info;
    }
    return VelocityToastStyle(
      backgroundColor: VelocityColors.gray900,
      textStyle: const TextStyle(fontSize: 14, color: VelocityColors.white),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      boxShadow: [
        BoxShadow(
            color: VelocityColors.withOpacity(VelocityColors.black, 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4))
      ],
      icon: icon,
      iconSize: 20,
      iconColor: color,
      iconSpacing: 8,
    );
  }
}
