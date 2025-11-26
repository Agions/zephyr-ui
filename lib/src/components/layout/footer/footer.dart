/// ZephyrUI 页脚组件
///
/// 提供页面底部信息栏，支持版权信息、链接等内容。
library footer;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI 页脚
///
/// 页面底部信息栏组件，支持版权信息、链接等内容。
///
/// 示例用法:
/// ```dart
/// ZephyrFooter(
///   child: Text('© 2024 ZephyrUI. All rights reserved.'),
/// )
/// ```
class ZephyrFooter extends StatelessWidget {
  /// 创建页脚
  const ZephyrFooter({
    required this.child,
    super.key,
    this.height,
    this.padding,
    this.backgroundColor,
    this.border,
    this.theme,
    this.sticky = false,
    this.alignment,
  });

  /// 子组件
  final Widget child;

  /// 高度
  final double? height;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 背景色
  final Color? backgroundColor;

  /// 边框
  final Border? border;

  /// 主题
  final ZephyrFooterTheme? theme;

  /// 是否固定在底部
  final bool sticky;

  /// 对齐方式
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = theme ?? ZephyrFooterTheme.of(context);
    final effectiveHeight = height ?? effectiveTheme.height;
    final effectivePadding = padding ?? effectiveTheme.padding;
    final effectiveAlignment = alignment ?? effectiveTheme.alignment;
    final effectiveBorder = border ?? effectiveTheme.border;

    Widget footer = Container(
      height: effectiveHeight,
      padding: effectivePadding,
      decoration: BoxDecoration(
        color: backgroundColor ?? effectiveTheme.backgroundColor,
        border: effectiveBorder,
      ),
      child: Align(
        alignment: effectiveAlignment ?? Alignment.center,
        child: DefaultTextStyle(
          style: effectiveTheme.textStyle!,
          child: child,
        ),
      ),
    );

    // 如果需要固定在底部，使用 Positioned 或 SliverPersistentHeader
    if (sticky) {
      footer = Container(
        color: backgroundColor ?? effectiveTheme.backgroundColor,
        child: footer,
      );
    }

    return footer;
  }
}

/// ZephyrUI 页脚主题
class ZephyrFooterTheme {
  /// 创建页脚主题
  const ZephyrFooterTheme({
    this.backgroundColor,
    this.height,
    this.padding,
    this.border,
    this.textStyle,
    this.alignment,
  });

  /// 背景色
  final Color? backgroundColor;

  /// 高度
  final double? height;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 边框
  final Border? border;

  /// 文本样式
  final TextStyle? textStyle;

  /// 对齐方式
  final AlignmentGeometry? alignment;

  /// 从上下文获取主题
  static ZephyrFooterTheme of(BuildContext context) {
    final zephyrTheme = ZephyrTheme.of(context);
    return _defaultTheme(zephyrTheme);
  }

  /// 默认主题
  static ZephyrFooterTheme _defaultTheme(ZephyrThemeData zephyrTheme) {
    final isDark = zephyrTheme.brightness == Brightness.dark;
    final textTheme = Typography.material2018().englishLike;

    return ZephyrFooterTheme(
      backgroundColor:
          isDark ? ZephyrColors.neutral800 : ZephyrColors.neutral50,
      height: 48.0,
      padding: const EdgeInsets.symmetric(
        horizontal: ZephyrSpacing.lg,
        vertical: ZephyrSpacing.sm,
      ),
      border: Border(
        top: BorderSide(
          color: isDark ? ZephyrColors.neutral700 : ZephyrColors.neutral200,
          width: 1,
        ),
      ),
      textStyle: textTheme.bodySmall?.copyWith(
        color: isDark ? ZephyrColors.neutral400 : ZephyrColors.neutral600,
      ),
      alignment: Alignment.center,
    );
  }

  /// 创建主题副本
  ZephyrFooterTheme copyWith({
    Color? backgroundColor,
    double? height,
    EdgeInsetsGeometry? padding,
    Border? border,
    TextStyle? textStyle,
    AlignmentGeometry? alignment,
  }) {
    return ZephyrFooterTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      height: height ?? this.height,
      padding: padding ?? this.padding,
      border: border ?? this.border,
      textStyle: textStyle ?? this.textStyle,
      alignment: alignment ?? this.alignment,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is ZephyrFooterTheme &&
        other.backgroundColor == backgroundColor &&
        other.height == height &&
        other.padding == padding &&
        other.border == border &&
        other.textStyle == textStyle &&
        other.alignment == alignment;
  }

  @override
  int get hashCode {
    return Object.hash(
      backgroundColor,
      height,
      padding,
      border,
      textStyle,
      alignment,
    );
  }
}
