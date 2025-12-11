/// VelocityUI 卡片样式
library velocity_card_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

/// 卡片样式配置
class VelocityCardStyle {
  /// 创建卡片样式
  const VelocityCardStyle({
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
    this.border,
    this.boxShadow,
    this.clipBehavior,
  });

  /// 默认样式
  factory VelocityCardStyle.defaults() {
    return VelocityCardStyle(
      padding: const EdgeInsets.all(16),
      backgroundColor: VelocityColors.white,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      boxShadow: [
        BoxShadow(
          color: VelocityColors.withOpacity(VelocityColors.black, 0.08),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  /// 宽度
  final double? width;

  /// 高度
  final double? height;

  /// 外边距
  final EdgeInsets? margin;

  /// 内边距
  final EdgeInsets? padding;

  /// 背景颜色
  final Color? backgroundColor;

  /// 圆角
  final BorderRadius? borderRadius;

  /// 边框
  final Border? border;

  /// 阴影
  final List<BoxShadow>? boxShadow;

  /// 裁剪行为
  final Clip? clipBehavior;

  /// 轮廓边框
  static Border outlinedBorder() {
    return Border.all(color: VelocityColors.gray300, width: 1);
  }

  /// 填充背景色
  static Color filledBackground() {
    return VelocityColors.gray100;
  }

  /// 复制并修改
  VelocityCardStyle copyWith({
    double? width,
    double? height,
    EdgeInsets? margin,
    EdgeInsets? padding,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    Border? border,
    List<BoxShadow>? boxShadow,
    Clip? clipBehavior,
  }) {
    return VelocityCardStyle(
      width: width ?? this.width,
      height: height ?? this.height,
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      border: border ?? this.border,
      boxShadow: boxShadow ?? this.boxShadow,
      clipBehavior: clipBehavior ?? this.clipBehavior,
    );
  }
}
