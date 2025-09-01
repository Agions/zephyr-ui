import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// 自定义滑块的主题
class ZephyrSliderTheme {
  /// 轨道的高度
  final double trackHeight;

  /// 激活状态的轨道颜色
  final Color activeTrackColor;

  /// 非激活状态的轨道颜色
  final Color inactiveTrackColor;

  /// 悬停状态的轨道颜色
  final Color hoverActiveTrackColor;

  /// 悬停状态的非激活轨道颜色
  final Color hoverInactiveTrackColor;

  /// 禁用状态下的轨道颜色
  final Color disabledActiveTrackColor;

  /// 禁用状态下的非激活轨道颜色
  final Color disabledInactiveTrackColor;

  /// 滑块(滑块指示器)的颜色
  final Color thumbColor;

  /// 悬停状态的滑块颜色
  final Color hoverThumbColor;

  /// 禁用状态下的滑块颜色
  final Color disabledThumbColor;

  /// 滑块的大小
  final double thumbSize;

  /// 滑块的形状
  final BoxShape thumbShape;

  /// 滑块阴影颜色
  final Color thumbShadowColor;

  /// 滑块阴影半径
  final double thumbShadowRadius;

  /// 值指示器的颜色
  final Color valueIndicatorColor;

  /// 值指示器的文字样式
  final TextStyle valueIndicatorTextStyle;

  /// 滑块的边框颜色
  final Color thumbBorderColor;

  /// 悬停状态的滑块边框颜色
  final Color hoverThumbBorderColor;

  /// 禁用状态下的滑块边框颜色
  final Color disabledThumbBorderColor;

  /// 滑块的边框宽度
  final double thumbBorderWidth;

  /// 轨道圆角半径
  final double trackBorderRadius;

  /// 构造函数
  const ZephyrSliderTheme({
    this.trackHeight = 4.0,
    required this.activeTrackColor,
    required this.inactiveTrackColor,
    required this.hoverActiveTrackColor,
    required this.hoverInactiveTrackColor,
    required this.disabledActiveTrackColor,
    required this.disabledInactiveTrackColor,
    required this.thumbColor,
    required this.hoverThumbColor,
    required this.disabledThumbColor,
    this.thumbSize = 20.0,
    this.thumbShape = BoxShape.circle,
    required this.thumbShadowColor,
    this.thumbShadowRadius = 1.0,
    required this.valueIndicatorColor,
    required this.valueIndicatorTextStyle,
    required this.thumbBorderColor,
    required this.hoverThumbBorderColor,
    required this.disabledThumbBorderColor,
    this.thumbBorderWidth = 1.0,
    this.trackBorderRadius = 2.0,
  });

  /// 从上下文中获取主题
  static ZephyrSliderTheme of(BuildContext context) {
    final ZephyrTheme? theme =
        context.dependOnInheritedWidgetOfExactType<ZephyrTheme>();
    return theme?.data.sliderTheme ??
        const ZephyrSliderTheme(
          activeTrackColor: Colors.blue,
          inactiveTrackColor: Colors.grey,
          hoverActiveTrackColor: Colors.blueAccent,
          hoverInactiveTrackColor: Color(0xFFBDBDBD),
          disabledActiveTrackColor: Colors.grey,
          disabledInactiveTrackColor: Colors.grey,
          thumbColor: Colors.blue,
          hoverThumbColor: Colors.blueAccent,
          disabledThumbColor: Colors.grey,
          thumbShadowColor: Colors.black12,
          valueIndicatorColor: Colors.blue,
          valueIndicatorTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 12.0,
          ),
          thumbBorderColor: Colors.transparent,
          hoverThumbBorderColor: Colors.blue,
          disabledThumbBorderColor: Colors.grey,
        );
  }

  /// 创建主题的副本并更新指定的属性
  ZephyrSliderTheme copyWith({
    double? trackHeight,
    Color? activeTrackColor,
    Color? inactiveTrackColor,
    Color? hoverActiveTrackColor,
    Color? hoverInactiveTrackColor,
    Color? disabledActiveTrackColor,
    Color? disabledInactiveTrackColor,
    Color? thumbColor,
    Color? hoverThumbColor,
    Color? disabledThumbColor,
    double? thumbSize,
    BoxShape? thumbShape,
    Color? thumbShadowColor,
    double? thumbShadowRadius,
    Color? valueIndicatorColor,
    TextStyle? valueIndicatorTextStyle,
    Color? thumbBorderColor,
    Color? hoverThumbBorderColor,
    Color? disabledThumbBorderColor,
    double? thumbBorderWidth,
    double? trackBorderRadius,
  }) {
    return ZephyrSliderTheme(
      trackHeight: trackHeight ?? this.trackHeight,
      activeTrackColor: activeTrackColor ?? this.activeTrackColor,
      inactiveTrackColor: inactiveTrackColor ?? this.inactiveTrackColor,
      hoverActiveTrackColor:
          hoverActiveTrackColor ?? this.hoverActiveTrackColor,
      hoverInactiveTrackColor:
          hoverInactiveTrackColor ?? this.hoverInactiveTrackColor,
      disabledActiveTrackColor:
          disabledActiveTrackColor ?? this.disabledActiveTrackColor,
      disabledInactiveTrackColor:
          disabledInactiveTrackColor ?? this.disabledInactiveTrackColor,
      thumbColor: thumbColor ?? this.thumbColor,
      hoverThumbColor: hoverThumbColor ?? this.hoverThumbColor,
      disabledThumbColor: disabledThumbColor ?? this.disabledThumbColor,
      thumbSize: thumbSize ?? this.thumbSize,
      thumbShape: thumbShape ?? this.thumbShape,
      thumbShadowColor: thumbShadowColor ?? this.thumbShadowColor,
      thumbShadowRadius: thumbShadowRadius ?? this.thumbShadowRadius,
      valueIndicatorColor: valueIndicatorColor ?? this.valueIndicatorColor,
      valueIndicatorTextStyle:
          valueIndicatorTextStyle ?? this.valueIndicatorTextStyle,
      thumbBorderColor: thumbBorderColor ?? this.thumbBorderColor,
      hoverThumbBorderColor:
          hoverThumbBorderColor ?? this.hoverThumbBorderColor,
      disabledThumbBorderColor:
          disabledThumbBorderColor ?? this.disabledThumbBorderColor,
      thumbBorderWidth: thumbBorderWidth ?? this.thumbBorderWidth,
      trackBorderRadius: trackBorderRadius ?? this.trackBorderRadius,
    );
  }
}
