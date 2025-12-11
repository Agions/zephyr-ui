/// VelocityUI 图片样式
library velocity_image_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

/// 图片样式配置
class VelocityImageStyle {
  /// 创建图片样式
  const VelocityImageStyle({
    this.borderRadius,
    this.border,
    this.boxShadow,
    this.placeholderColor,
    this.placeholderIconColor,
    this.errorColor,
    this.errorIconColor,
  });

  /// 圆角
  final BorderRadius? borderRadius;

  /// 边框
  final Border? border;

  /// 阴影
  final List<BoxShadow>? boxShadow;

  /// 占位背景色
  final Color? placeholderColor;

  /// 占位图标色
  final Color? placeholderIconColor;

  /// 错误背景色
  final Color? errorColor;

  /// 错误图标色
  final Color? errorIconColor;

  /// 默认样式
  factory VelocityImageStyle.defaults() {
    return const VelocityImageStyle(
      placeholderColor: VelocityColors.gray100,
      placeholderIconColor: VelocityColors.gray400,
      errorColor: VelocityColors.gray100,
      errorIconColor: VelocityColors.gray400,
    );
  }

  /// 复制并修改
  VelocityImageStyle copyWith({
    BorderRadius? borderRadius,
    Border? border,
    List<BoxShadow>? boxShadow,
    Color? placeholderColor,
    Color? placeholderIconColor,
    Color? errorColor,
    Color? errorIconColor,
  }) {
    return VelocityImageStyle(
      borderRadius: borderRadius ?? this.borderRadius,
      border: border ?? this.border,
      boxShadow: boxShadow ?? this.boxShadow,
      placeholderColor: placeholderColor ?? this.placeholderColor,
      placeholderIconColor: placeholderIconColor ?? this.placeholderIconColor,
      errorColor: errorColor ?? this.errorColor,
      errorIconColor: errorIconColor ?? this.errorIconColor,
    );
  }
}
