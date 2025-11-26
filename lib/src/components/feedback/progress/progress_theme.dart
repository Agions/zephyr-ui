/// ZephyrUI 进度条主题
///
/// 定义进度条组件的主题样式。
library progress_theme;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI 进度条主题
class ZephyrProgressTheme {
  /// 创建进度条主题
  const ZephyrProgressTheme({
    required this.backgroundColor,
    required this.valueColor,
    required this.labelStyle,
  });

  /// 背景色
  final Color backgroundColor;

  /// 进度条颜色
  final Color valueColor;

  /// 标签样式
  final TextStyle labelStyle;

  /// 从上下文获取主题
  static ZephyrProgressTheme of(BuildContext context, ZephyrVariant variant) {
    final zephyrTheme = ZephyrTheme.of(context);
    return _createTheme(zephyrTheme, variant);
  }

  /// 创建主题
  static ZephyrProgressTheme _createTheme(
    ZephyrThemeData zephyrTheme,
    ZephyrVariant variant,
  ) {
    final isDark = zephyrTheme.brightness == Brightness.dark;

    Color valueColor;
    switch (variant) {
      case ZephyrVariant.primary:
        valueColor = zephyrTheme.primaryColor;
        break;
      case ZephyrVariant.secondary:
        valueColor = zephyrTheme.secondaryColor;
        break;
      case ZephyrVariant.success:
        valueColor = ZephyrColors.success500;
        break;
      case ZephyrVariant.warning:
        valueColor = ZephyrColors.warning500;
        break;
      case ZephyrVariant.error:
        valueColor = ZephyrColors.error500;
        break;
      case ZephyrVariant.info:
        valueColor = ZephyrColors.info500;
        break;
      default:
        valueColor = zephyrTheme.primaryColor;
    }

    return ZephyrProgressTheme(
      backgroundColor:
          isDark ? ZephyrColors.neutral700 : ZephyrColors.neutral200,
      valueColor: valueColor,
      labelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: isDark ? ZephyrColors.neutral200 : ZephyrColors.neutral700,
      ),
    );
  }

  /// 创建主题副本
  ZephyrProgressTheme copyWith({
    Color? backgroundColor,
    Color? valueColor,
    TextStyle? labelStyle,
  }) {
    return ZephyrProgressTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      valueColor: valueColor ?? this.valueColor,
      labelStyle: labelStyle ?? this.labelStyle,
    );
  }

  /// 线性插值
  static ZephyrProgressTheme lerp(
    ZephyrProgressTheme? a,
    ZephyrProgressTheme? b,
    double t,
  ) {
    if (a == null && b == null) {
      return ZephyrProgressTheme(
        backgroundColor: Colors.grey[300]!,
        valueColor: Colors.blue,
        labelStyle: const TextStyle(),
      );
    }
    if (a == null) return b!;
    if (b == null) return a;

    return ZephyrProgressTheme(
      backgroundColor: Color.lerp(a.backgroundColor, b.backgroundColor, t)!,
      valueColor: Color.lerp(a.valueColor, b.valueColor, t)!,
      labelStyle: TextStyle.lerp(a.labelStyle, b.labelStyle, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is ZephyrProgressTheme &&
        other.backgroundColor == backgroundColor &&
        other.valueColor == valueColor &&
        other.labelStyle == labelStyle;
  }

  @override
  int get hashCode {
    return Object.hash(
      backgroundColor,
      valueColor,
      labelStyle,
    );
  }
}
