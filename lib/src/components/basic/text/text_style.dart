/// VelocityUI 文本样式
library velocity_text_style;

import 'package:flutter/material.dart';

/// 文本样式配置
class VelocityTextStyle {
  /// 创建文本样式
  const VelocityTextStyle({
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.color,
    this.height,
    this.letterSpacing,
    this.decoration,
  });

  /// 字体大小
  final double? fontSize;

  /// 字体粗细
  final FontWeight? fontWeight;

  /// 字体族
  final String? fontFamily;

  /// 颜色
  final Color? color;

  /// 行高
  final double? height;

  /// 字间距
  final double? letterSpacing;

  /// 装饰
  final TextDecoration? decoration;

  /// 根据变体解析样式
  static VelocityTextStyle resolve({
    dynamic variant,
    VelocityTextStyle? customStyle,
  }) {
    final baseStyle = variant != null
        ? _getStyleForVariant(variant)
        : const VelocityTextStyle();

    return VelocityTextStyle(
      fontSize: customStyle?.fontSize ?? baseStyle.fontSize,
      fontWeight: customStyle?.fontWeight ?? baseStyle.fontWeight,
      fontFamily: customStyle?.fontFamily ?? baseStyle.fontFamily,
      color: customStyle?.color ?? baseStyle.color,
      height: customStyle?.height ?? baseStyle.height,
      letterSpacing: customStyle?.letterSpacing ?? baseStyle.letterSpacing,
      decoration: customStyle?.decoration ?? baseStyle.decoration,
    );
  }

  static VelocityTextStyle _getStyleForVariant(dynamic variant) {
    final variantName = variant.toString().split('.').last;

    switch (variantName) {
      case 'displayLarge':
        return const VelocityTextStyle(
            fontSize: 57,
            fontWeight: FontWeight.w400,
            height: 1.12,
            letterSpacing: -0.25);
      case 'displayMedium':
        return const VelocityTextStyle(
            fontSize: 45, fontWeight: FontWeight.w400, height: 1.16);
      case 'displaySmall':
        return const VelocityTextStyle(
            fontSize: 36, fontWeight: FontWeight.w400, height: 1.22);
      case 'headlineLarge':
        return const VelocityTextStyle(
            fontSize: 32, fontWeight: FontWeight.w400, height: 1.25);
      case 'headlineMedium':
        return const VelocityTextStyle(
            fontSize: 28, fontWeight: FontWeight.w400, height: 1.29);
      case 'headlineSmall':
        return const VelocityTextStyle(
            fontSize: 24, fontWeight: FontWeight.w400, height: 1.33);
      case 'titleLarge':
        return const VelocityTextStyle(
            fontSize: 22, fontWeight: FontWeight.w500, height: 1.27);
      case 'titleMedium':
        return const VelocityTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 1.5,
            letterSpacing: 0.15);
      case 'titleSmall':
        return const VelocityTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.43,
            letterSpacing: 0.1);
      case 'bodyLarge':
        return const VelocityTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 1.5,
            letterSpacing: 0.5);
      case 'bodyMedium':
        return const VelocityTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.43,
            letterSpacing: 0.25);
      case 'bodySmall':
        return const VelocityTextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            height: 1.33,
            letterSpacing: 0.4);
      case 'labelLarge':
        return const VelocityTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.43,
            letterSpacing: 0.1);
      case 'labelMedium':
        return const VelocityTextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            height: 1.33,
            letterSpacing: 0.5);
      case 'labelSmall':
        return const VelocityTextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            height: 1.45,
            letterSpacing: 0.5);
      default:
        return const VelocityTextStyle(
            fontSize: 14, fontWeight: FontWeight.w400, height: 1.43);
    }
  }

  /// 转换为 TextStyle
  TextStyle toTextStyle() {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
      decoration: decoration,
    );
  }

  /// 复制并修改
  VelocityTextStyle copyWith({
    double? fontSize,
    FontWeight? fontWeight,
    String? fontFamily,
    Color? color,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
  }) {
    return VelocityTextStyle(
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      fontFamily: fontFamily ?? this.fontFamily,
      color: color ?? this.color,
      height: height ?? this.height,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      decoration: decoration ?? this.decoration,
    );
  }
}
