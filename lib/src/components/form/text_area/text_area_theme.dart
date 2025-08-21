/// ZephyrUI 文本域主题
///
/// 定义文本域组件的主题样式。
library text_area_theme;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI 文本域主题
class ZephyrTextAreaTheme extends ThemeExtension<ZephyrTextAreaTheme> {
  /// 创建文本域主题
  const ZephyrTextAreaTheme({
    required this.backgroundColor,
    required this.borderColor,
    required this.focusedBorderColor,
    required this.errorBorderColor,
    required this.disabledBorderColor,
    required this.errorBackgroundColor,
    required this.textStyle,
    required this.labelStyle,
    required this.placeholderStyle,
    required this.helperTextStyle,
    required this.errorTextStyle,
    required this.warningTextStyle,
    required this.characterCountStyle,
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

  /// 禁用边框颜色
  final Color disabledBorderColor;

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

  /// 警告文本样式
  final TextStyle warningTextStyle;

  /// 字符计数样式
  final TextStyle characterCountStyle;

  /// 圆角
  final BorderRadius borderRadius;

  /// 从上下文获取主题
  static ZephyrTextAreaTheme of(BuildContext context, ZephyrVariant variant) {
    final theme = Theme.of(context).extension<ZephyrTextAreaTheme>();
    if (theme != null) return theme;
    
    final zephyrTheme = ZephyrTheme.of(context);
    return _createDefaultTheme(zephyrTheme, variant);
  }

  /// 创建默认主题
  static ZephyrTextAreaTheme _createDefaultTheme(
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

    return ZephyrTextAreaTheme(
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      focusedBorderColor: focusedBorderColor,
      errorBorderColor: ZephyrColors.error500,
      disabledBorderColor: isDark ? ZephyrColors.neutral700 : ZephyrColors.neutral200,
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
      warningTextStyle: const TextStyle(
        fontSize: ZephyrTypography.fontSize12,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: ZephyrColors.warning500,
      ),
      characterCountStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize12,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: isDark ? ZephyrColors.neutral500 : ZephyrColors.neutral400,
      ),
      borderRadius: BorderRadius.circular(ZephyrRadius.md),
    );
  }

  @override
  ZephyrTextAreaTheme copyWith({
    Color? backgroundColor,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    Color? disabledBorderColor,
    Color? errorBackgroundColor,
    TextStyle? textStyle,
    TextStyle? labelStyle,
    TextStyle? placeholderStyle,
    TextStyle? helperTextStyle,
    TextStyle? errorTextStyle,
    TextStyle? warningTextStyle,
    TextStyle? characterCountStyle,
    BorderRadius? borderRadius,
  }) {
    return ZephyrTextAreaTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      focusedBorderColor: focusedBorderColor ?? this.focusedBorderColor,
      errorBorderColor: errorBorderColor ?? this.errorBorderColor,
      disabledBorderColor: disabledBorderColor ?? this.disabledBorderColor,
      errorBackgroundColor: errorBackgroundColor ?? this.errorBackgroundColor,
      textStyle: textStyle ?? this.textStyle,
      labelStyle: labelStyle ?? this.labelStyle,
      placeholderStyle: placeholderStyle ?? this.placeholderStyle,
      helperTextStyle: helperTextStyle ?? this.helperTextStyle,
      errorTextStyle: errorTextStyle ?? this.errorTextStyle,
      warningTextStyle: warningTextStyle ?? this.warningTextStyle,
      characterCountStyle: characterCountStyle ?? this.characterCountStyle,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  ZephyrTextAreaTheme lerp(ThemeExtension<ZephyrTextAreaTheme>? other, double t) {
    if (other is! ZephyrTextAreaTheme) return this;
    
    return ZephyrTextAreaTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ?? backgroundColor,
      borderColor: Color.lerp(borderColor, other.borderColor, t) ?? borderColor,
      focusedBorderColor: Color.lerp(focusedBorderColor, other.focusedBorderColor, t) ?? focusedBorderColor,
      errorBorderColor: Color.lerp(errorBorderColor, other.errorBorderColor, t) ?? errorBorderColor,
      disabledBorderColor: Color.lerp(disabledBorderColor, other.disabledBorderColor, t) ?? disabledBorderColor,
      errorBackgroundColor: Color.lerp(errorBackgroundColor, other.errorBackgroundColor, t) ?? errorBackgroundColor,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t) ?? textStyle,
      labelStyle: TextStyle.lerp(labelStyle, other.labelStyle, t) ?? labelStyle,
      placeholderStyle: TextStyle.lerp(placeholderStyle, other.placeholderStyle, t) ?? placeholderStyle,
      helperTextStyle: TextStyle.lerp(helperTextStyle, other.helperTextStyle, t) ?? helperTextStyle,
      errorTextStyle: TextStyle.lerp(errorTextStyle, other.errorTextStyle, t) ?? errorTextStyle,
      warningTextStyle: TextStyle.lerp(warningTextStyle, other.warningTextStyle, t) ?? warningTextStyle,
      characterCountStyle: TextStyle.lerp(characterCountStyle, other.characterCountStyle, t) ?? characterCountStyle,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t) ?? borderRadius,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is ZephyrTextAreaTheme &&
        other.backgroundColor == backgroundColor &&
        other.borderColor == borderColor &&
        other.focusedBorderColor == focusedBorderColor &&
        other.errorBorderColor == errorBorderColor &&
        other.disabledBorderColor == disabledBorderColor &&
        other.errorBackgroundColor == errorBackgroundColor &&
        other.textStyle == textStyle &&
        other.labelStyle == labelStyle &&
        other.placeholderStyle == placeholderStyle &&
        other.helperTextStyle == helperTextStyle &&
        other.errorTextStyle == errorTextStyle &&
        other.warningTextStyle == warningTextStyle &&
        other.characterCountStyle == characterCountStyle &&
        other.borderRadius == borderRadius;
  }

  @override
  int get hashCode {
    return Object.hash(
      backgroundColor,
      borderColor,
      focusedBorderColor,
      errorBorderColor,
      disabledBorderColor,
      errorBackgroundColor,
      textStyle,
      labelStyle,
      placeholderStyle,
      helperTextStyle,
      errorTextStyle,
      warningTextStyle,
      characterCountStyle,
      borderRadius,
    );
  }

  /// 创建亮色主题
  static ZephyrTextAreaTheme light() {
    return _createDefaultTheme(
      ZephyrThemeData.light(),
      ZephyrVariant.primary,
    );
  }

  /// 创建暗色主题
  static ZephyrTextAreaTheme dark() {
    return _createDefaultTheme(
      ZephyrThemeData.dark(),
      ZephyrVariant.primary,
    );
  }
}