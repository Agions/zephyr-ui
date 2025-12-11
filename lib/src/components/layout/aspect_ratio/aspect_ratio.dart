/// VelocityUI 宽高比组件
library velocity_aspect_ratio;

import 'package:flutter/material.dart';

/// VelocityUI 宽高比
class VelocityAspectRatio extends StatelessWidget {
  const VelocityAspectRatio({
    super.key,
    required this.aspectRatio,
    required this.child,
  });

  /// 16:9 宽高比
  const VelocityAspectRatio.video({super.key, required this.child})
      : aspectRatio = 16 / 9;

  /// 4:3 宽高比
  const VelocityAspectRatio.photo({super.key, required this.child})
      : aspectRatio = 4 / 3;

  /// 1:1 正方形
  const VelocityAspectRatio.square({super.key, required this.child})
      : aspectRatio = 1;

  /// 3:4 竖版
  const VelocityAspectRatio.portrait({super.key, required this.child})
      : aspectRatio = 3 / 4;

  final double aspectRatio;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(aspectRatio: aspectRatio, child: child);
  }
}
