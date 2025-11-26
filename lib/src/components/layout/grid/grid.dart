/// ZephyrUI 网格布局组件
///
/// 提供响应式网格布局系统，类似于 Bootstrap 的网格系统。
library grid;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/src/core/extensions/context_extensions.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI 网格容器
///
/// 提供响应式网格布局的容器组件。
///
/// 示例用法:
/// ```dart
/// ZephyrGrid(
///   children: [
///     ZephyrGridItem(
///       xs: 12,
///       md: 6,
///       lg: 4,
///       child: Text('内容'),
///     ),
///   ],
/// )
/// ```
class ZephyrGrid extends StatelessWidget {
  /// 创建网格容器
  const ZephyrGrid({
    required this.children,
    super.key,
    this.spacing = ZephyrSpacing.md,
    this.runSpacing,
    this.padding,
    this.maxWidth,
    this.alignment = WrapAlignment.start,
    this.runAlignment = WrapAlignment.start,
    this.crossAxisAlignment = WrapCrossAlignment.start,
  });

  /// 子组件列表
  final List<Widget> children;

  /// 水平间距
  final double spacing;

  /// 垂直间距
  final double? runSpacing;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 最大宽度
  final double? maxWidth;

  /// 主轴对齐方式
  final WrapAlignment alignment;

  /// 交叉轴对齐方式
  final WrapAlignment runAlignment;

  /// 子组件交叉轴对齐方式
  final WrapCrossAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final effectiveRunSpacing = runSpacing ?? spacing;

    Widget grid = Wrap(
      spacing: spacing,
      runSpacing: effectiveRunSpacing,
      alignment: alignment,
      runAlignment: runAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: children,
    );

    if (padding != null) {
      grid = Padding(
        padding: padding!,
        child: grid,
      );
    }

    if (maxWidth != null) {
      grid = ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth!),
        child: grid,
      );
    }

    return grid;
  }
}

/// ZephyrUI 网格项目
///
/// 网格布局中的单个项目，支持响应式列宽。
class ZephyrGridItem extends StatelessWidget {
  /// 创建网格项目
  const ZephyrGridItem({
    required this.child,
    super.key,
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
    this.xxl,
    this.flex,
    this.padding,
    this.margin,
  });

  /// 子组件
  final Widget child;

  /// 超小屏幕列数 (0-12)
  final int? xs;

  /// 小屏幕列数 (0-12)
  final int? sm;

  /// 中等屏幕列数 (0-12)
  final int? md;

  /// 大屏幕列数 (0-12)
  final int? lg;

  /// 超大屏幕列数 (0-12)
  final int? xl;

  /// 超超大屏幕列数 (0-12)
  final int? xxl;

  /// 弹性系数
  final int? flex;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 外边距
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final breakpoint = context.breakpoint;
    final columns = _getColumnsForBreakpoint(breakpoint);

    // 如果没有指定列数，使用全宽
    if (columns == null) {
      return _buildChild(context, null);
    }

    // 计算宽度百分比
    final widthPercent = columns / 12.0;
    final availableWidth = context.screenWidth;
    final itemWidth = availableWidth * widthPercent;

    return _buildChild(context, itemWidth);
  }

  /// 构建子组件
  Widget _buildChild(BuildContext context, double? width) {
    var result = child;

    if (padding != null) {
      result = Padding(
        padding: padding!,
        child: result,
      );
    }

    if (margin != null) {
      result = Padding(
        padding: margin!,
        child: result,
      );
    }

    if (width != null) {
      result = SizedBox(
        width: width,
        child: result,
      );
    } else if (flex != null) {
      result = Expanded(
        flex: flex!,
        child: result,
      );
    }

    return result;
  }

  /// 获取当前断点对应的列数
  int? _getColumnsForBreakpoint(ZephyrBreakpoint breakpoint) {
    switch (breakpoint) {
      case ZephyrBreakpoint.xs:
        return xs ?? 12;
      case ZephyrBreakpoint.sm:
        return sm ?? xs ?? 12;
      case ZephyrBreakpoint.md:
        return md ?? sm ?? xs ?? 12;
      case ZephyrBreakpoint.lg:
        return lg ?? md ?? sm ?? xs ?? 12;
      case ZephyrBreakpoint.xl:
        return xl ?? lg ?? md ?? sm ?? xs ?? 12;
      case ZephyrBreakpoint.xxl:
        return xxl ?? xl ?? lg ?? md ?? sm ?? xs ?? 12;
    }
  }
}

/// ZephyrUI 行布局
///
/// 水平排列的行布局组件。
class ZephyrRow extends StatelessWidget {
  /// 创建行布局
  const ZephyrRow({
    required this.children,
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.spacing = 0,
    this.padding,
    this.margin,
  });

  /// 子组件列表
  final List<Widget> children;

  /// 主轴对齐方式
  final MainAxisAlignment mainAxisAlignment;

  /// 交叉轴对齐方式
  final CrossAxisAlignment crossAxisAlignment;

  /// 主轴尺寸
  final MainAxisSize mainAxisSize;

  /// 子组件间距
  final double spacing;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 外边距
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    var spacedChildren = <Widget>[];

    for (var i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);
      if (i < children.length - 1 && spacing > 0) {
        spacedChildren.add(SizedBox(width: spacing));
      }
    }

    Widget row = Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: spacedChildren,
    );

    if (padding != null) {
      row = Padding(
        padding: padding!,
        child: row,
      );
    }

    if (margin != null) {
      row = Container(
        margin: margin,
        child: row,
      );
    }

    return row;
  }
}

/// ZephyrUI 列布局
///
/// 垂直排列的列布局组件。
class ZephyrGridColumn extends StatelessWidget {
  /// 创建列布局
  const ZephyrGridColumn({
    required this.children,
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.spacing = 0,
    this.padding,
    this.margin,
  });

  /// 子组件列表
  final List<Widget> children;

  /// 主轴对齐方式
  final MainAxisAlignment mainAxisAlignment;

  /// 交叉轴对齐方式
  final CrossAxisAlignment crossAxisAlignment;

  /// 主轴尺寸
  final MainAxisSize mainAxisSize;

  /// 子组件间距
  final double spacing;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 外边距
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    var spacedChildren = <Widget>[];

    for (var i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);
      if (i < children.length - 1 && spacing > 0) {
        spacedChildren.add(SizedBox(height: spacing));
      }
    }

    Widget column = Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: spacedChildren,
    );

    if (padding != null) {
      column = Padding(
        padding: padding!,
        child: column,
      );
    }

    if (margin != null) {
      column = Container(
        margin: margin,
        child: column,
      );
    }

    return column;
  }
}
