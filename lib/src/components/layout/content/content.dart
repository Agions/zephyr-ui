/// ZephyrUI 内容区域组件
///
/// 提供页面主要内容区域，支持滚动、内边距等功能。
library content;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI 内容区域
///
/// 页面主要内容区域组件，支持滚动、内边距等功能。
///
/// 示例用法:
/// ```dart
/// ZephyrContent(
///   child: Text('主要内容'),
/// )
/// ```
class ZephyrContent extends StatelessWidget {
  /// 创建内容区域
  const ZephyrContent({
    required this.child,
    super.key,
    this.padding,
    this.scrollable = true,
    this.backgroundColor,
    this.border,
    this.theme,
    this.alignment,
    this.constraints,
  });

  /// 子组件
  final Widget child;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 是否可滚动
  final bool scrollable;

  /// 背景色
  final Color? backgroundColor;

  /// 边框
  final Border? border;

  /// 主题
  final ZephyrContentTheme? theme;

  /// 对齐方式
  final AlignmentGeometry? alignment;

  /// 约束
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = theme ?? ZephyrContentTheme.of(context);
    final effectivePadding = padding ?? effectiveTheme.padding;
    final effectiveAlignment = alignment ?? effectiveTheme.alignment;
    final effectiveBorder = border ?? effectiveTheme.border;

    Widget content = Container(
      padding: effectivePadding,
      decoration: BoxDecoration(
        color: backgroundColor ?? effectiveTheme.backgroundColor,
        border: effectiveBorder,
      ),
      alignment: effectiveAlignment,
      constraints: constraints,
      child: child,
    );

    // 如果可滚动且没有约束，包装在 SingleChildScrollView 中
    if (scrollable && constraints == null) {
      content = SingleChildScrollView(
        child: content,
      );
    }

    return content;
  }
}

/// ZephyrUI 内容区域主题
class ZephyrContentTheme {
  /// 创建内容区域主题
  const ZephyrContentTheme({
    this.backgroundColor,
    this.padding,
    this.border,
    this.alignment,
  });

  /// 背景色
  final Color? backgroundColor;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 边框
  final Border? border;

  /// 对齐方式
  final AlignmentGeometry? alignment;

  /// 从上下文获取主题
  static ZephyrContentTheme of(BuildContext context) {
    final zephyrTheme = ZephyrTheme.of(context);
    return _defaultTheme(zephyrTheme);
  }

  /// 默认主题
  static ZephyrContentTheme _defaultTheme(ZephyrThemeData zephyrTheme) {
    final isDark = zephyrTheme.brightness == Brightness.dark;

    return ZephyrContentTheme(
      backgroundColor:
          isDark ? ZephyrColors.neutral900 : ZephyrColors.neutral50,
      padding: const EdgeInsets.all(ZephyrSpacing.lg),
      border: null,
      alignment: Alignment.topLeft,
    );
  }

  /// 创建主题副本
  ZephyrContentTheme copyWith({
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
    Border? border,
    AlignmentGeometry? alignment,
  }) {
    return ZephyrContentTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      padding: padding ?? this.padding,
      border: border ?? this.border,
      alignment: alignment ?? this.alignment,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is ZephyrContentTheme &&
        other.backgroundColor == backgroundColor &&
        other.padding == padding &&
        other.border == border &&
        other.alignment == alignment;
  }

  @override
  int get hashCode {
    return Object.hash(
      backgroundColor,
      padding,
      border,
      alignment,
    );
  }
}
