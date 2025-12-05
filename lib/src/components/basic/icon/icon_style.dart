/// VelocityUI 图标样式
library velocity_icon_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

/// 图标样式配置
class VelocityIconStyle {
  /// 创建图标样式
  const VelocityIconStyle({
    this.color,
    this.backgroundColor,
    this.padding,
    this.borderRadius,
  });

  /// 图标颜色
  final Color? color;
  
  /// 背景颜色
  final Color? backgroundColor;
  
  /// 内边距
  final EdgeInsets? padding;
  
  /// 圆角
  final BorderRadius? borderRadius;

  /// 默认样式
  factory VelocityIconStyle.defaults() {
    return const VelocityIconStyle(
      color: VelocityColors.gray700,
    );
  }

  /// 复制并修改
  VelocityIconStyle copyWith({
    Color? color,
    Color? backgroundColor,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
  }) {
    return VelocityIconStyle(
      color: color ?? this.color,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}
