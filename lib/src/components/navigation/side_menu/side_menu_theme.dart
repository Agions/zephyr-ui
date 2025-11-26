import 'package:flutter/material.dart';

/// 定义ZephyrSideMenu的视觉属性
///
/// 此主题用于ZephyrSideMenu组件确定视觉样式，包括背景色、文本样式等。
class ZephyrSideMenuTheme {
  const ZephyrSideMenuTheme({
    required this.selectedItemColor,
    required this.unselectedItemColor,
    this.backgroundColor,
    this.width,
    this.contentPadding,
    this.itemHeight,
    this.itemSpacing,
    this.itemTextStyle,
    this.activeItemTextStyle,
    this.activeItemBackgroundColor,
    this.iconColor,
    this.activeIconColor,
    this.dividerColor,
    this.dividerThickness,
    this.headerBackgroundColor,
    this.headerTextStyle,
    this.footerBackgroundColor,
  });

  /// 侧边菜单背景色
  final Color? backgroundColor;

  /// 侧边菜单宽度
  final double? width;

  /// 内容区域内边距
  final EdgeInsetsGeometry? contentPadding;

  /// 菜单项高度
  final double? itemHeight;

  /// 菜单项间距
  final double? itemSpacing;

  /// 菜单项文本样式
  final TextStyle? itemTextStyle;

  /// 激活状态菜单项文本样式
  final TextStyle? activeItemTextStyle;

  /// 激活状态菜单项背景色
  final Color? activeItemBackgroundColor;

  /// 图标颜色
  final Color? iconColor;

  /// 激活状态图标颜色
  final Color? activeIconColor;

  /// 分割线颜色
  final Color? dividerColor;

  /// 分割线厚度
  final double? dividerThickness;

  /// 菜单头部背景色
  final Color? headerBackgroundColor;

  /// 菜单头部文本样式
  final TextStyle? headerTextStyle;

  /// 菜单底部背景色
  final Color? footerBackgroundColor;

  /// 选中项颜色
  final Color selectedItemColor;

  /// 未选中项颜色
  final Color unselectedItemColor;

