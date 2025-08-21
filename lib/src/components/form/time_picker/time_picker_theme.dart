/// ZephyrUI 时间选择器主题
///
/// 定义时间选择器组件的主题样式。
library time_picker_theme;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI 时间选择器主题
class ZephyrTimePickerTheme extends ThemeExtension<ZephyrTimePickerTheme> {
  /// 创建时间选择器主题
  const ZephyrTimePickerTheme({
    required this.headerBackgroundColor,
    required this.headerTextStyle,
    required this.timeNumberStyle,
    required this.timeSeparatorStyle,
    required this.labelStyle,
    required this.periodStyle,
    required this.selectedPeriodStyle,
    required this.selectedPeriodColor,
    required this.buttonTextStyle,
    required this.confirmButtonColor,
    required this.borderColor,
    required this.iconColor,
    required this.disabledIconColor,
    required this.borderRadius,
  });

  /// 头部背景色
  final Color headerBackgroundColor;

  /// 头部文本样式
  final TextStyle headerTextStyle;

  /// 时间数字样式
  final TextStyle timeNumberStyle;

  /// 时间分隔符样式
  final TextStyle timeSeparatorStyle;

  /// 标签样式
  final TextStyle labelStyle;

  /// 时间段样式
  final TextStyle periodStyle;

  /// 选中时间段样式
  final TextStyle selectedPeriodStyle;

  /// 选中时间段背景色
  final Color selectedPeriodColor;

  /// 按钮文本样式
  final TextStyle buttonTextStyle;

  /// 确认按钮颜色
  final Color confirmButtonColor;

  /// 边框颜色
  final Color borderColor;

  /// 图标颜色
  final Color iconColor;

  /// 禁用图标颜色
  final Color disabledIconColor;

  /// 圆角
  final BorderRadius borderRadius;

  /// 从上下文获取主题
  static ZephyrTimePickerTheme of(BuildContext context) {
    final theme = Theme.of(context).extension<ZephyrTimePickerTheme>();
    if (theme != null) return theme;
    
    final zephyrTheme = ZephyrTheme.of(context);
    return _createDefaultTheme(zephyrTheme);
  }

