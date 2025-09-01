import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// 复选框组主题配置
class ZephyrCheckboxGroupTheme {
  /// 复选框激活颜色
  final Color activeColor;

  /// 复选框勾选颜色
  final Color checkColor;

  /// 边框颜色
  final Color borderColor;

  /// 禁用状态边框颜色
  final Color disabledBorderColor;

  /// 文本样式
  final TextStyle textStyle;

  /// 禁用状态文本样式
  final TextStyle disabledTextStyle;

  /// 边框宽度
  final double borderWidth;

  /// 边框圆角
  final double borderRadius;

  /// 构造函数
  const ZephyrCheckboxGroupTheme({
    required this.activeColor,
    required this.checkColor,
    required this.borderColor,
    required this.disabledBorderColor,
    required this.textStyle,
    required this.disabledTextStyle,
    required this.borderWidth,
    required this.borderRadius,
  });

  /// 从主题中获取复选框组主题
  static ZephyrCheckboxGroupTheme of(BuildContext context) {
    return ZephyrTheme.of(context).checkboxGroupTheme;
  }

  /// 合并主题
  ZephyrCheckboxGroupTheme merge(ZephyrCheckboxGroupTheme? other) {
    if (other == null) return this;

    return ZephyrCheckboxGroupTheme(
      activeColor: other.activeColor,
      checkColor: other.checkColor,
      borderColor: other.borderColor,
      disabledBorderColor: other.disabledBorderColor,
      textStyle: other.textStyle,
      disabledTextStyle: other.disabledTextStyle,
      borderWidth: other.borderWidth,
      borderRadius: other.borderRadius,
    );
  }
}
