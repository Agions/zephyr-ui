/// VelocityUI 间距组件
library velocity_space;

import 'package:flutter/material.dart';

/// VelocityUI 间距
class VelocitySpace extends StatelessWidget {
  const VelocitySpace({super.key, this.width, this.height});
  const VelocitySpace.horizontal(double size, {super.key})
      : width = size,
        height = null;
  const VelocitySpace.vertical(double size, {super.key})
      : width = null,
        height = size;

  final double? width;
  final double? height;

  // 预设常量
  static const xs = VelocitySpace(width: 4, height: 4);
  static const sm = VelocitySpace(width: 8, height: 8);
  static const md = VelocitySpace(width: 16, height: 16);
  static const lg = VelocitySpace(width: 24, height: 24);
  static const xl = VelocitySpace(width: 32, height: 32);

  @override
  Widget build(BuildContext context) => SizedBox(width: width, height: height);
}

/// VelocityUI Row 组件
class VelocityRow extends StatelessWidget {
  const VelocityRow(
      {required this.children,
      this.spacing = 0,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.crossAxisAlignment = CrossAxisAlignment.center,
      this.mainAxisSize = MainAxisSize.max,
      super.key});
  final List<Widget> children;
  final double spacing;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: [
        for (int i = 0; i < children.length; i++) ...[
          children[i],
          if (i < children.length - 1 && spacing > 0) SizedBox(width: spacing),
        ],
      ],
    );
  }
}

/// VelocityUI Column 组件
class VelocityColumn extends StatelessWidget {
  const VelocityColumn(
      {required this.children,
      this.spacing = 0,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.crossAxisAlignment = CrossAxisAlignment.start,
      this.mainAxisSize = MainAxisSize.max,
      super.key});
  final List<Widget> children;
  final double spacing;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: [
        for (int i = 0; i < children.length; i++) ...[
          children[i],
          if (i < children.length - 1 && spacing > 0) SizedBox(height: spacing),
        ],
      ],
    );
  }
}
