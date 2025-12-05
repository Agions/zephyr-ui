/// VelocityUI 徽章样式
library velocity_badge_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

/// 徽章样式配置
class VelocityBadgeStyle {
  /// 创建徽章样式
  const VelocityBadgeStyle({
    this.backgroundColor,
    this.textStyle,
    this.height = 18,
    this.minWidth = 18,
    this.dotSize = 8,
    this.padding,
    this.borderRadius,
  });

  /// 背景颜色
  final Color? backgroundColor;
  
  /// 文字样式
  final TextStyle? textStyle;
  
  /// 高度
  final double height;
  
  /// 最小宽度
  final double minWidth;
  
  /// 点尺寸
  final double dotSize;
  
  /// 内边距
  final EdgeInsets? padding;
  
  /// 圆角
  final BorderRadius? borderRadius;

  /// 根据类型创建样式
  factory VelocityBadgeStyle.fromType(dynamic type) {
    final typeName = type.toString().split('.').last;
    Color color;
    
    switch (typeName) {
      case 'primary': color = VelocityColors.primary; break;
      case 'success': color = VelocityColors.success; break;
      case 'warning': color = VelocityColors.warning; break;
      case 'error': color = VelocityColors.error; break;
      case 'info': color = VelocityColors.info; break;
      default: color = VelocityColors.error;
    }
    
    return VelocityBadgeStyle(
      backgroundColor: color,
      textStyle: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      borderRadius: const BorderRadius.all(Radius.circular(9)),
    );
  }

  /// 复制并修改
  VelocityBadgeStyle copyWith({
    Color? backgroundColor,
    TextStyle? textStyle,
    double? height,
    double? minWidth,
    double? dotSize,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
  }) {
    return VelocityBadgeStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textStyle: textStyle ?? this.textStyle,
      height: height ?? this.height,
      minWidth: minWidth ?? this.minWidth,
      dotSize: dotSize ?? this.dotSize,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}
