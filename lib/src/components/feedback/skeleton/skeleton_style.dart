library velocity_skeleton_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocitySkeletonStyle {
  const VelocitySkeletonStyle({
    this.baseColor = VelocityColors.gray200,
    this.highlightColor = VelocityColors.gray100,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
  });

  final Color baseColor;
  final Color highlightColor;
  final BorderRadius borderRadius;
}
