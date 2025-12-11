/// VelocityUI 面包屑导航样式
library velocity_breadcrumb_style;

import 'package:flutter/material.dart';

/// VelocityUI 面包屑导航样式
class VelocityBreadcrumbStyle {
  /// 创建面包屑导航样式
  const VelocityBreadcrumbStyle({
    this.textStyle = const TextStyle(fontSize: 14, color: Colors.black87),
    this.activeTextStyle = const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
    this.separatorStyle = const TextStyle(fontSize: 14, color: Colors.grey),
    this.separator = '/',
    this.spacing = 8.0,
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 4.0),
    this.wrap = false,
  });

  /// 默认样式
  static VelocityBreadcrumbStyle defaults() => const VelocityBreadcrumbStyle();

  /// 文本样式
  final TextStyle textStyle;

  /// 激活状态文本样式
  final TextStyle activeTextStyle;

  /// 分隔符样式
  final TextStyle separatorStyle;

  /// 分隔符
  final String separator;

  /// 间距
  final double spacing;

  /// 项内边距
  final EdgeInsets itemPadding;

  /// 是否自动换行
  final bool wrap;

  /// 复制样式并替换指定属性
  VelocityBreadcrumbStyle copyWith({
    TextStyle? textStyle,
    TextStyle? activeTextStyle,
    TextStyle? separatorStyle,
    String? separator,
    double? spacing,
    EdgeInsets? itemPadding,
    bool? wrap,
  }) {
    return VelocityBreadcrumbStyle(
      textStyle: textStyle ?? this.textStyle,
      activeTextStyle: activeTextStyle ?? this.activeTextStyle,
      separatorStyle: separatorStyle ?? this.separatorStyle,
      separator: separator ?? this.separator,
      spacing: spacing ?? this.spacing,
      itemPadding: itemPadding ?? this.itemPadding,
      wrap: wrap ?? this.wrap,
    );
  }
}
