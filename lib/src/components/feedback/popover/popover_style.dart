/// VelocityUI 气泡卡片样式
library velocity_popover_style;

import 'package:flutter/material.dart';

/// VelocityUI 气泡卡片样式
class VelocityPopOverStyle {
  /// 创建气泡卡片样式
  VelocityPopOverStyle({
    this.backgroundColor = Colors.white,
    this.borderColor = const Color(0xFFE5E7EB),
    this.borderWidth = 1.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.shadowColor = const Color(0x26000000),
    this.elevation = 4.0,
    this.margin = const EdgeInsets.all(8.0),
    this.padding = const EdgeInsets.all(12.0),
    this.arrowSize = 8.0,
    this.arrowColor = Colors.white,
    this.textStyle = const TextStyle(
      fontSize: 14,
      color: Colors.black87,
    ),
    this.maxWidth = 300.0,
    this.minWidth = 120.0,
    this.minHeight = 40.0,
    this.showBorder = true,
  });

  /// 默认样式
  static VelocityPopOverStyle defaults() => VelocityPopOverStyle();

  /// 背景颜色
  final Color backgroundColor;

  /// 边框颜色
  final Color borderColor;

  /// 边框宽度
  final double borderWidth;

  /// 边框圆角
  final BorderRadius borderRadius;

  /// 阴影颜色
  final Color shadowColor;

  /// 阴影高度
  final double elevation;

  /// 外边距
  final EdgeInsets margin;

  /// 内边距
  final EdgeInsets padding;

  /// 箭头大小
  final double arrowSize;

  /// 箭头颜色
  final Color arrowColor;

  /// 文本样式
  final TextStyle textStyle;

  /// 最大宽度
  final double maxWidth;

  /// 最小宽度
  final double minWidth;

  /// 最小高度
  final double minHeight;

  /// 是否显示边框
  final bool showBorder;

  /// 复制样式并替换指定属性
  VelocityPopOverStyle copyWith({
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    BorderRadius? borderRadius,
    Color? shadowColor,
    double? elevation,
    EdgeInsets? margin,
    EdgeInsets? padding,
    double? arrowSize,
    Color? arrowColor,
    TextStyle? textStyle,
    double? maxWidth,
    double? minWidth,
    double? minHeight,
    bool? showBorder,
  }) {
    return VelocityPopOverStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      shadowColor: shadowColor ?? this.shadowColor,
      elevation: elevation ?? this.elevation,
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      arrowSize: arrowSize ?? this.arrowSize,
      arrowColor: arrowColor ?? this.arrowColor,
      textStyle: textStyle ?? this.textStyle,
      maxWidth: maxWidth ?? this.maxWidth,
      minWidth: minWidth ?? this.minWidth,
      minHeight: minHeight ?? this.minHeight,
      showBorder: showBorder ?? this.showBorder,
    );
  }
}

/// 气泡卡片位置
enum VelocityPopOverPosition {
  /// 上
  top,

  /// 下
  bottom,

  /// 左
  left,

  /// 右
  right,

  /// 上左
  topLeft,

  /// 上右
  topRight,

  /// 下左
  bottomLeft,

  /// 下右
  bottomRight,

  /// 左
  leftTop,

  /// 左下
  leftBottom,

  /// 右上
  rightTop,

  /// 右下
  rightBottom,
}

/// 气泡卡片触发方式
enum VelocityPopOverTrigger {
  /// 点击
  click,

  /// 悬停
  hover,

  /// 手动
  manual,
}
