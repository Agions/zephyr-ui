/// ZephyrUI 单选框主题
///
/// 定义单选框组件的主题配置。
library radio_theme;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI 单选框主题
class ZephyrRadioTheme {
  /// 创建单选框主题
  const ZephyrRadioTheme({
    this.activeColor = const Color(0xFF2196F3),
    this.borderColor = const Color(0xFF757575),
    this.hoverBorderColor = const Color(0xFF2196F3),
    this.focusedBorderColor = const Color(0xFF2196F3),
    this.activeBorderColor = const Color(0xFF2196F3),
    this.disabledBorderColor = const Color(0xFFBDBDBD),
    this.errorBorderColor = const Color(0xFFF44336),
    this.activeBackgroundColor = const Color(0xFFE3F2FD),
    this.hoverBackgroundColor = const Color(0xFFF5F5F5),
    this.disabledBackgroundColor = const Color(0xFFFAFAFA),
    this.disabledColor = const Color(0xFF9E9E9E),
    this.errorColor = const Color(0xFFF44336),
    this.textStyle = const TextStyle(
      fontSize: 14,
      color: Color(0xFF212121),
    ),
    this.disabledTextStyle = const TextStyle(
      fontSize: 14,
      color: Color(0xFF9E9E9E),
    ),
    this.errorTextStyle = const TextStyle(
      fontSize: 12,
      color: Color(0xFFF44336),
    ),
    this.helperTextStyle = const TextStyle(
      fontSize: 12,
      color: Color(0xFF757575),
    ),
    this.sublabelStyle = const TextStyle(
      fontSize: 12,
      color: Color(0xFF757575),
    ),
    this.borderWidth = 2.0,
  });

  /// 激活状态颜色
  final Color activeColor;

  /// 边框颜色
  final Color borderColor;

  /// 悬停状态边框颜色
  final Color hoverBorderColor;

  /// 焦点状态边框颜色
  final Color focusedBorderColor;

  /// 激活状态边框颜色
  final Color activeBorderColor;

  /// 禁用状态边框颜色
  final Color disabledBorderColor;

  /// 错误状态边框颜色
  final Color errorBorderColor;

  /// 激活状态背景颜色
  final Color activeBackgroundColor;

  /// 悬停状态背景颜色
  final Color hoverBackgroundColor;

  /// 禁用状态背景颜色
  final Color disabledBackgroundColor;

  /// 禁用状态颜色
  final Color disabledColor;

  /// 错误状态颜色
  final Color errorColor;

  /// 文本样式
  final TextStyle textStyle;

  /// 禁用状态文本样式
  final TextStyle disabledTextStyle;

  /// 错误状态文本样式
  final TextStyle errorTextStyle;

  /// 帮助文本样式
  final TextStyle helperTextStyle;

  /// 子标签文本样式
  final TextStyle sublabelStyle;

  /// 边框宽度
  final double borderWidth;

  /// 从上下文获取主题
  static ZephyrRadioTheme of(BuildContext context) {
    return ZephyrTheme.of(context).radioTheme;
  }

  /// 创建亮色主题
  static ZephyrRadioTheme light() {
    return const ZephyrRadioTheme(
      activeColor: Color(0xFF2196F3),
      borderColor: Color(0xFF757575),
      hoverBorderColor: Color(0xFF2196F3),
      focusedBorderColor: Color(0xFF2196F3),
      activeBorderColor: Color(0xFF2196F3),
      disabledBorderColor: Color(0xFFBDBDBD),
      errorBorderColor: Color(0xFFF44336),
      activeBackgroundColor: Color(0xFFE3F2FD),
      hoverBackgroundColor: Color(0xFFF5F5F5),
      disabledBackgroundColor: Color(0xFFFAFAFA),
      disabledColor: Color(0xFF9E9E9E),
      errorColor: Color(0xFFF44336),
      textStyle: const TextStyle(
        fontSize: 14,
        color: Color(0xFF212121),
      ),
      disabledTextStyle: TextStyle(
        fontSize: 14,
        color: Color(0xFF9E9E9E),
      ),
      errorTextStyle: TextStyle(
        fontSize: 12,
        color: Color(0xFFF44336),
      ),
      helperTextStyle: TextStyle(
        fontSize: 12,
        color: Color(0xFF757575),
      ),
      sublabelStyle: TextStyle(
        fontSize: 12,
        color: Color(0xFF757575),
      ),
    );
  }

