/// chromaUI 虚拟列表组件
///
/// 提供高性能的虚拟滚动列表，支持大量数据渲染。
library virtual_list;

import 'dart:ui' as ui;
import 'package:flutter/material.dart';

/// 虚拟列表项构建器
typedef chromaVirtualListItemBuilder = Widget Function(
  BuildContext context,
  int index,
);

/// 虚拟列表项高度计算器
typedef chromaVirtualListItemHeight = double Function(int index);

/// chromaUI 虚拟列表组件
///
/// 提供高性能的虚拟滚动列表，支持大量数据渲染。
///
/// 示例用法:
/// ```dart
/// chromaVirtualList(
///   itemCount: 10000,
///   itemBuilder: (context, index) {
///     return ListTile(
///       title: Text('Item $index'),
///     );
///   },
///   itemHeight: 56.0,
/// )
/// ```
class chromaVirtualList extends StatefulWidget {
  /// 创建虚拟列表
  const chromaVirtualList({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.itemHeight,
    this.itemHeightBuilder,
    this.padding,
    this.controller,
    this.physics,
    this.cacheExtent,
    this.theme,
    this.shrinkWrap = false,
    this.reverse = false,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
  });

  /// 列表项数量
  final int itemCount;

  /// 列表项构建器
  final chromaVirtualListItemBuilder itemBuilder;

  /// 固定列表项高度
  final double? itemHeight;

  /// 动态列表项高度计算器
  final chromaVirtualListItemHeight? itemHeightBuilder;

  /// 内边距
  final EdgeInsets? padding;

  /// 滚动控制器
  final ScrollController? controller;

  /// 滚动物理特性
  final ScrollPhysics? physics;

  /// 是否收缩包装
  final bool shrinkWrap;

  /// 是否反向滚动
  final bool reverse;

  /// 缓存范围
  final double? cacheExtent;

  /// 是否自动保持活跃状态
  final bool addAutomaticKeepAlives;

  /// 是否添加重绘边界
  final bool addRepaintBoundaries;

  /// 是否添加语义索引
  final bool addSemanticIndexes;

  /// 主题
  final chromaVirtualListTheme? theme;

  @override
  State<chromaVirtualList> createState() => _chromaVirtualListState();
}

