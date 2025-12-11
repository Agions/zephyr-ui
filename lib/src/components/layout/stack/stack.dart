/// VelocityUI 层叠布局组件
library velocity_stack;

import 'package:flutter/material.dart';

/// VelocityUI 层叠布局
class VelocityStack extends StatelessWidget {
  const VelocityStack({
    required this.children,
    this.alignment = AlignmentDirectional.topStart,
    this.fit = StackFit.loose,
    this.clipBehavior = Clip.hardEdge,
    super.key,
  });

  final List<Widget> children;
  final AlignmentGeometry alignment;
  final StackFit fit;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: alignment,
        fit: fit,
        clipBehavior: clipBehavior,
        children: children);
  }
}

/// VelocityUI 定位组件
class VelocityPositioned extends StatelessWidget {
  const VelocityPositioned({
    required this.child,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.width,
    this.height,
    super.key,
  });

  const VelocityPositioned.fill({required this.child, super.key})
      : left = 0,
        top = 0,
        right = 0,
        bottom = 0,
        width = null,
        height = null;

  const VelocityPositioned.center({required this.child, super.key})
      : left = null,
        top = null,
        right = null,
        bottom = null,
        width = null,
        height = null;

  final Widget child;
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
        width: width,
        height: height,
        child: child);
  }
}
