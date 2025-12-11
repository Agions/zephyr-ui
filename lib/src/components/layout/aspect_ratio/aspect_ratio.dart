/// VelocityUI 宽高比组件
library velocity_aspect_ratio;

import 'package:flutter/material.dart';

/// VelocityUI 宽高比
class VelocityAspectRatio extends StatelessWidget {
  const VelocityAspectRatio({
    required this.aspectRatio, required this.child, super.key,
  });

  /// 16:9 宽高比
  const VelocityAspectRatio.video({required this.child, super.key})
      : aspectRatio = 16 / 9;

  /// 4:3 宽高比
  const VelocityAspectRatio.photo({required this.child, super.key})
      : aspectRatio = 4 / 3;

  /// 1:1 正方形
  const VelocityAspectRatio.square({required this.child, super.key})
      : aspectRatio = 1;

  /// 3:4 竖版
  const VelocityAspectRatio.portrait({required this.child, super.key})
      : aspectRatio = 3 / 4;

  final double aspectRatio;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(aspectRatio: aspectRatio, child: child);
  }
}
