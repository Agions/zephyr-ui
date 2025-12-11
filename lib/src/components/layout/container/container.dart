/// VelocityUI 容器组件
library velocity_container;

import 'package:flutter/material.dart';
import 'container_style.dart';

export 'container_style.dart';

/// VelocityUI 容器
class VelocityContainer extends StatelessWidget {
  const VelocityContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.constraints,
    this.alignment,
    this.style,
  });

  final Widget? child;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final AlignmentGeometry? alignment;
  final VelocityContainerStyle? style;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? VelocityContainerStyle.defaults();

    return Container(
      width: width,
      height: height,
      constraints: constraints,
      alignment: alignment,
      padding: effectiveStyle.padding,
      margin: effectiveStyle.margin,
      decoration: BoxDecoration(
        color: effectiveStyle.backgroundColor,
        borderRadius: effectiveStyle.borderRadius,
        border: effectiveStyle.border,
        boxShadow: effectiveStyle.boxShadow,
      ),
      clipBehavior: effectiveStyle.clipBehavior ?? Clip.none,
      child: child,
    );
  }
}
