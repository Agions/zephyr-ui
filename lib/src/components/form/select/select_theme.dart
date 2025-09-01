import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// 选择器组件主题
class ZephyrSelectTheme extends ThemeExtension<ZephyrSelectTheme> {
  /// 创建选择器主题
  const ZephyrSelectTheme({
    required this.backgroundColor,
    required this.borderColor,
    required this.focusedBorderColor,
    required this.errorBorderColor,
    required this.disabledBackgroundColor,
    required this.disabledBorderColor,
    required this.textStyle,
    required this.labelStyle,
    required this.placeholderStyle,
    required this.helperTextStyle,
    required this.errorTextStyle,
    required this.dropdownBackgroundColor,
    required this.dropdownBorderColor,
    required this.dropdownShadowColor,
    required this.optionTextStyle,
    required this.selectedOptionTextStyle,
    required this.hoveredOptionBackgroundColor,
    required this.selectedOptionBackgroundColor,
    required this.borderRadius,
    required this.dropdownBorderRadius,
    required this.borderWidth,
    required this.elevation,
    required this.maxDropdownHeight,
  });

  /// 背景色
  final Color backgroundColor;

  /// 边框颜色
  final Color borderColor;

  /// 聚焦边框颜色
  final Color focusedBorderColor;

  /// 错误边框颜色
  final Color errorBorderColor;

  /// 禁用背景色
  final Color disabledBackgroundColor;

  /// 禁用边框颜色
  final Color disabledBorderColor;

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

  /// 下拉框背景色
  final Color dropdownBackgroundColor;

  /// 下拉框边框颜色
  final Color dropdownBorderColor;

  /// 下拉框阴影颜色
  final Color dropdownShadowColor;

  /// 选项文本样式
  final TextStyle optionTextStyle;

  /// 选中选项文本样式
  final TextStyle selectedOptionTextStyle;

  /// 悬停选项背景色
  final Color hoveredOptionBackgroundColor;

  /// 选中选项背景色
  final Color selectedOptionBackgroundColor;

  /// 边框圆角
  final BorderRadius borderRadius;

  /// 下拉框边框圆角
  final BorderRadius dropdownBorderRadius;

  /// 边框宽度
  final double borderWidth;

  /// 阴影高度
  final double elevation;

  /// 下拉框最大高度
  final double maxDropdownHeight;

  /// 从上下文获取主题
  static ZephyrSelectTheme of(BuildContext context) {
    final theme = Theme.of(context).extension<ZephyrSelectTheme>();
    if (theme != null) return theme;

    final zephyrTheme = ZephyrTheme.of(context);
    return _createDefaultTheme(zephyrTheme);
  }

