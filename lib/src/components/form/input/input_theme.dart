/// ZephyrUI 输入主题
///
/// 定义输入组件的主题样式。
library input_theme;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI 输入主题
class ZephyrInputTheme extends ThemeExtension<ZephyrInputTheme> {
  /// 创建输入主题
  const ZephyrInputTheme({
    required this.backgroundColor,
    required this.borderColor,
    required this.focusedBorderColor,
    required this.errorBorderColor,
    required this.errorBackgroundColor,
    required this.textStyle,
    required this.labelStyle,
    required this.placeholderStyle,
    required this.helperTextStyle,
    required this.errorTextStyle,
    required this.borderRadius,
  });

  /// 背景色
  final Color backgroundColor;

  /// 边框颜色
  final Color borderColor;

  /// 聚焦边框颜色
  final Color focusedBorderColor;

  /// 错误边框颜色
  final Color errorBorderColor;

  /// 错误背景色
  final Color errorBackgroundColor;

  /// 文本样式
  final TextStyle textStyle;

  /// 标签样式
  final TextStyle labelStyle;

  /// 占位符样式
  final TextStyle placeholderStyle;

  /// 帮助文本样式
  final TextStyle helperTextStyle;

  /// 错误文本样式
  final TextStyle errorTextStyle;

  /// 圆角
  final BorderRadius borderRadius;

  /// 从上下文获取主题
  static ZephyrInputTheme of(BuildContext context, ZephyrVariant variant) {
    final theme = Theme.of(context).extension<ZephyrInputTheme>();
    if (theme != null) return theme;
    
    final zephyrTheme = ZephyrTheme.of(context);
    return _createDefaultTheme(zephyrTheme, variant);
  }

  /// 创建默认主题
  static ZephyrInputTheme _createDefaultTheme(
    ZephyrThemeData zephyrTheme,
    ZephyrVariant variant,
  ) {
    final isDark = zephyrTheme.brightness == Brightness.dark;

    Color backgroundColor;
    Color borderColor;
    Color focusedBorderColor;
    Color textColor;

    switch (variant) {
      case ZephyrVariant.outline:
        backgroundColor = isDark ? ZephyrColors.neutral800 : Colors.white;
        borderColor =
            isDark ? ZephyrColors.neutral600 : ZephyrColors.neutral300;
        focusedBorderColor = zephyrTheme.primaryColor;
        textColor = isDark ? ZephyrColors.neutral100 : ZephyrColors.neutral900;
        break;
      case ZephyrVariant.neutral:
        backgroundColor =
            isDark ? ZephyrColors.neutral900 : ZephyrColors.neutral50;
        borderColor =
            isDark ? ZephyrColors.neutral600 : ZephyrColors.neutral300;
        focusedBorderColor = zephyrTheme.primaryColor;
        textColor = isDark ? ZephyrColors.neutral100 : ZephyrColors.neutral900;
        break;
      default:
        backgroundColor = isDark ? ZephyrColors.neutral800 : Colors.white;
        borderColor =
            isDark ? ZephyrColors.neutral600 : ZephyrColors.neutral300;
        focusedBorderColor = zephyrTheme.primaryColor;
        textColor = isDark ? ZephyrColors.neutral100 : ZephyrColors.neutral900;
    }

    return ZephyrInputTheme(
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      focusedBorderColor: focusedBorderColor,
      errorBorderColor: ZephyrColors.error500,
      errorBackgroundColor: isDark
          ? ZephyrColors.error500.withValues(alpha: 0.1)
          : ZephyrColors.error50,
      textStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize16,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: textColor,
        height: ZephyrTypography.lineHeight1_5,
      ),
      labelStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightMedium,
        color: isDark ? ZephyrColors.neutral200 : ZephyrColors.neutral700,
      ),
      placeholderStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize16,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: isDark ? ZephyrColors.neutral500 : ZephyrColors.neutral400,
      ),
      helperTextStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize12,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: isDark ? ZephyrColors.neutral400 : ZephyrColors.neutral600,
      ),
      errorTextStyle: const TextStyle(
        fontSize: ZephyrTypography.fontSize12,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: ZephyrColors.error500,
      ),
      borderRadius: BorderRadius.circular(ZephyrRadius.md),
    );
  }

  @override
  ZephyrInputTheme copyWith({
    Color? backgroundColor,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    Color? errorBackgroundColor,
    TextStyle? textStyle,
    TextStyle? labelStyle,
    TextStyle? placeholderStyle,
    TextStyle? helperTextStyle,
    TextStyle? errorTextStyle,
    BorderRadius? borderRadius,
  }) {
    return ZephyrInputTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      focusedBorderColor: focusedBorderColor ?? this.focusedBorderColor,
      errorBorderColor: errorBorderColor ?? this.errorBorderColor,
      errorBackgroundColor: errorBackgroundColor ?? this.errorBackgroundColor,
      textStyle: textStyle ?? this.textStyle,
      labelStyle: labelStyle ?? this.labelStyle,
      placeholderStyle: placeholderStyle ?? this.placeholderStyle,
      helperTextStyle: helperTextStyle ?? this.helperTextStyle,
      errorTextStyle: errorTextStyle ?? this.errorTextStyle,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  ZephyrInputTheme lerp(ThemeExtension<ZephyrInputTheme>? other, double t) {
    if (other is! ZephyrInputTheme) return this;
    
    return ZephyrInputTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ?? backgroundColor,
      borderColor: Color.lerp(borderColor, other.borderColor, t) ?? borderColor,
      focusedBorderColor: Color.lerp(focusedBorderColor, other.focusedBorderColor, t) ?? focusedBorderColor,
      errorBorderColor: Color.lerp(errorBorderColor, other.errorBorderColor, t) ?? errorBorderColor,
      errorBackgroundColor: Color.lerp(errorBackgroundColor, other.errorBackgroundColor, t) ?? errorBackgroundColor,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t) ?? textStyle,
      labelStyle: TextStyle.lerp(labelStyle, other.labelStyle, t) ?? labelStyle,
      placeholderStyle: TextStyle.lerp(placeholderStyle, other.placeholderStyle, t) ?? placeholderStyle,
      helperTextStyle: TextStyle.lerp(helperTextStyle, other.helperTextStyle, t) ?? helperTextStyle,
      errorTextStyle: TextStyle.lerp(errorTextStyle, other.errorTextStyle, t) ?? errorTextStyle,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t) ?? borderRadius,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is ZephyrInputTheme &&
        other.backgroundColor == backgroundColor &&
        other.borderColor == borderColor &&
        other.focusedBorderColor == focusedBorderColor &&
        other.errorBorderColor == errorBorderColor &&
        other.errorBackgroundColor == errorBackgroundColor &&
        other.textStyle == textStyle &&
        other.labelStyle == labelStyle &&
        other.placeholderStyle == placeholderStyle &&
        other.helperTextStyle == helperTextStyle &&
        other.errorTextStyle == errorTextStyle &&
        other.borderRadius == borderRadius;
  }

  @override
  int get hashCode {
    return Object.hash(
      backgroundColor,
      borderColor,
      focusedBorderColor,
      errorBorderColor,
      errorBackgroundColor,
      textStyle,
      labelStyle,
      placeholderStyle,
      helperTextStyle,
      errorTextStyle,
      borderRadius,
    );
  }
}
