/// ZephyrUI 页头组件
///
/// 提供页面顶部导航栏，支持标题、操作按钮、菜单等功能。
library header;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI 页头
///
/// 页面顶部导航栏组件，支持标题、操作按钮、菜单等功能。
///
/// 示例用法:
/// ```dart
/// ZephyrHeader(
///   title: '应用标题',
///   leading: Icon(Icons.menu),
///   actions: [
///     Icon(Icons.search),
///     Icon(Icons.more_vert),
///   ],
/// )
/// ```
class ZephyrHeader extends StatelessWidget {
  /// 创建页头
  const ZephyrHeader({
    super.key,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.actions = const [],
    this.height,
    this.padding,
    this.backgroundColor,
    this.elevation,
    this.border,
    this.theme,
    this.centerTitle = false,
    this.responsive = true,
  });

  /// 标题
  final Widget? title;

  /// 副标题
  final Widget? subtitle;

  /// 前置组件（通常为菜单按钮）
  final Widget? leading;

  /// 后置组件
  final Widget? trailing;

  /// 操作按钮列表
  final List<Widget> actions;

  /// 高度
  final double? height;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 背景色
  final Color? backgroundColor;

  /// 阴影高度
  final double? elevation;

  /// 边框
  final Border? border;

  /// 主题
  final ZephyrHeaderTheme? theme;

  /// 标题是否居中
  final bool centerTitle;

  /// 是否启用响应式
  final bool responsive;

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = theme ?? ZephyrHeaderTheme.of(context);
    final effectiveHeight = height ?? effectiveTheme.height;
    final effectivePadding = padding ?? effectiveTheme.padding;
    final effectiveElevation = elevation ?? effectiveTheme.elevation;
    final effectiveBorder = border ?? effectiveTheme.border;

    return Container(
      height: effectiveHeight,
      decoration: BoxDecoration(
        color: backgroundColor ?? effectiveTheme.backgroundColor,
        border: effectiveBorder,
        boxShadow: (effectiveElevation ?? 0) > 0
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: (effectiveElevation ?? 0) * 2,
                  offset: Offset(0, effectiveElevation ?? 0),
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: effectivePadding ?? EdgeInsets.zero,
        child: Row(
          children: [
            // Leading widget
            if (leading != null) ...[
              leading!,
              const SizedBox(width: ZephyrSpacing.md),
            ],

            // Title area
            if (title != null || subtitle != null)
              Expanded(
                child: _buildTitleArea(effectiveTheme),
              ),

            // Actions
            if (actions.isNotEmpty) ...[
              ...actions.map((action) => Padding(
                    padding: const EdgeInsets.only(left: ZephyrSpacing.sm),
                    child: action,
                  )),
            ],

            // Trailing widget
            if (trailing != null) ...[
              const SizedBox(width: ZephyrSpacing.md),
              trailing!,
            ],
          ],
        ),
      ),
    );
  }

  /// 构建标题区域
  Widget _buildTitleArea(ZephyrHeaderTheme theme) {
    return Column(
      crossAxisAlignment:
          centerTitle ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (title != null)
          DefaultTextStyle(
            style: theme.titleStyle!,
            child: title!,
          ),
        if (subtitle != null) ...[
          const SizedBox(height: ZephyrSpacing.xs),
          DefaultTextStyle(
            style: theme.subtitleStyle!,
            child: subtitle!,
          ),
        ],
      ],
    );
  }
}

/// ZephyrUI 页头主题
class ZephyrHeaderTheme {
  /// 创建页头主题
  const ZephyrHeaderTheme({
    this.backgroundColor,
    this.height,
    this.padding,
    this.elevation,
    this.border,
    this.titleStyle,
    this.subtitleStyle,
  });

  /// 背景色
  final Color? backgroundColor;

  /// 高度
  final double? height;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 阴影高度
  final double? elevation;

  /// 边框
  final Border? border;

  /// 标题样式
  final TextStyle? titleStyle;

  /// 副标题样式
  final TextStyle? subtitleStyle;

  /// 从上下文获取主题
  static ZephyrHeaderTheme of(BuildContext context) {
    final zephyrTheme = ZephyrTheme.of(context);
    return _defaultTheme(zephyrTheme);
  }

  /// 默认主题
  static ZephyrHeaderTheme _defaultTheme(ZephyrThemeData zephyrTheme) {
    final isDark = zephyrTheme.brightness == Brightness.dark;
    final textTheme = Typography.material2018().englishLike;

    return ZephyrHeaderTheme(
      backgroundColor: isDark ? ZephyrColors.neutral800 : Colors.white,
      height: 64.0,
      padding: const EdgeInsets.symmetric(
        horizontal: ZephyrSpacing.lg,
        vertical: ZephyrSpacing.sm,
      ),
      elevation: 1.0,
      border: Border(
        bottom: BorderSide(
          color: isDark ? ZephyrColors.neutral700 : ZephyrColors.neutral200,
          width: 1,
        ),
      ),
      titleStyle: textTheme.titleLarge?.copyWith(
        color: isDark ? Colors.white : ZephyrColors.neutral900,
        fontWeight: FontWeight.w500,
      ),
      subtitleStyle: textTheme.bodySmall?.copyWith(
        color: isDark ? ZephyrColors.neutral300 : ZephyrColors.neutral600,
      ),
    );
  }

  /// 创建主题副本
  ZephyrHeaderTheme copyWith({
    Color? backgroundColor,
    double? height,
    EdgeInsetsGeometry? padding,
    double? elevation,
    Border? border,
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
  }) {
    return ZephyrHeaderTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      height: height ?? this.height,
      padding: padding ?? this.padding,
      elevation: elevation ?? this.elevation,
      border: border ?? this.border,
      titleStyle: titleStyle ?? this.titleStyle,
      subtitleStyle: subtitleStyle ?? this.subtitleStyle,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is ZephyrHeaderTheme &&
        other.backgroundColor == backgroundColor &&
        other.height == height &&
        other.padding == padding &&
        other.elevation == elevation &&
        other.border == border &&
        other.titleStyle == titleStyle &&
        other.subtitleStyle == subtitleStyle;
  }

  @override
  int get hashCode {
    return Object.hash(
      backgroundColor,
      height,
      padding,
      elevation,
      border,
      titleStyle,
      subtitleStyle,
    );
  }
}
