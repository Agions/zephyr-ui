/// VelocityUI 标签样式
library velocity_tag_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

/// 标签样式配置
class VelocityTagStyle {
  /// 创建标签样式
  const VelocityTagStyle({
    this.backgroundColor,
    this.foregroundColor,
    this.border,
    this.borderRadius,
    this.height = 24,
    this.padding,
    this.textStyle,
    this.iconSize = 14,
    this.spacing = 4,
  });

  /// 背景颜色
  final Color? backgroundColor;

  /// 前景颜色
  final Color? foregroundColor;

  /// 边框
  final Border? border;

  /// 圆角
  final BorderRadius? borderRadius;

  /// 高度
  final double height;

  /// 内边距
  final EdgeInsets? padding;

  /// 文字样式
  final TextStyle? textStyle;

  /// 图标尺寸
  final double iconSize;

  /// 间距
  final double spacing;

  /// 根据类型创建样式
  factory VelocityTagStyle.fromType(dynamic type, {bool outlined = false}) {
    final typeName = type.toString().split('.').last;
    Color color;

    switch (typeName) {
      case 'primary':
        color = VelocityColors.primary;
        break;
      case 'success':
        color = VelocityColors.success;
        break;
      case 'warning':
        color = VelocityColors.warning;
        break;
      case 'error':
        color = VelocityColors.error;
        break;
      case 'info':
        color = VelocityColors.info;
        break;
      default:
        color = VelocityColors.gray500;
    }

    return VelocityTagStyle(
      backgroundColor: outlined
          ? Colors.transparent
          : VelocityColors.withOpacity(color, 0.1),
      foregroundColor: color,
      border: outlined ? Border.all(color: color) : null,
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    );
  }

  /// 复制并修改
  VelocityTagStyle copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    Border? border,
    BorderRadius? borderRadius,
    double? height,
    EdgeInsets? padding,
    TextStyle? textStyle,
    double? iconSize,
    double? spacing,
  }) {
    return VelocityTagStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      border: border ?? this.border,
      borderRadius: borderRadius ?? this.borderRadius,
      height: height ?? this.height,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
      iconSize: iconSize ?? this.iconSize,
      spacing: spacing ?? this.spacing,
    );
  }
}
