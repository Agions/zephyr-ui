/// VelocityUI 树形组件样式
library velocity_tree_style;

import 'package:flutter/material.dart';

/// VelocityUI 树形组件样式
class VelocityTreeStyle {
  /// 创建树形组件样式
  VelocityTreeStyle({
    this.textStyle = const TextStyle(fontSize: 14, color: Colors.black87),
    this.iconStyle,
    this.indent = 20.0,
    this.expandIcon = Icons.keyboard_arrow_right,
    this.collapseIcon = Icons.keyboard_arrow_down,
    this.checkboxColor = Colors.blue,
    this.selectedTextStyle,
    this.selectedBackgroundColor = const Color(0xFFEBF5FF),
    this.lineColor = const Color(0xFFD1D5DB),
    this.lineWidth = 1.0,
    this.nodePadding = const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
  });

  /// 默认样式
  static VelocityTreeStyle defaults() => VelocityTreeStyle();

  /// 文本样式
  final TextStyle textStyle;

  /// 图标样式
  final TextStyle? iconStyle;

  /// 缩进距离
  final double indent;

  /// 展开图标
  final IconData expandIcon;

  /// 折叠图标
  final IconData collapseIcon;

  /// 复选框颜色
  final Color checkboxColor;

  /// 选中文本样式
  final TextStyle? selectedTextStyle;

  /// 选中背景颜色
  final Color selectedBackgroundColor;

  /// 连接线颜色
  final Color lineColor;

  /// 连接线宽度
  final double lineWidth;

  /// 节点内边距
  final EdgeInsets nodePadding;

  /// 复制样式并替换指定属性
  VelocityTreeStyle copyWith({
    TextStyle? textStyle,
    TextStyle? iconStyle,
    double? indent,
    IconData? expandIcon,
    IconData? collapseIcon,
    Color? checkboxColor,
    TextStyle? selectedTextStyle,
    Color? selectedBackgroundColor,
    Color? lineColor,
    double? lineWidth,
    EdgeInsets? nodePadding,
  }) {
    return VelocityTreeStyle(
      textStyle: textStyle ?? this.textStyle,
      iconStyle: iconStyle ?? this.iconStyle,
      indent: indent ?? this.indent,
      expandIcon: expandIcon ?? this.expandIcon,
      collapseIcon: collapseIcon ?? this.collapseIcon,
      checkboxColor: checkboxColor ?? this.checkboxColor,
      selectedTextStyle: selectedTextStyle ?? this.selectedTextStyle,
      selectedBackgroundColor: selectedBackgroundColor ?? this.selectedBackgroundColor,
      lineColor: lineColor ?? this.lineColor,
      lineWidth: lineWidth ?? this.lineWidth,
      nodePadding: nodePadding ?? this.nodePadding,
    );
  }
}