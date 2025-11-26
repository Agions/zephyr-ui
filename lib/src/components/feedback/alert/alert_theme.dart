/// ZephyrUI 警告主题
///
/// 定义警告组件的主题样式。
library alert_theme;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI 警告主题
class ZephyrAlertTheme extends ThemeExtension<ZephyrAlertTheme> {
  /// 创建警告主题
  const ZephyrAlertTheme({
    required this.backgroundColor,
    required this.borderColor,
    required this.iconColor,
    required this.titleStyle,
    required this.messageStyle,
    required this.padding,
    required this.margin,
    required this.borderRadius,
    required this.border,
  });

  /// 背景色
  final Color backgroundColor;

  /// 边框颜色
  final Color borderColor;

  /// 图标颜色
  final Color iconColor;

  /// 标题样式
  final TextStyle titleStyle;

  /// 消息样式
  final TextStyle messageStyle;

  /// 内边距
  final EdgeInsetsGeometry padding;

  /// 外边距
  final EdgeInsetsGeometry margin;

  /// 圆角
  final BorderRadius borderRadius;

  /// 边框
  final Border border;

  /// 从上下文获取主题
  static ZephyrAlertTheme of(BuildContext context, ZephyrVariant variant) {
    final theme = Theme.of(context).extension<ZephyrAlertTheme>();
    if (theme != null) return theme;

    final zephyrTheme = ZephyrTheme.of(context);
    return _createDefaultTheme(zephyrTheme, variant);
  }

  /// 创建默认主题
  static ZephyrAlertTheme _createDefaultTheme(
    ZephyrThemeData zephyrTheme,
    ZephyrVariant variant,
  ) {
    final isDark = zephyrTheme.brightness == Brightness.dark;

    Color backgroundColor;
    Color borderColor;
    Color iconColor;
    Color textColor;

    switch (variant) {
      case ZephyrVariant.success:
        backgroundColor = isDark
            ? ZephyrColors.success700.withValues(alpha: 0.2)
            : ZephyrColors.success50;
        borderColor = ZephyrColors.success500;
        iconColor = ZephyrColors.success700;
        textColor = isDark ? ZephyrColors.success50 : ZephyrColors.success700;
        break;
      case ZephyrVariant.warning:
        backgroundColor = isDark
            ? ZephyrColors.warning700.withValues(alpha: 0.2)
            : ZephyrColors.warning50;
        borderColor = ZephyrColors.warning500;
        iconColor = ZephyrColors.warning700;
        textColor = isDark ? ZephyrColors.warning50 : ZephyrColors.warning700;
        break;
      case ZephyrVariant.error:
        backgroundColor = isDark
            ? ZephyrColors.error700.withValues(alpha: 0.2)
            : ZephyrColors.error50;
        borderColor = ZephyrColors.error500;
        iconColor = ZephyrColors.error700;
        textColor = isDark ? ZephyrColors.error50 : ZephyrColors.error700;
        break;
      case ZephyrVariant.info:
        backgroundColor = isDark
            ? ZephyrColors.info700.withValues(alpha: 0.2)
            : ZephyrColors.info50;
        borderColor = ZephyrColors.info500;
        iconColor = ZephyrColors.info700;
        textColor = isDark ? ZephyrColors.info50 : ZephyrColors.info700;
        break;
      default:
        backgroundColor =
            isDark ? ZephyrColors.neutral800 : ZephyrColors.neutral100;
        borderColor =
            isDark ? ZephyrColors.neutral600 : ZephyrColors.neutral300;
        iconColor = isDark ? ZephyrColors.neutral400 : ZephyrColors.neutral600;
        textColor = isDark ? ZephyrColors.neutral200 : ZephyrColors.neutral800;
    }

    return ZephyrAlertTheme(
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      iconColor: iconColor,
      titleStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textColor,
        height: 1.4,
      ),
      messageStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: textColor,
        height: 1.5,
      ),
      padding: const EdgeInsets.all(ZephyrSpacing.lg),
      margin: const EdgeInsets.only(bottom: ZephyrSpacing.md),
      borderRadius: const BorderRadius.circular(ZephyrRadius.md),
      border: Border.all(color: borderColor, width: 1),
    );
  }

  @override
  ZephyrAlertTheme copyWith({
    Color? backgroundColor,
    Color? borderColor,
    Color? iconColor,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BorderRadius? borderRadius,
    Border? border,
  }) {
    return ZephyrAlertTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      iconColor: iconColor ?? this.iconColor,
      titleStyle: titleStyle ?? this.titleStyle,
      messageStyle: messageStyle ?? this.messageStyle,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      borderRadius: borderRadius ?? this.borderRadius,
      border: border ?? this.border,
    );
  }

  @override
  ZephyrAlertTheme lerp(ThemeExtension<ZephyrAlertTheme>? other, double t) {
    if (other is! ZephyrAlertTheme) return this;

    return ZephyrAlertTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ??
          backgroundColor,
      borderColor: Color.lerp(borderColor, other.borderColor, t) ?? borderColor,
      iconColor: Color.lerp(iconColor, other.iconColor, t) ?? iconColor,
      titleStyle: TextStyle.lerp(titleStyle, other.titleStyle, t) ?? titleStyle,
      messageStyle:
          TextStyle.lerp(messageStyle, other.messageStyle, t) ?? messageStyle,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t) ?? padding,
      margin: EdgeInsetsGeometry.lerp(margin, other.margin, t) ?? margin,
      borderRadius: const BorderRadius.lerp(borderRadius, other.borderRadius, t) ??
          borderRadius,
      border: Border.lerp(border, other.border, t) ?? border,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is ZephyrAlertTheme &&
        other.backgroundColor == backgroundColor &&
        other.borderColor == borderColor &&
        other.iconColor == iconColor &&
        other.titleStyle == titleStyle &&
        other.messageStyle == messageStyle &&
        other.padding == padding &&
        other.margin == margin &&
        other.borderRadius == borderRadius &&
        other.border == border;
  }

  @override
  int get hashCode {
    return Object.hash(
      backgroundColor,
      borderColor,
      iconColor,
      titleStyle,
      messageStyle,
      padding,
      margin,
      borderRadius,
      border,
    );
  }
}