  /// 创建当前主题的副本，并替换指定字段
  ZephyrSideMenuTheme copyWith({
    Color? backgroundColor,
    double? width,
    EdgeInsetsGeometry? contentPadding,
    double? itemHeight,
    double? itemSpacing,
    TextStyle? itemTextStyle,
    TextStyle? activeItemTextStyle,
    Color? activeItemBackgroundColor,
    Color? iconColor,
    Color? activeIconColor,
    Color? dividerColor,
    double? dividerThickness,
    Color? headerBackgroundColor,
    TextStyle? headerTextStyle,
    Color? footerBackgroundColor,
    Color? selectedItemColor,
    Color? unselectedItemColor,
  }) {
    return ZephyrSideMenuTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      width: width ?? this.width,
      contentPadding: contentPadding ?? this.contentPadding,
      itemHeight: itemHeight ?? this.itemHeight,
      itemSpacing: itemSpacing ?? this.itemSpacing,
      itemTextStyle: itemTextStyle ?? this.itemTextStyle,
      activeItemTextStyle: activeItemTextStyle ?? this.activeItemTextStyle,
      activeItemBackgroundColor:
          activeItemBackgroundColor ?? this.activeItemBackgroundColor,
      iconColor: iconColor ?? this.iconColor,
      activeIconColor: activeIconColor ?? this.activeIconColor,
      dividerColor: dividerColor ?? this.dividerColor,
      dividerThickness: dividerThickness ?? this.dividerThickness,
      headerBackgroundColor:
          headerBackgroundColor ?? this.headerBackgroundColor,
      headerTextStyle: headerTextStyle ?? this.headerTextStyle,
      footerBackgroundColor:
          footerBackgroundColor ?? this.footerBackgroundColor,
      selectedItemColor: selectedItemColor ?? this.selectedItemColor,
      unselectedItemColor: unselectedItemColor ?? this.unselectedItemColor,
    );
  }

  /// 从父主题和当前主题解析出最终主题
  ///
  /// 如果当前主题的属性为null，则使用父主题的对应属性
  static ZephyrSideMenuTheme resolve(
    BuildContext context,
    ZephyrSideMenuTheme? theme,
  ) {
    final defaultTheme = _defaultTheme(context);

    if (theme == null) {
      return defaultTheme;
    }

    return ZephyrSideMenuTheme(
      backgroundColor: theme.backgroundColor ?? defaultTheme.backgroundColor,
      width: theme.width ?? defaultTheme.width,
      contentPadding: theme.contentPadding ?? defaultTheme.contentPadding,
      itemHeight: theme.itemHeight ?? defaultTheme.itemHeight,
      itemSpacing: theme.itemSpacing ?? defaultTheme.itemSpacing,
      itemTextStyle: theme.itemTextStyle ?? defaultTheme.itemTextStyle,
      activeItemTextStyle:
          theme.activeItemTextStyle ?? defaultTheme.activeItemTextStyle,
      activeItemBackgroundColor: theme.activeItemBackgroundColor ??
          defaultTheme.activeItemBackgroundColor,
      iconColor: theme.iconColor ?? defaultTheme.iconColor,
      activeIconColor: theme.activeIconColor ?? defaultTheme.activeIconColor,
      dividerColor: theme.dividerColor ?? defaultTheme.dividerColor,
      dividerThickness: theme.dividerThickness ?? defaultTheme.dividerThickness,
      headerBackgroundColor:
          theme.headerBackgroundColor ?? defaultTheme.headerBackgroundColor,
      headerTextStyle: theme.headerTextStyle ?? defaultTheme.headerTextStyle,
      footerBackgroundColor:
          theme.footerBackgroundColor ?? defaultTheme.footerBackgroundColor,
      selectedItemColor: theme.selectedItemColor,
      unselectedItemColor: theme.unselectedItemColor,
    );
  }

  /// 创建默认主题
  static ZephyrSideMenuTheme _defaultTheme(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ZephyrSideMenuTheme(
      backgroundColor: isDark ? const Color(0xFF212121) : Colors.white,
      width: 240.0,
      contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
      itemHeight: 48.0,
      itemSpacing: 4.0,
      itemTextStyle: TextStyle(
        fontSize: 14.0,
        color: isDark ? Colors.white70 : Colors.black87,
      ),
      activeItemTextStyle: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: theme.colorScheme.primary,
      ),
      activeItemBackgroundColor:
          theme.colorScheme.primary.withValues(alpha: 0.12),
      iconColor: isDark ? Colors.white70 : Colors.black54,
      activeIconColor: theme.colorScheme.primary,
      dividerColor: isDark ? Colors.white24 : Colors.black12,
      dividerThickness: 1.0,
      headerBackgroundColor:
          isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F5F5),
      headerTextStyle: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: isDark ? Colors.white : Colors.black87,
      ),
      footerBackgroundColor:
          isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F5F5),
      selectedItemColor: theme.colorScheme.primary,
      unselectedItemColor: isDark ? Colors.white70 : Colors.black87,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ZephyrSideMenuTheme &&
        other.backgroundColor == backgroundColor &&
        other.width == width &&
        other.contentPadding == contentPadding &&
        other.itemHeight == itemHeight &&
        other.itemSpacing == itemSpacing &&
        other.itemTextStyle == itemTextStyle &&
        other.activeItemTextStyle == activeItemTextStyle &&
        other.activeItemBackgroundColor == activeItemBackgroundColor &&
        other.iconColor == iconColor &&
        other.activeIconColor == activeIconColor &&
        other.dividerColor == dividerColor &&
        other.dividerThickness == dividerThickness &&
        other.headerBackgroundColor == headerBackgroundColor &&
        other.headerTextStyle == headerTextStyle &&
        other.footerBackgroundColor == footerBackgroundColor &&
        other.selectedItemColor == selectedItemColor &&
        other.unselectedItemColor == unselectedItemColor;
  }

  @override
  int get hashCode => Object.hash(
        backgroundColor,
        width,
        contentPadding,
        itemHeight,
        itemSpacing,
        itemTextStyle,
        activeItemTextStyle,
        activeItemBackgroundColor,
        iconColor,
        activeIconColor,
        dividerColor,
        dividerThickness,
        headerBackgroundColor,
        headerTextStyle,
        footerBackgroundColor,
        selectedItemColor,
        unselectedItemColor,
      );
}