class _chromaVirtualListState extends State<chromaVirtualList> {
  late ScrollController _controller;
  late List<double> _itemOffsets;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ScrollController();
    _calculateLayout();
  }

  @override
  void didUpdateWidget(chromaVirtualList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.itemCount != oldWidget.itemCount ||
        widget.itemHeight != oldWidget.itemHeight ||
        widget.itemHeightBuilder != oldWidget.itemHeightBuilder) {
      _calculateLayout();
    }
  }

  void _calculateLayout() {
    _itemOffsets = [];
    var offset = 0.0;

    for (var i = 0; i < widget.itemCount; i++) {
      _itemOffsets.add(offset);
      offset += widget.itemHeightBuilder?.call(i) ?? widget.itemHeight ?? 56.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? chromaVirtualListTheme.of(context);

    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: CustomScrollView(
        controller: _controller,
        physics: widget.physics,
        shrinkWrap: widget.shrinkWrap,
        reverse: widget.reverse,
        cacheExtent: widget.cacheExtent,
        slivers: [
          SliverPadding(
            padding: widget.padding ?? theme.padding,
            sliver: SliverFixedExtentList(
              itemExtent: widget.itemHeight ?? 56.0,
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index < widget.itemCount) {
                    return widget.itemBuilder(context, index);
                  }
                  return null;
                },
                childCount: widget.itemCount,
                addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
                addRepaintBoundaries: widget.addRepaintBoundaries,
                addSemanticIndexes: widget.addSemanticIndexes,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    // 可以在这里处理滚动事件
    return false;
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}

/// 虚拟列表主题
class chromaVirtualListTheme extends ThemeExtension<chromaVirtualListTheme> {
  const chromaVirtualListTheme({
    this.padding = const EdgeInsets.all(8.0),
    this.backgroundColor,
    this.separatorColor,
    this.separatorHeight = 1.0,
    this.cacheExtent = 250.0,
  });

  final EdgeInsets padding;
  final Color? backgroundColor;
  final Color? separatorColor;
  final double separatorHeight;
  final double cacheExtent;

  @override
  chromaVirtualListTheme copyWith({
    EdgeInsets? padding,
    Color? backgroundColor,
    Color? separatorColor,
    double? separatorHeight,
    double? cacheExtent,
  }) {
    return chromaVirtualListTheme(
      padding: padding ?? this.padding,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      separatorColor: separatorColor ?? this.separatorColor,
      separatorHeight: separatorHeight ?? this.separatorHeight,
      cacheExtent: cacheExtent ?? this.cacheExtent,
    );
  }

  @override
  chromaVirtualListTheme lerp(ThemeExtension<chromaVirtualListTheme>? other, double t) {
    if (other is! chromaVirtualListTheme) {
      return this;
    }

    return chromaVirtualListTheme(
      padding: EdgeInsets.lerp(padding, other.padding, t) ?? EdgeInsets.zero,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      separatorColor: Color.lerp(separatorColor, other.separatorColor, t),
      separatorHeight: ui.lerpDouble(separatorHeight, other.separatorHeight, t)!,
      cacheExtent: ui.lerpDouble(cacheExtent, other.cacheExtent, t)!,
    );
  }

  static chromaVirtualListTheme of(BuildContext context) {
    final theme = Theme.of(context);
    return theme.extension<chromaVirtualListTheme>() ?? _fallbackTheme(context);
  }

  static chromaVirtualListTheme _fallbackTheme(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return chromaVirtualListTheme(
      backgroundColor: colorScheme.surface,
      separatorColor: colorScheme.outline.withValues(alpha: 0.2),
    );
  }
}

/// 带分隔符的虚拟列表
class chromaVirtualSeparatedList extends chromaVirtualList {
  const chromaVirtualSeparatedList({
    super.key,
    required super.itemCount,
    required super.itemBuilder,
    super.itemHeight,
    super.itemHeightBuilder,
    super.padding,
    super.controller,
    super.physics,
    super.cacheExtent,
    super.theme,
    this.separatorBuilder,
    super.shrinkWrap = false,
    super.reverse = false,
    super.addAutomaticKeepAlives = true,
    super.addRepaintBoundaries = true,
    super.addSemanticIndexes = true,
  });

  /// 分隔符构建器
  final WidgetBuilder? separatorBuilder;

  @override
  State<chromaVirtualList> createState() => _chromaVirtualSeparatedListState();
}

class _chromaVirtualSeparatedListState extends State<chromaVirtualSeparatedList> {
  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? chromaVirtualListTheme.of(context);

    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: CustomScrollView(
        controller: widget.controller,
        physics: widget.physics,
        shrinkWrap: widget.shrinkWrap,
        reverse: widget.reverse,
        cacheExtent: widget.cacheExtent,
        slivers: [
          SliverPadding(
            padding: widget.padding ?? theme.padding,
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final itemIndex = index ~/ 2;

                  if (index.isEven) {
                    // 列表项
                    if (itemIndex < widget.itemCount) {
                      return widget.itemBuilder(context, itemIndex);
                    }
                    return null;
                  } else {
                    // 分隔符
                    if (widget.separatorBuilder != null) {
                      return widget.separatorBuilder!(context);
                    }
                    return Container(
                      height: theme.separatorHeight,
                      color: theme.separatorColor,
                    );
                  }
                },
                childCount: widget.itemCount * 2 - 1,
                addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
                addRepaintBoundaries: widget.addRepaintBoundaries,
                addSemanticIndexes: widget.addSemanticIndexes,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    return false;
  }
}
