/// VelocityUI 固钉组件样式
library velocity_affix_style;

import 'package:flutter/material.dart';

/// VelocityUI 固钉组件样式
class VelocityAffixStyle {
  /// 创建固钉样式
  const VelocityAffixStyle({
    this.offset = 0.0,
    this.offsetBottom = 0.0,
    this.zIndex = 100,
    this.fixedBackgroundColor,
    this.fixedBoxShadow,
    this.fixedBorder,
    this.fixedPadding,
    this.fixedMargin,
  });

  /// 默认样式
  static VelocityAffixStyle defaults() => const VelocityAffixStyle();

  /// 顶部偏移量
  final double offset;

  /// 底部偏移量
  final double offsetBottom;

  /// 固定时的 z-index
  final int zIndex;

  /// 固定时的背景颜色
  final Color? fixedBackgroundColor;

  /// 固定时的阴影
  final BoxShadow? fixedBoxShadow;

  /// 固定时的边框
  final BoxBorder? fixedBorder;

  /// 固定时的内边距
  final EdgeInsets? fixedPadding;

  /// 固定时的外边距
  final EdgeInsets? fixedMargin;

  /// 复制样式并替换指定属性
  VelocityAffixStyle copyWith({
    double? offset,
    double? offsetBottom,
    int? zIndex,
    Color? fixedBackgroundColor,
    BoxShadow? fixedBoxShadow,
    BoxBorder? fixedBorder,
    EdgeInsets? fixedPadding,
    EdgeInsets? fixedMargin,
  }) {
    return VelocityAffixStyle(
      offset: offset ?? this.offset,
      offsetBottom: offsetBottom ?? this.offsetBottom,
      zIndex: zIndex ?? this.zIndex,
      fixedBackgroundColor: fixedBackgroundColor ?? this.fixedBackgroundColor,
      fixedBoxShadow: fixedBoxShadow ?? this.fixedBoxShadow,
      fixedBorder: fixedBorder ?? this.fixedBorder,
      fixedPadding: fixedPadding ?? this.fixedPadding,
      fixedMargin: fixedMargin ?? this.fixedMargin,
    );
  }
}