  /// 创建默认主题
  static ZephyrSelectTheme _createDefaultTheme(ZephyrThemeData zephyrTheme) {
    final isDark = zephyrTheme.brightness == Brightness.dark;

    return ZephyrSelectTheme(
      backgroundColor: isDark ? ZephyrColors.neutral800 : Colors.white,
      borderColor: isDark ? ZephyrColors.neutral600 : ZephyrColors.neutral300,
      focusedBorderColor: zephyrTheme.primaryColor,
      errorBorderColor: ZephyrColors.error500,
      disabledBackgroundColor:
          isDark ? ZephyrColors.neutral700 : ZephyrColors.neutral100,
      disabledBorderColor:
          isDark ? ZephyrColors.neutral600 : ZephyrColors.neutral200,
      textStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize16,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: isDark ? ZephyrColors.neutral100 : ZephyrColors.neutral900,
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
        color: isDark ? ZephyrColors.neutral400 : ZephyrColors.neutral500,
        height: ZephyrTypography.lineHeight1_5,
      ),
      helperTextStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize12,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: isDark ? ZephyrColors.neutral300 : ZephyrColors.neutral600,
      ),
      errorTextStyle: const TextStyle(
        fontSize: ZephyrTypography.fontSize12,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: ZephyrColors.error500,
      ),
      dropdownBackgroundColor: isDark ? ZephyrColors.neutral800 : Colors.white,
      dropdownBorderColor:
          isDark ? ZephyrColors.neutral600 : ZephyrColors.neutral300,
      dropdownShadowColor: isDark
          ? Colors.black.withValues(alpha: 0.3)
          : Colors.black.withValues(alpha: 0.1),
      optionTextStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize16,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: isDark ? ZephyrColors.neutral100 : ZephyrColors.neutral900,
        height: ZephyrTypography.lineHeight1_5,
      ),
      selectedOptionTextStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize16,
        fontWeight: ZephyrTypography.fontWeightMedium,
        color: zephyrTheme.primaryColor,
        height: ZephyrTypography.lineHeight1_5,
      ),
      hoveredOptionBackgroundColor:
          isDark ? ZephyrColors.neutral700 : ZephyrColors.neutral50,
      selectedOptionBackgroundColor: isDark
          ? zephyrTheme.primaryColor.withValues(alpha: 0.2)
          : zephyrTheme.primaryColor.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(ZephyrRadius.md),
      dropdownBorderRadius: BorderRadius.circular(ZephyrRadius.md),
      borderWidth: 1.0,
      elevation: 4.0,
      maxDropdownHeight: 200.0,
    );
  }

  @override
  ZephyrSelectTheme copyWith({
    Color? backgroundColor,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    Color? disabledBackgroundColor,
    Color? disabledBorderColor,
    TextStyle? textStyle,
    TextStyle? labelStyle,
    TextStyle? placeholderStyle,
    TextStyle? helperTextStyle,
    TextStyle? errorTextStyle,
    Color? dropdownBackgroundColor,
    Color? dropdownBorderColor,
    Color? dropdownShadowColor,
    TextStyle? optionTextStyle,
    TextStyle? selectedOptionTextStyle,
    Color? hoveredOptionBackgroundColor,
    Color? selectedOptionBackgroundColor,
    BorderRadius? borderRadius,
    BorderRadius? dropdownBorderRadius,
    double? borderWidth,
    double? elevation,
    double? maxDropdownHeight,
  }) {
    return ZephyrSelectTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      focusedBorderColor: focusedBorderColor ?? this.focusedBorderColor,
      errorBorderColor: errorBorderColor ?? this.errorBorderColor,
      disabledBackgroundColor:
          disabledBackgroundColor ?? this.disabledBackgroundColor,
      disabledBorderColor: disabledBorderColor ?? this.disabledBorderColor,
      textStyle: textStyle ?? this.textStyle,
      labelStyle: labelStyle ?? this.labelStyle,
      placeholderStyle: placeholderStyle ?? this.placeholderStyle,
      helperTextStyle: helperTextStyle ?? this.helperTextStyle,
      errorTextStyle: errorTextStyle ?? this.errorTextStyle,
      dropdownBackgroundColor:
          dropdownBackgroundColor ?? this.dropdownBackgroundColor,
      dropdownBorderColor: dropdownBorderColor ?? this.dropdownBorderColor,
      dropdownShadowColor: dropdownShadowColor ?? this.dropdownShadowColor,
      optionTextStyle: optionTextStyle ?? this.optionTextStyle,
      selectedOptionTextStyle:
          selectedOptionTextStyle ?? this.selectedOptionTextStyle,
      hoveredOptionBackgroundColor:
          hoveredOptionBackgroundColor ?? this.hoveredOptionBackgroundColor,
      selectedOptionBackgroundColor:
          selectedOptionBackgroundColor ?? this.selectedOptionBackgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      dropdownBorderRadius: dropdownBorderRadius ?? this.dropdownBorderRadius,
      borderWidth: borderWidth ?? this.borderWidth,
      elevation: elevation ?? this.elevation,
      maxDropdownHeight: maxDropdownHeight ?? this.maxDropdownHeight,
    );
  }

  @override
  ZephyrSelectTheme lerp(ThemeExtension<ZephyrSelectTheme>? other, double t) {
    if (other is! ZephyrSelectTheme) return this;

    return ZephyrSelectTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      focusedBorderColor:
          Color.lerp(focusedBorderColor, other.focusedBorderColor, t)!,
      errorBorderColor:
          Color.lerp(errorBorderColor, other.errorBorderColor, t)!,
      disabledBackgroundColor: Color.lerp(
          disabledBackgroundColor, other.disabledBackgroundColor, t)!,
      disabledBorderColor:
          Color.lerp(disabledBorderColor, other.disabledBorderColor, t)!,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
      labelStyle: TextStyle.lerp(labelStyle, other.labelStyle, t)!,
      placeholderStyle:
          TextStyle.lerp(placeholderStyle, other.placeholderStyle, t)!,
      helperTextStyle:
          TextStyle.lerp(helperTextStyle, other.helperTextStyle, t)!,
      errorTextStyle: TextStyle.lerp(errorTextStyle, other.errorTextStyle, t)!,
      dropdownBackgroundColor: Color.lerp(
          dropdownBackgroundColor, other.dropdownBackgroundColor, t)!,
      dropdownBorderColor:
          Color.lerp(dropdownBorderColor, other.dropdownBorderColor, t)!,
      dropdownShadowColor:
          Color.lerp(dropdownShadowColor, other.dropdownShadowColor, t)!,
      optionTextStyle:
          TextStyle.lerp(optionTextStyle, other.optionTextStyle, t)!,
      selectedOptionTextStyle: TextStyle.lerp(
          selectedOptionTextStyle, other.selectedOptionTextStyle, t)!,
      hoveredOptionBackgroundColor: Color.lerp(
          hoveredOptionBackgroundColor, other.hoveredOptionBackgroundColor, t)!,
      selectedOptionBackgroundColor: Color.lerp(selectedOptionBackgroundColor,
          other.selectedOptionBackgroundColor, t)!,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
      dropdownBorderRadius: BorderRadius.lerp(
          dropdownBorderRadius, other.dropdownBorderRadius, t)!,
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t),
      elevation: lerpDouble(elevation, other.elevation, t),
      maxDropdownHeight:
          lerpDouble(maxDropdownHeight, other.maxDropdownHeight, t),
    );
  }
}

/// 线性插值辅助函数
double lerpDouble(double a, double b, double t) {
  return a + (b - a) * t;
}
