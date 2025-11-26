import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';
import 'package:zephyr_ui/src/core/constants/enums.dart' as core_enums;
import 'package:zephyr_ui/src/components/shared/constants/enums.dart'
    as component_enums;

/// ZephyrUI 主题扩展工具
///
/// 提供主题相关的扩展方法和工具函数。
class ZephyrThemeExtensions {
  /// 获取主题中的颜色
  static Color getColor(
    BuildContext context, {
    required core_enums.ZephyrVariant variant,
    bool isBackground = false,
  }) {
    final theme = ZephyrTheme.of(context);

    switch (variant) {
      case core_enums.ZephyrVariant.primary:
        return isBackground ? theme.primaryColor : theme.primaryColor;
      case core_enums.ZephyrVariant.secondary:
        return isBackground ? theme.secondaryColor : theme.secondaryColor;
      case core_enums.ZephyrVariant.success:
        return Colors.green;
      case core_enums.ZephyrVariant.warning:
        return Colors.orange;
      case core_enums.ZephyrVariant.info:
        return Colors.blue;
      case core_enums.ZephyrVariant.link:
        return theme.primaryColor;
      case core_enums.ZephyrVariant.error:
        return theme.errorColor;
      case core_enums.ZephyrVariant.neutral:
        return Colors.grey[600]!;
      case core_enums.ZephyrVariant.outline:
        return isBackground ? Colors.transparent : theme.primaryColor;
      case core_enums.ZephyrVariant.ghost:
        return isBackground ? Colors.transparent : theme.primaryColor;
    }
  }

  /// 获取文本样式
  static TextStyle getTextStyle(
    BuildContext context, {
    core_enums.ZephyrSize size = core_enums.ZephyrSize.md,
    FontWeight? fontWeight,
    Color? color,
  }) {
    final theme = ZephyrTheme.of(context);
    final baseSize = theme.textTheme.bodyMedium?.fontSize ?? 14.0;

    return TextStyle(
      fontSize: baseSize * size.value,
      fontWeight: fontWeight,
      color: color ?? theme.textTheme.bodyMedium?.color,
    );
  }

  /// 获取间距
  static double getSpacing(
    BuildContext context, {
    core_enums.ZephyrSize size = core_enums.ZephyrSize.md,
  }) {
    final theme = ZephyrTheme.of(context);
    return theme.spacing * size.value;
  }

  /// 获取圆角
  static BorderRadius getBorderRadius(
    BuildContext context, {
    component_enums.ZephyrBorderRadius radius =
        component_enums.ZephyrBorderRadius.md,
  }) {
    final spacing = getSpacing(context);

    switch (radius) {
      case component_enums.ZephyrBorderRadius.none:
        return BorderRadius.zero;
      case component_enums.ZephyrBorderRadius.sm:
        return BorderRadius.circular(spacing * 0.25);
      case component_enums.ZephyrBorderRadius.md:
        return BorderRadius.circular(spacing * 0.5);
      case component_enums.ZephyrBorderRadius.lg:
        return BorderRadius.circular(spacing * 0.75);
      case component_enums.ZephyrBorderRadius.xl:
        return BorderRadius.circular(spacing);
      case component_enums.ZephyrBorderRadius.full:
        return BorderRadius.circular(spacing * 2);
    }
  }

  /// 获取阴影
  static List<BoxShadow> getShadow(
    BuildContext context, {
    component_enums.ZephyrShadowLevel level =
        component_enums.ZephyrShadowLevel.md,
  }) {
    switch (level) {
      case component_enums.ZephyrShadowLevel.none:
        return [];
      case component_enums.ZephyrShadowLevel.sm:
        return [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ];
      case component_enums.ZephyrShadowLevel.md:
        return [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ];
      case component_enums.ZephyrShadowLevel.lg:
        return [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ];
      case component_enums.ZephyrShadowLevel.xl:
        return [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ];
    }
  }

  /// 检查是否为暗色主题
  static bool isDarkTheme(BuildContext context) {
    final theme = ZephyrTheme.of(context);
    return theme.brightness == Brightness.dark;
  }

  /// 获取当前断点
  static core_enums.ZephyrBreakpoint getCurrentBreakpoint(
      BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 1600) return core_enums.ZephyrBreakpoint.xxl;
    if (width >= 1200) return core_enums.ZephyrBreakpoint.xl;
    if (width >= 992) return core_enums.ZephyrBreakpoint.lg;
    if (width >= 768) return core_enums.ZephyrBreakpoint.md;
    if (width >= 576) return core_enums.ZephyrBreakpoint.sm;
    return core_enums.ZephyrBreakpoint.xs;
  }

  /// 检查是否匹配断点
  static bool matchesBreakpoint(
    BuildContext context,
    core_enums.ZephyrBreakpoint breakpoint,
  ) {
    final current = getCurrentBreakpoint(context);
    return current.index >= breakpoint.index;
  }
}

/// ZephyrUI 组件主题工具
///
/// 提供组件主题相关的便捷工具方法。
class ZephyrComponentThemeUtils {
  /// 创建亮色主题
  static ZephyrThemeData createLightTheme({
    Color? primaryColor,
    Color? secondaryColor,
    Color? backgroundColor,
    Color? errorColor,
    double? spacing,
  }) {
    return ZephyrThemeData.light().copyWith(
      primaryColor: primaryColor,
      secondaryColor: secondaryColor,
      backgroundColor: backgroundColor,
      errorColor: errorColor,
      spacing: spacing,
    );
  }

  /// 创建暗色主题
  static ZephyrThemeData createDarkTheme({
    Color? primaryColor,
    Color? secondaryColor,
    Color? backgroundColor,
    Color? errorColor,
    double? spacing,
  }) {
    return ZephyrThemeData.dark().copyWith(
      primaryColor: primaryColor,
      secondaryColor: secondaryColor,
      backgroundColor: backgroundColor,
      errorColor: errorColor,
      spacing: spacing,
    );
  }

  /// 从Material主题创建Zephyr主题
  static ZephyrThemeData fromMaterialTheme(
    ThemeData materialTheme, {
    double? spacing,
  }) {
    final isDark = materialTheme.brightness == Brightness.dark;

    if (isDark) {
      return ZephyrThemeData.dark().copyWith(
        primaryColor: materialTheme.primaryColor,
        secondaryColor: materialTheme.colorScheme.secondary,
        backgroundColor: materialTheme.scaffoldBackgroundColor,
        errorColor: materialTheme.colorScheme.error,
        textTheme: materialTheme.textTheme,
        spacing: spacing,
      );
    } else {
      return ZephyrThemeData.light().copyWith(
        primaryColor: materialTheme.primaryColor,
        secondaryColor: materialTheme.colorScheme.secondary,
        backgroundColor: materialTheme.scaffoldBackgroundColor,
        errorColor: materialTheme.colorScheme.error,
        textTheme: materialTheme.textTheme,
        spacing: spacing,
      );
    }
  }
}
