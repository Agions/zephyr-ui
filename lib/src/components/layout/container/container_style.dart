/// VelocityUI 容器样式
library velocity_container_style;

import 'package:flutter/material.dart';

class VelocityContainerStyle {
  const VelocityContainerStyle(
      {this.padding,
      this.margin,
      this.backgroundColor,
      this.borderRadius,
      this.border,
      this.boxShadow,
      this.clipBehavior});

  factory VelocityContainerStyle.defaults() => const VelocityContainerStyle();
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Border? border;
  final List<BoxShadow>? boxShadow;
  final Clip? clipBehavior;
}
