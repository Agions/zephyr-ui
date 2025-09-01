/// ZephyrUI 容器组件
///
/// 提供一致的容器布局，支持响应式设计和主题定制。
library container;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/src/core/extensions/context_extensions.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI 容器组件
///
/// 一个增强的容器组件，提供响应式布局、主题支持和便捷的样式配置。
///
/// 示例用法:
/// ```dart
/// ZephyrContainer(
///   padding: ZephyrSpacing.md,
///   child: Text('内容'),
/// )
/// ```
class ZephyrContainer extends StatelessWidget {
  /// 创建一个 ZephyrUI 容器
  const ZephyrContainer({
    Key? key,
    this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.decoration,
    this.constraints,
    this.alignment,
    this.transform,
    this.transformAlignment,
    this.clipBehavior = Clip.none,
    this.responsive = false,
    this.maxWidth,
    this.theme,
  }) : super(key: key);

  /// 子组件
  final Widget? child;

  /// 宽度
  final double? width;

  /// 高度
  final double? height;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 外边距
  final EdgeInsetsGeometry? margin;

  /// 装饰
  final Decoration? decoration;

  /// 约束
  final BoxConstraints? constraints;

  /// 对齐方式
  final AlignmentGeometry? alignment;

  /// 变换
  final Matrix4? transform;

  /// 变换对齐方式
  final AlignmentGeometry? transformAlignment;

  /// 裁剪行为
  final Clip clipBehavior;

  /// 是否启用响应式
  final bool responsive;

  /// 最大宽度
  final double? maxWidth;

  /// 主题
  final ZephyrContainerTheme? theme;

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = theme ?? ZephyrContainerTheme.of(context);
    final effectiveMaxWidth = maxWidth ?? effectiveTheme.maxWidth;

    Widget container = Container(
      width: width,
      height: height,
      padding: padding ?? effectiveTheme.padding,
      margin: margin ?? effectiveTheme.margin,
      decoration: decoration ?? _buildDecoration(context, effectiveTheme),
      constraints: constraints ?? effectiveTheme.constraints,
      alignment: alignment ?? effectiveTheme.alignment,
      transform: transform,
      transformAlignment: transformAlignment,
      clipBehavior: clipBehavior,
      child: child,
    );

    // 如果启用响应式且设置了最大宽度，则添加约束
    if (responsive && effectiveMaxWidth != null) {
      container = ConstrainedBox(
        constraints: BoxConstraints(maxWidth: effectiveMaxWidth),
        child: container,
      );
    }

    return container;
  }

  /// 构建装饰
  Decoration? _buildDecoration(
    BuildContext context,
    ZephyrContainerTheme theme,
  ) {
    if (decoration != null) return decoration;

    return BoxDecoration(
      color: theme.backgroundColor,
      borderRadius: theme.borderRadius,
      border: theme.border,
      boxShadow: theme.boxShadow,
    );
  }
}

/// ZephyrUI 响应式容器
///
/// 自动适配不同屏幕尺寸的容器组件。
class ZephyrResponsiveContainer extends StatelessWidget {
  /// 创建一个响应式容器
  const ZephyrResponsiveContainer({
    Key? key,
    required this.child,
    this.padding,
    this.margin,
    this.decoration,
    this.alignment,
    this.maxWidth,
    this.breakpoints,
    this.theme,
  }) : super(key: key);

  /// 子组件
  final Widget child;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 外边距
  final EdgeInsetsGeometry? margin;

  /// 装饰
  final Decoration? decoration;

  /// 对齐方式
  final AlignmentGeometry? alignment;

  /// 最大宽度
  final double? maxWidth;

  /// 断点配置
  final Map<ZephyrBreakpoint, double>? breakpoints;

  /// 主题
  final ZephyrContainerTheme? theme;

  @override
  Widget build(BuildContext context) {
    final currentBreakpoint = context.breakpoint;
    final effectiveMaxWidth = _getMaxWidthForBreakpoint(currentBreakpoint);

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: effectiveMaxWidth ?? double.infinity,
        ),
        child: ZephyrContainer(
          padding: padding,
          margin: margin,
          decoration: decoration,
          alignment: alignment,
          theme: theme,
          child: child,
        ),
      ),
    );
  }

  /// 获取断点对应的最大宽度
  double? _getMaxWidthForBreakpoint(ZephyrBreakpoint breakpoint) {
    if (breakpoints != null) {
      return breakpoints![breakpoint];
    }

    if (maxWidth != null) {
      return maxWidth;
    }

    // 默认断点宽度
    switch (breakpoint) {
      case ZephyrBreakpoint.xs:
        return null; // 全宽
      case ZephyrBreakpoint.sm:
        return 540;
      case ZephyrBreakpoint.md:
        return 720;
      case ZephyrBreakpoint.lg:
        return 960;
      case ZephyrBreakpoint.xl:
        return 1140;
      case ZephyrBreakpoint.xxl:
        return 1320;
    }
  }
}

/// ZephyrUI 卡片容器
///
/// 带有卡片样式的容器组件。
class ZephyrCardContainer extends StatelessWidget {
  /// 创建一个卡片容器
  const ZephyrCardContainer({
    Key? key,
    required this.child,
    this.padding,
    this.margin,
    this.elevation = 2,
    this.borderRadius,
    this.backgroundColor,
    this.shadowColor,
    this.onTap,
    this.theme,
  }) : super(key: key);

  /// 子组件
  final Widget child;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 外边距
  final EdgeInsetsGeometry? margin;

  /// 阴影高度
  final double elevation;

  /// 圆角
  final BorderRadius? borderRadius;

  /// 背景色
  final Color? backgroundColor;

  /// 阴影颜色
  final Color? shadowColor;

  /// 点击回调
  final VoidCallback? onTap;

  /// 主题
  final ZephyrContainerTheme? theme;

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = theme ?? ZephyrContainerTheme.of(context);
    final effectiveBorderRadius =
        borderRadius ?? BorderRadius.circular(ZephyrRadius.md);

    Widget card = Container(
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? effectiveTheme.backgroundColor,
        borderRadius: effectiveBorderRadius,
        boxShadow: [
          BoxShadow(
            color: (shadowColor ?? Colors.black).withValues(alpha: 0.1),
            blurRadius: elevation * 2,
            offset: Offset(0, elevation),
          ),
        ],
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(ZephyrSpacing.lg),
        child: child,
      ),
    );

    if (onTap != null) {
      card = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: effectiveBorderRadius,
          child: card,
        ),
      );
    }

    return card;
  }
}
