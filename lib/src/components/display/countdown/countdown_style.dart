/// VelocityUI 倒计时组件样式
library velocity_countdown_style;

import 'package:flutter/material.dart';

/// VelocityUI 倒计时组件样式
class VelocityCountDownStyle {
  /// 创建倒计时样式
  VelocityCountDownStyle({
    this.digitStyle = const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    this.labelStyle = const TextStyle(
      fontSize: 12,
      color: Color(0xFF4B5563),
    ),
    this.separatorStyle = const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    this.digitBackgroundColor,
    this.digitBorderRadius = const BorderRadius.all(Radius.circular(4.0)),
    this.digitPadding =
        const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    this.digitMargin = const EdgeInsets.symmetric(horizontal: 4.0),
    this.labelMargin = const EdgeInsets.only(top: 4.0),
    this.separatorMargin = const EdgeInsets.symmetric(horizontal: 4.0),
    this.spaceBetween = 8.0,
    this.alignment = Alignment.center,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.backgroundColor,
    this.borderRadius = BorderRadius.zero,
    this.border,
    this.shadow,
    this.showDays = true,
    this.showHours = true,
    this.showMinutes = true,
    this.showSeconds = true,
    this.showMilliseconds = false,
    this.showLabels = true,
    this.showSeparators = true,
    this.format = 'dd:HH:mm:ss',
  });

  /// 默认样式
  static VelocityCountDownStyle defaults() => VelocityCountDownStyle();

  /// 数字样式
  final TextStyle digitStyle;

  /// 标签样式
  final TextStyle labelStyle;

  /// 分隔符样式
  final TextStyle separatorStyle;

  /// 数字背景颜色
  final Color? digitBackgroundColor;

  /// 数字圆角
  final BorderRadius digitBorderRadius;

  /// 数字内边距
  final EdgeInsets digitPadding;

  /// 数字外边距
  final EdgeInsets digitMargin;

  /// 标签外边距
  final EdgeInsets labelMargin;

  /// 分隔符外边距
  final EdgeInsets separatorMargin;

  /// 各部分之间的间距
  final double spaceBetween;

  /// 对齐方式
  final Alignment alignment;

  /// 内边距
  final EdgeInsets padding;

  /// 外边距
  final EdgeInsets margin;

  /// 背景颜色
  final Color? backgroundColor;

  /// 圆角
  final BorderRadius borderRadius;

  /// 边框
  final BoxBorder? border;

  /// 阴影
  final BoxShadow? shadow;

  /// 是否显示天
  final bool showDays;

  /// 是否显示时
  final bool showHours;

  /// 是否显示分
  final bool showMinutes;

  /// 是否显示秒
  final bool showSeconds;

  /// 是否显示毫秒
  final bool showMilliseconds;

  /// 是否显示标签
  final bool showLabels;

  /// 是否显示分隔符
  final bool showSeparators;

  /// 时间格式
  final String format;

  /// 复制样式并替换指定属性
  VelocityCountDownStyle copyWith({
    TextStyle? digitStyle,
    TextStyle? labelStyle,
    TextStyle? separatorStyle,
    Color? digitBackgroundColor,
    BorderRadius? digitBorderRadius,
    EdgeInsets? digitPadding,
    EdgeInsets? digitMargin,
    EdgeInsets? labelMargin,
    EdgeInsets? separatorMargin,
    double? spaceBetween,
    Alignment? alignment,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    BoxBorder? border,
    BoxShadow? shadow,
    bool? showDays,
    bool? showHours,
    bool? showMinutes,
    bool? showSeconds,
    bool? showMilliseconds,
    bool? showLabels,
    bool? showSeparators,
    String? format,
  }) {
    return VelocityCountDownStyle(
      digitStyle: digitStyle ?? this.digitStyle,
      labelStyle: labelStyle ?? this.labelStyle,
      separatorStyle: separatorStyle ?? this.separatorStyle,
      digitBackgroundColor: digitBackgroundColor ?? this.digitBackgroundColor,
      digitBorderRadius: digitBorderRadius ?? this.digitBorderRadius,
      digitPadding: digitPadding ?? this.digitPadding,
      digitMargin: digitMargin ?? this.digitMargin,
      labelMargin: labelMargin ?? this.labelMargin,
      separatorMargin: separatorMargin ?? this.separatorMargin,
      spaceBetween: spaceBetween ?? this.spaceBetween,
      alignment: alignment ?? this.alignment,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      border: border ?? this.border,
      shadow: shadow ?? this.shadow,
      showDays: showDays ?? this.showDays,
      showHours: showHours ?? this.showHours,
      showMinutes: showMinutes ?? this.showMinutes,
      showSeconds: showSeconds ?? this.showSeconds,
      showMilliseconds: showMilliseconds ?? this.showMilliseconds,
      showLabels: showLabels ?? this.showLabels,
      showSeparators: showSeparators ?? this.showSeparators,
      format: format ?? this.format,
    );
  }
}

/// 倒计时格式化类型
enum VelocityCountDownFormatType {
  /// 天
  days,

  /// 时
  hours,

  /// 分
  minutes,

  /// 秒
  seconds,

  /// 毫秒
  milliseconds,
}
