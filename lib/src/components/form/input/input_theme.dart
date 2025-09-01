import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// Zephyr输入框主题
/// 
/// 定义输入框的视觉样式，包括颜色、边框、内边距等。
class ZephyrInputTheme {
  /// 创建输入框主题
  const ZephyrInputTheme({
    this.fillColor,
    this.focusedFillColor,
    this.disabledFillColor,
    this.errorFillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.disabledBorderColor,
    this.borderWidth = 1.0,
    this.focusedBorderWidth = 2.0,
    this.disabledBorderWidth = 1.0,
    this.errorBorderWidth = 1.0,
    this.errorColor,
    this.borderRadius = 8.0,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.textStyle,
    this.placeholderStyle,
    this.disabledTextColor,
    this.textColor,
    this.prefixStyle,
    this.suffixStyle,
    this.helperStyle,
    this.errorStyle,
    this.counterStyle,
    this.iconSize = 20,
    this.iconColor,
    this.focusedIconColor,
    this.disabledIconColor,
    this.helperSpacing = 4.0,
    this.errorSpacing = 4.0,
  });

  /// 填充颜色
  final Color? fillColor;

  /// 聚焦时填充颜色
  final Color? focusedFillColor;

  /// 禁用时填充颜色
  final Color? disabledFillColor;

  /// 错误时填充颜色
  final Color? errorFillColor;

  /// 边框颜色
  final Color? borderColor;

  /// 聚焦时边框颜色
  final Color? focusedBorderColor;

  /// 禁用时边框颜色
  final Color? disabledBorderColor;

  /// 边框宽度
  final double borderWidth;

  /// 聚焦时边框宽度
  final double focusedBorderWidth;

  /// 禁用时边框宽度
  final double disabledBorderWidth;

  /// 错误时边框宽度
  final double errorBorderWidth;

  /// 错误颜色
  final Color? errorColor;

  /// 边框圆角
  final double borderRadius;

  /// 内容内边距
  final EdgeInsetsGeometry contentPadding;

  /// 文本样式
  final TextStyle? textStyle;

  /// 占位符样式
  final TextStyle? placeholderStyle;

  /// 禁用时文本颜色
  final Color? disabledTextColor;

  /// 文本颜色
  final Color? textColor;

  /// 前缀文本样式
  final TextStyle? prefixStyle;

  /// 后缀文本样式
  final TextStyle? suffixStyle;

  /// 帮助文本样式
  final TextStyle? helperStyle;

  /// 错误文本样式
  final TextStyle? errorStyle;

  /// 计数器文本样式
  final TextStyle? counterStyle;

  /// 图标大小
  final double iconSize;

  /// 图标颜色
  final Color? iconColor;

  /// 聚焦时图标颜色
  final Color? focusedIconColor;

  /// 禁用时图标颜色
  final Color? disabledIconColor;

  /// 帮助文本间距
  final double helperSpacing;

  /// 错误文本间距
  final double errorSpacing;