  /// 创建暗色主题
  static ZephyrRadioTheme dark() {
    return const ZephyrRadioTheme(
      activeColor: Color(0xFF64B5F6),
      borderColor: Color(0xFFBDBDBD),
      hoverBorderColor: Color(0xFF64B5F6),
      focusedBorderColor: Color(0xFF64B5F6),
      activeBorderColor: Color(0xFF64B5F6),
      disabledBorderColor: Color(0xFF616161),
      errorBorderColor: Color(0xFFEF5350),
      activeBackgroundColor: Color(0xFF1E88E5),
      hoverBackgroundColor: Color(0xFF424242),
      disabledBackgroundColor: Color(0xFF424242),
      disabledColor: Color(0xFF757575),
      errorColor: Color(0xFFEF5350),
      textStyle: const TextStyle(
        fontSize: 14,
        color: Color(0xFFFFFFFF),
      ),
      disabledTextStyle: TextStyle(
        fontSize: 14,
        color: Color(0xFF757575),
      ),
      errorTextStyle: TextStyle(
        fontSize: 12,
        color: Color(0xFFEF5350),
      ),
      helperTextStyle: TextStyle(
        fontSize: 12,
        color: Color(0xFFBDBDBD),
      ),
      sublabelStyle: TextStyle(
        fontSize: 12,
        color: Color(0xFFBDBDBD),
      ),
    );
  }

  /// 复制主题并修改
  ZephyrRadioTheme copyWith({
    Color? activeColor,
    Color? borderColor,
    Color? hoverBorderColor,
    Color? focusedBorderColor,
    Color? activeBorderColor,
    Color? disabledBorderColor,
    Color? errorBorderColor,
    Color? activeBackgroundColor,
    Color? hoverBackgroundColor,
    Color? disabledBackgroundColor,
    Color? disabledColor,
    Color? errorColor,
    TextStyle? textStyle,
    TextStyle? disabledTextStyle,
    TextStyle? errorTextStyle,
    TextStyle? helperTextStyle,
    TextStyle? sublabelStyle,
    double? borderWidth,
  }) {
    return ZephyrRadioTheme(
      activeColor: activeColor ?? this.activeColor,
      borderColor: borderColor ?? this.borderColor,
      hoverBorderColor: hoverBorderColor ?? this.hoverBorderColor,
      focusedBorderColor: focusedBorderColor ?? this.focusedBorderColor,
      activeBorderColor: activeBorderColor ?? this.activeBorderColor,
      disabledBorderColor: disabledBorderColor ?? this.disabledBorderColor,
      errorBorderColor: errorBorderColor ?? this.errorBorderColor,
      activeBackgroundColor: activeBackgroundColor ?? this.activeBackgroundColor,
      hoverBackgroundColor: hoverBackgroundColor ?? this.hoverBackgroundColor,
      disabledBackgroundColor: disabledBackgroundColor ?? this.disabledBackgroundColor,
      disabledColor: disabledColor ?? this.disabledColor,
      errorColor: errorColor ?? this.errorColor,
      textStyle: textStyle ?? this.textStyle,
      disabledTextStyle: disabledTextStyle ?? this.disabledTextStyle,
      errorTextStyle: errorTextStyle ?? this.errorTextStyle,
      helperTextStyle: helperTextStyle ?? this.helperTextStyle,
      sublabelStyle: sublabelStyle ?? this.sublabelStyle,
      borderWidth: borderWidth ?? this.borderWidth,
    );
  }
}