  /// 创建默认主题
  static ZephyrTimePickerTheme _createDefaultTheme(
    ZephyrThemeData zephyrTheme,
  ) {
    final isDark = zephyrTheme.brightness == Brightness.dark;

    return ZephyrTimePickerTheme(
      headerBackgroundColor: zephyrTheme.primaryColor,
      headerTextStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize18,
        fontWeight: ZephyrTypography.fontWeightMedium,
        color: Colors.white,
      ),
      timeNumberStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize24,
        fontWeight: ZephyrTypography.fontWeightMedium,
        color: isDark ? ZephyrColors.neutral100 : ZephyrColors.neutral900,
      ),
      timeSeparatorStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize24,
        fontWeight: ZephyrTypography.fontWeightMedium,
        color: isDark ? ZephyrColors.neutral100 : ZephyrColors.neutral900,
      ),
      labelStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize12,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: isDark ? ZephyrColors.neutral400 : ZephyrColors.neutral600,
      ),
      periodStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightRegular,
        color: isDark ? ZephyrColors.neutral300 : ZephyrColors.neutral700,
      ),
      selectedPeriodStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightMedium,
        color: Colors.white,
      ),
      selectedPeriodColor: zephyrTheme.primaryColor,
      buttonTextStyle: TextStyle(
        fontSize: ZephyrTypography.fontSize14,
        fontWeight: ZephyrTypography.fontWeightMedium,
        color: zephyrTheme.primaryColor,
      ),
      confirmButtonColor: zephyrTheme.primaryColor,
      borderColor: isDark ? ZephyrColors.neutral600 : ZephyrColors.neutral300,
      iconColor: isDark ? ZephyrColors.neutral300 : ZephyrColors.neutral700,
      disabledIconColor: isDark ? ZephyrColors.neutral600 : ZephyrColors.neutral400,
      borderRadius: BorderRadius.circular(ZephyrRadius.md),
    );
  }

  @override
  ZephyrTimePickerTheme copyWith({
    Color? headerBackgroundColor,
    TextStyle? headerTextStyle,
    TextStyle? timeNumberStyle,
    TextStyle? timeSeparatorStyle,
    TextStyle? labelStyle,
    TextStyle? periodStyle,
    TextStyle? selectedPeriodStyle,
    Color? selectedPeriodColor,
    TextStyle? buttonTextStyle,
    Color? confirmButtonColor,
    Color? borderColor,
    Color? iconColor,
    Color? disabledIconColor,
    BorderRadius? borderRadius,
  }) {
    return ZephyrTimePickerTheme(
      headerBackgroundColor: headerBackgroundColor ?? this.headerBackgroundColor,
      headerTextStyle: headerTextStyle ?? this.headerTextStyle,
      timeNumberStyle: timeNumberStyle ?? this.timeNumberStyle,
      timeSeparatorStyle: timeSeparatorStyle ?? this.timeSeparatorStyle,
      labelStyle: labelStyle ?? this.labelStyle,
      periodStyle: periodStyle ?? this.periodStyle,
      selectedPeriodStyle: selectedPeriodStyle ?? this.selectedPeriodStyle,
      selectedPeriodColor: selectedPeriodColor ?? this.selectedPeriodColor,
      buttonTextStyle: buttonTextStyle ?? this.buttonTextStyle,
      confirmButtonColor: confirmButtonColor ?? this.confirmButtonColor,
      borderColor: borderColor ?? this.borderColor,
      iconColor: iconColor ?? this.iconColor,
      disabledIconColor: disabledIconColor ?? this.disabledIconColor,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  ZephyrTimePickerTheme lerp(ThemeExtension<ZephyrTimePickerTheme>? other, double t) {
    if (other is! ZephyrTimePickerTheme) return this;
    
    return ZephyrTimePickerTheme(
      headerBackgroundColor: Color.lerp(headerBackgroundColor, other.headerBackgroundColor, t) ?? headerBackgroundColor,
      headerTextStyle: TextStyle.lerp(headerTextStyle, other.headerTextStyle, t) ?? headerTextStyle,
      timeNumberStyle: TextStyle.lerp(timeNumberStyle, other.timeNumberStyle, t) ?? timeNumberStyle,
      timeSeparatorStyle: TextStyle.lerp(timeSeparatorStyle, other.timeSeparatorStyle, t) ?? timeSeparatorStyle,
      labelStyle: TextStyle.lerp(labelStyle, other.labelStyle, t) ?? labelStyle,
      periodStyle: TextStyle.lerp(periodStyle, other.periodStyle, t) ?? periodStyle,
      selectedPeriodStyle: TextStyle.lerp(selectedPeriodStyle, other.selectedPeriodStyle, t) ?? selectedPeriodStyle,
      selectedPeriodColor: Color.lerp(selectedPeriodColor, other.selectedPeriodColor, t) ?? selectedPeriodColor,
      buttonTextStyle: TextStyle.lerp(buttonTextStyle, other.buttonTextStyle, t) ?? buttonTextStyle,
      confirmButtonColor: Color.lerp(confirmButtonColor, other.confirmButtonColor, t) ?? confirmButtonColor,
      borderColor: Color.lerp(borderColor, other.borderColor, t) ?? borderColor,
      iconColor: Color.lerp(iconColor, other.iconColor, t) ?? iconColor,
      disabledIconColor: Color.lerp(disabledIconColor, other.disabledIconColor, t) ?? disabledIconColor,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t) ?? borderRadius,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is ZephyrTimePickerTheme &&
        other.headerBackgroundColor == headerBackgroundColor &&
        other.headerTextStyle == headerTextStyle &&
        other.timeNumberStyle == timeNumberStyle &&
        other.timeSeparatorStyle == timeSeparatorStyle &&
        other.labelStyle == labelStyle &&
        other.periodStyle == periodStyle &&
        other.selectedPeriodStyle == selectedPeriodStyle &&
        other.selectedPeriodColor == selectedPeriodColor &&
        other.buttonTextStyle == buttonTextStyle &&
        other.confirmButtonColor == confirmButtonColor &&
        other.borderColor == borderColor &&
        other.iconColor == iconColor &&
        other.disabledIconColor == disabledIconColor &&
        other.borderRadius == borderRadius;
  }

  @override
  int get hashCode {
    return Object.hash(
      headerBackgroundColor,
      headerTextStyle,
      timeNumberStyle,
      timeSeparatorStyle,
      labelStyle,
      periodStyle,
      selectedPeriodStyle,
      selectedPeriodColor,
      buttonTextStyle,
      confirmButtonColor,
      borderColor,
      iconColor,
      disabledIconColor,
      borderRadius,
    );
  }

  /// 创建亮色主题
  static ZephyrTimePickerTheme light() {
    return _createDefaultTheme(ZephyrThemeData.light());
  }

  /// 创建暗色主题
  static ZephyrTimePickerTheme dark() {
    return _createDefaultTheme(ZephyrThemeData.dark());
  }
}