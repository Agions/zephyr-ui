/// ZephyrUI 开关主题
///
/// 定义开关组件的主题样式。
library switch_theme;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI 开关主题
class ZephyrSwitchTheme {
  /// 创建开关主题
  const ZephyrSwitchTheme({
    required this.activeColor,
    required this.inactiveColor,
    required this.thumbColor,
    required this.disabledColor,
    required this.disabledThumbColor,
    required this.borderColor,
    required this.borderWidth,
    required this.thumbShadow,
  });

  /// 激活状态颜色
  final Color activeColor;

  /// 非激活状态颜色
  final Color inactiveColor;

  /// 滑块颜色
  final Color thumbColor;

  /// 禁用状态颜色
  final Color disabledColor;

  /// 禁用状态滑块颜色
  final Color disabledThumbColor;

  /// 边框颜色
  final Color borderColor;

  /// 边框宽度
  final double borderWidth;

  /// 滑块阴影
  final List<BoxShadow> thumbShadow;

  /// 从上下文获取主题
  static ZephyrSwitchTheme of(BuildContext context, ZephyrVariant variant) {
    final zephyrTheme = ZephyrTheme.of(context);
    return _createTheme(zephyrTheme, variant);
  }

  /// 创建主题
  static ZephyrSwitchTheme _createTheme(
    ZephyrThemeData zephyrTheme,
    ZephyrVariant variant,
  ) {
    final isDark = zephyrTheme.brightness == Brightness.dark;

    Color activeColor;
    Color inactiveColor;

    switch (variant) {
      case ZephyrVariant.primary:
        activeColor = zephyrTheme.primaryColor;
        break;
      case ZephyrVariant.secondary:
        activeColor = zephyrTheme.secondaryColor;
        break;
      case ZephyrVariant.success:
        activeColor = ZephyrColors.success500;
        break;
      case ZephyrVariant.warning:
        activeColor = ZephyrColors.warning500;
        break;
      case ZephyrVariant.error:
        activeColor = ZephyrColors.error500;
        break;
      case ZephyrVariant.info:
        activeColor = ZephyrColors.info500;
        break;
      default:
        activeColor = zephyrTheme.primaryColor;
    }

    inactiveColor = isDark ? ZephyrColors.neutral600 : ZephyrColors.neutral300;

    return ZephyrSwitchTheme(
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      thumbColor: Colors.white,
      disabledColor: isDark ? ZephyrColors.neutral700 : ZephyrColors.neutral200,
      disabledThumbColor:
          isDark ? ZephyrColors.neutral500 : ZephyrColors.neutral400,
      borderColor: isDark ? ZephyrColors.neutral600 : ZephyrColors.neutral300,
      borderWidth: 0,
      thumbShadow: [
        const const BoxShadow(
          color: Colors.black.withValues(alpha: 0.2),
          blurRadius: 2,
          offset: const Offset(0, 1),
        ),
      ],
    );
  }

  /// 创建主题副本
  ZephyrSwitchTheme copyWith({
    Color? activeColor,
    Color? inactiveColor,
    Color? thumbColor,
    Color? disabledColor,
    Color? disabledThumbColor,
    Color? borderColor,
    double? borderWidth,
    List<BoxShadow>? thumbShadow,
  }) {
    return ZephyrSwitchTheme(
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      thumbColor: thumbColor ?? this.thumbColor,
      disabledColor: disabledColor ?? this.disabledColor,
      disabledThumbColor: disabledThumbColor ?? this.disabledThumbColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      thumbShadow: thumbShadow ?? this.thumbShadow,
    );
  }

  /// 线性插值
  static ZephyrSwitchTheme lerp(
    ZephyrSwitchTheme? a,
    ZephyrSwitchTheme? b,
    double t,
  ) {
    if (a == null && b == null) {
      return ZephyrSwitchTheme(
        activeColor: Colors.blue,
        inactiveColor: Colors.grey,
        thumbColor: Colors.white,
        disabledColor: Colors.grey[300]!,
        disabledThumbColor: Colors.grey[400]!,
        borderColor: Colors.grey,
        borderWidth: 0,
        thumbShadow: const [],
      );
    }
    if (a == null) return b!;
    if (b == null) return a;

    return ZephyrSwitchTheme(
      activeColor: Color.lerp(a.activeColor, b.activeColor, t)!,
      inactiveColor: Color.lerp(a.inactiveColor, b.inactiveColor, t)!,
      thumbColor: Color.lerp(a.thumbColor, b.thumbColor, t)!,
      disabledColor: Color.lerp(a.disabledColor, b.disabledColor, t)!,
      disabledThumbColor:
          Color.lerp(a.disabledThumbColor, b.disabledThumbColor, t)!,
      borderColor: Color.lerp(a.borderColor, b.borderColor, t)!,
      borderWidth: a.borderWidth + (b.borderWidth - a.borderWidth) * t,
      thumbShadow: BoxShadow.lerpList(a.thumbShadow, b.thumbShadow, t) ?? [],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is ZephyrSwitchTheme &&
        other.activeColor == activeColor &&
        other.inactiveColor == inactiveColor &&
        other.thumbColor == thumbColor &&
        other.disabledColor == disabledColor &&
        other.disabledThumbColor == disabledThumbColor &&
        other.borderColor == borderColor &&
        other.borderWidth == borderWidth &&
        other.thumbShadow == thumbShadow;
  }

  @override
  int get hashCode {
    return Object.hash(
      activeColor,
      inactiveColor,
      thumbColor,
      disabledColor,
      disabledThumbColor,
      borderColor,
      borderWidth,
      thumbShadow,
    );
  }
}
