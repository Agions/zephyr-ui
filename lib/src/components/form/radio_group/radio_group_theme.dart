import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// 自定义单选按钮组的主题
class ZephyrRadioGroupTheme {
  /// 激活状态的颜色
  final Color activeColor;

  /// 边框颜色
  final Color borderColor;

  /// 禁用状态下的边框颜色
  final Color disabledBorderColor;

  /// 文本样式
  final TextStyle textStyle;

  /// 选中项的文本样式
  final TextStyle selectedTextStyle;

  /// 禁用状态下的文本样式
  final TextStyle disabledTextStyle;

  /// 边框宽度
  final double borderWidth;

  /// 边框圆角
  final BorderRadius borderRadius;

  /// 构造函数
  const ZephyrRadioGroupTheme({
    required this.activeColor,
    required this.borderColor,
    required this.disabledBorderColor,
    required this.textStyle,
    required this.selectedTextStyle,
    required this.disabledTextStyle,
    this.borderWidth = 1.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(4.0)),
  });

  /// 从上下文中获取主题
  static ZephyrRadioGroupTheme of(BuildContext context) {
    final ZephyrTheme? theme =
        context.dependOnInheritedWidgetOfExactType<ZephyrTheme>();
    return theme?.data.radioGroupTheme ??
        const ZephyrRadioGroupTheme(
          activeColor: Colors.blue,
          borderColor: Colors.grey,
          disabledBorderColor: Colors.grey,
          textStyle: const TextStyle(),
          selectedTextStyle: TextStyle(fontWeight: FontWeight.bold),
          disabledTextStyle: TextStyle(color: Colors.grey),
        );
  }

  /// 创建主题的副本并更新指定的属性
  ZephyrRadioGroupTheme copyWith({
    Color? activeColor,
    Color? borderColor,
    Color? disabledBorderColor,
    TextStyle? textStyle,
    TextStyle? selectedTextStyle,
    TextStyle? disabledTextStyle,
    double? borderWidth,
    BorderRadius? borderRadius,
  }) {
    return ZephyrRadioGroupTheme(
      activeColor: activeColor ?? this.activeColor,
      borderColor: borderColor ?? this.borderColor,
      disabledBorderColor: disabledBorderColor ?? this.disabledBorderColor,
      textStyle: textStyle ?? this.textStyle,
      selectedTextStyle: selectedTextStyle ?? this.selectedTextStyle,
      disabledTextStyle: disabledTextStyle ?? this.disabledTextStyle,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}
