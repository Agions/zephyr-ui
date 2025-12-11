/// VelocityUI 安全区域组件
library velocity_safe_area;

import 'package:flutter/material.dart';

/// VelocityUI 安全区域
class VelocitySafeArea extends StatelessWidget {
  const VelocitySafeArea({
    super.key,
    required this.child,
    this.top = true,
    this.bottom = true,
    this.left = true,
    this.right = true,
    this.minimum = EdgeInsets.zero,
  });

  const VelocitySafeArea.top(
      {super.key, required this.child, this.minimum = EdgeInsets.zero})
      : top = true,
        bottom = false,
        left = false,
        right = false;

  const VelocitySafeArea.bottom(
      {super.key, required this.child, this.minimum = EdgeInsets.zero})
      : top = false,
        bottom = true,
        left = false,
        right = false;

  const VelocitySafeArea.horizontal(
      {super.key, required this.child, this.minimum = EdgeInsets.zero})
      : top = false,
        bottom = false,
        left = true,
        right = true;

  final Widget child;
  final bool top;
  final bool bottom;
  final bool left;
  final bool right;
  final EdgeInsets minimum;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: top,
        bottom: bottom,
        left: left,
        right: right,
        minimum: minimum,
        child: child);
  }
}
