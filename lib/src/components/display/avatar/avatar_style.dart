/// VelocityUI 头像样式
library velocity_avatar_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

/// 头像样式配置
class VelocityAvatarStyle {
  /// 创建头像样式
  const VelocityAvatarStyle({
    this.backgroundColor,
    this.foregroundColor,
    this.border,
  });

  /// 背景颜色
  final Color? backgroundColor;
  
  /// 前景颜色
  final Color? foregroundColor;
  
  /// 边框
  final Border? border;

  /// 默认样式
  factory VelocityAvatarStyle.defaults() {
    return const VelocityAvatarStyle(
      backgroundColor: VelocityColors.primaryLight,
      foregroundColor: VelocityColors.white,
    );
  }

  /// 复制并修改
  VelocityAvatarStyle copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    Border? border,
  }) {
    return VelocityAvatarStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      border: border ?? this.border,
    );
  }
}

/// 头像组样式配置
class VelocityAvatarGroupStyle {
  /// 创建头像组样式
  const VelocityAvatarGroupStyle({
    this.borderColor = VelocityColors.white,
    this.borderWidth = 2,
    this.overflowBackgroundColor = VelocityColors.gray200,
    this.overflowForegroundColor = VelocityColors.gray700,
  });

  /// 边框颜色
  final Color borderColor;
  
  /// 边框宽度
  final double borderWidth;
  
  /// 溢出背景色
  final Color overflowBackgroundColor;
  
  /// 溢出前景色
  final Color overflowForegroundColor;

  /// 默认样式
  factory VelocityAvatarGroupStyle.defaults() {
    return const VelocityAvatarGroupStyle();
  }
}