  /// 创建默认主题
  factory ZephyrInputTheme.light() {
    return ZephyrInputTheme(
      fillColor: ZephyrColors.neutral50,
      focusedFillColor: ZephyrColors.neutral100,
      disabledFillColor: ZephyrColors.neutral100,
      errorFillColor: ZephyrColors.error50,
      borderColor: ZephyrColors.neutral300,
      focusedBorderColor: ZephyrColors.primary500,
      disabledBorderColor: ZephyrColors.neutral200,
      errorColor: ZephyrColors.error500,
      borderWidth: 1.0,
      focusedBorderWidth: 2.0,
      disabledBorderWidth: 1.0,
      errorBorderWidth: 1.0,
      borderRadius: 8.0,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: ZephyrColors.neutral900,
        height: 1.5,
      ),
      placeholderStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: ZephyrColors.neutral500,
        height: 1.5,
      ),
      disabledTextColor: ZephyrColors.neutral400,
      textColor: ZephyrColors.neutral900,
      prefixStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: ZephyrColors.neutral700,
      ),
      suffixStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: ZephyrColors.neutral700,
      ),
      helperStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: ZephyrColors.neutral600,
      ),
      errorStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: ZephyrColors.error500,
      ),
      counterStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: ZephyrColors.neutral500,
      ),
      iconSize: 20,
      iconColor: ZephyrColors.neutral500,
      focusedIconColor: ZephyrColors.primary500,
      disabledIconColor: ZephyrColors.neutral400,
      helperSpacing: 4.0,
      errorSpacing: 4.0,
    );
  }

  /// 创建暗色主题
  factory ZephyrInputTheme.dark() {
    return ZephyrInputTheme(
      fillColor: ZephyrColors.neutral800,
      focusedFillColor: ZephyrColors.neutral700,
      disabledFillColor: ZephyrColors.neutral900,
      errorFillColor: ZephyrColors.error900,
      borderColor: ZephyrColors.neutral600,
      focusedBorderColor: ZephyrColors.primary400,
      disabledBorderColor: ZephyrColors.neutral700,
      errorColor: ZephyrColors.error400,
      borderWidth: 1.0,
      focusedBorderWidth: 2.0,
      disabledBorderWidth: 1.0,
      errorBorderWidth: 1.0,
      borderRadius: 8.0,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: ZephyrColors.neutral50,
        height: 1.5,
      ),
      placeholderStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: ZephyrColors.neutral400,
        height: 1.5,
      ),
      disabledTextColor: ZephyrColors.neutral600,
      textColor: ZephyrColors.neutral50,
      prefixStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: ZephyrColors.neutral200,
      ),
      suffixStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: ZephyrColors.neutral200,
      ),
      helperStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: ZephyrColors.neutral400,
      ),
      errorStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: ZephyrColors.error400,
      ),
      counterStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: ZephyrColors.neutral500,
      ),
      iconSize: 20,
      iconColor: ZephyrColors.neutral400,
      focusedIconColor: ZephyrColors.primary400,
      disabledIconColor: ZephyrColors.neutral600,
      helperSpacing: 4.0,
      errorSpacing: 4.0,
    );
  }

  /// 解析主题
  static ZephyrInputTheme resolve(
    BuildContext context,
    ZephyrInputTheme? theme,
  ) {
    final zephyrTheme = ZephyrTheme.of(context);
    return theme ?? zephyrTheme.zephyrInputTheme;
  }

  /// 复制主题并覆盖部分属性
  ZephyrInputTheme copyWith({
    Color? fillColor,
    Color? focusedFillColor,
    Color? disabledFillColor,
    Color? errorFillColor,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? disabledBorderColor,
    double? borderWidth,
    double? focusedBorderWidth,
    double? disabledBorderWidth,
    double? errorBorderWidth,
    Color? errorColor,
    double? borderRadius,
    EdgeInsetsGeometry? contentPadding,
    TextStyle? textStyle,
    TextStyle? placeholderStyle,
    Color? disabledTextColor,
    Color? textColor,
    TextStyle? prefixStyle,
    TextStyle? suffixStyle,
    TextStyle? helperStyle,
    TextStyle? errorStyle,
    TextStyle? counterStyle,
    double? iconSize,
    Color? iconColor,
    Color? focusedIconColor,
    Color? disabledIconColor,
    double? helperSpacing,
    double? errorSpacing,
  }) {
    return ZephyrInputTheme(
      fillColor: fillColor ?? this.fillColor,
      focusedFillColor: focusedFillColor ?? this.focusedFillColor,
      disabledFillColor: disabledFillColor ?? this.disabledFillColor,
      errorFillColor: errorFillColor ?? this.errorFillColor,
      borderColor: borderColor ?? this.borderColor,
      focusedBorderColor: focusedBorderColor ?? this.focusedBorderColor,
      disabledBorderColor: disabledBorderColor ?? this.disabledBorderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      focusedBorderWidth: focusedBorderWidth ?? this.focusedBorderWidth,
      disabledBorderWidth: disabledBorderWidth ?? this.disabledBorderWidth,
      errorBorderWidth: errorBorderWidth ?? this.errorBorderWidth,
      errorColor: errorColor ?? this.errorColor,
      borderRadius: borderRadius ?? this.borderRadius,
      contentPadding: contentPadding ?? this.contentPadding,
      textStyle: textStyle ?? this.textStyle,
      placeholderStyle: placeholderStyle ?? this.placeholderStyle,
      disabledTextColor: disabledTextColor ?? this.disabledTextColor,
      textColor: textColor ?? this.textColor,
      prefixStyle: prefixStyle ?? this.prefixStyle,
      suffixStyle: suffixStyle ?? this.suffixStyle,
      helperStyle: helperStyle ?? this.helperStyle,
      errorStyle: errorStyle ?? this.errorStyle,
      counterStyle: counterStyle ?? this.counterStyle,
      iconSize: iconSize ?? this.iconSize,
      iconColor: iconColor ?? this.iconColor,
      focusedIconColor: focusedIconColor ?? this.focusedIconColor,
      disabledIconColor: disabledIconColor ?? this.disabledIconColor,
      helperSpacing: helperSpacing ?? this.helperSpacing,
      errorSpacing: errorSpacing ?? this.errorSpacing,
    );
  }
}