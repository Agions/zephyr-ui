/// VelocityUI 描述列表样式
library velocity_descriptions_style;

import 'package:flutter/material.dart';

/// VelocityUI 描述列表样式
class VelocityDescriptionsStyle {
  /// 创建描述列表样式
  const VelocityDescriptionsStyle({
    this.titleStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    this.contentStyle = const TextStyle(
      fontSize: 14,
      color: Colors.black87,
    ),
    this.dividerColor = const Color(0xFFE5E7EB),
    this.borderColor = const Color(0xFFE5E7EB),
    this.backgroundColor = Colors.white,
    this.titleWidth = 100,
    this.columnGap = 16.0,
    this.rowGap = 12.0,
    this.padding = const EdgeInsets.all(16.0),
    this.margin = EdgeInsets.zero,
    this.borderRadius = BorderRadius.zero,
    this.borderWidth = 1.0,
    this.showBorder = false,
    this.showDivider = false,
    this.textAlign = TextAlign.left,
    this.titleTextAlign = TextAlign.right,
  });

  /// 默认样式
  static VelocityDescriptionsStyle defaults() => const VelocityDescriptionsStyle();

  /// 标题样式
  final TextStyle titleStyle;

  /// 内容样式
  final TextStyle contentStyle;

  /// 分隔线颜色
  final Color dividerColor;

  /// 边框颜色
  final Color borderColor;

  /// 背景颜色
  final Color backgroundColor;

  /// 标题宽度
  final double titleWidth;

  /// 列间距
  final double columnGap;

  /// 行间距
  final double rowGap;

  /// 内边距
  final EdgeInsets padding;

  /// 外边距
  final EdgeInsets margin;

  /// 边框圆角
  final BorderRadius borderRadius;

  /// 边框宽度
  final double borderWidth;

  /// 是否显示边框
  final bool showBorder;

  /// 是否显示分隔线
  final bool showDivider;

  /// 内容文本对齐方式
  final TextAlign textAlign;

  /// 标题文本对齐方式
  final TextAlign titleTextAlign;

  /// 复制样式并替换指定属性
  VelocityDescriptionsStyle copyWith({
    TextStyle? titleStyle,
    TextStyle? contentStyle,
    Color? dividerColor,
    Color? borderColor,
    Color? backgroundColor,
    double? titleWidth,
    double? columnGap,
    double? rowGap,
    EdgeInsets? padding,
    EdgeInsets? margin,
    BorderRadius? borderRadius,
    double? borderWidth,
    bool? showBorder,
    bool? showDivider,
    TextAlign? textAlign,
    TextAlign? titleTextAlign,
  }) {
    return VelocityDescriptionsStyle(
      titleStyle: titleStyle ?? this.titleStyle,
      contentStyle: contentStyle ?? this.contentStyle,
      dividerColor: dividerColor ?? this.dividerColor,
      borderColor: borderColor ?? this.borderColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      titleWidth: titleWidth ?? this.titleWidth,
      columnGap: columnGap ?? this.columnGap,
      rowGap: rowGap ?? this.rowGap,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      borderRadius: borderRadius ?? this.borderRadius,
      borderWidth: borderWidth ?? this.borderWidth,
      showBorder: showBorder ?? this.showBorder,
      showDivider: showDivider ?? this.showDivider,
      textAlign: textAlign ?? this.textAlign,
      titleTextAlign: titleTextAlign ?? this.titleTextAlign,
    );
  }
}