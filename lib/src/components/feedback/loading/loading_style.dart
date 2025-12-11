/// VelocityUI 加载样式
library velocity_loading_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocityLoadingStyle {
  const VelocityLoadingStyle({
    this.color = VelocityColors.primary,
    this.backgroundColor = VelocityColors.gray200,
    this.linearWidth = 200,
    this.linearHeight = 4,
  });
  final Color color;
  final Color backgroundColor;
  final double linearWidth;
  final double linearHeight;
}

class VelocityLoadingOverlayStyle {
  const VelocityLoadingOverlayStyle({
    this.overlayColor,
    this.loadingStyle = const VelocityLoadingStyle(),
    this.messageStyle =
        const TextStyle(fontSize: 14, color: VelocityColors.white),
    this.messageSpacing = 16,
  });
  final Color? overlayColor;
  final VelocityLoadingStyle loadingStyle;
  final TextStyle messageStyle;
  final double messageSpacing;

  Color get effectiveOverlayColor =>
      overlayColor ?? VelocityColors.withOpacity(VelocityColors.black, 0.3);
}
