/// ZephyrUI 行组件
///
/// 布局专用的行组件，提供增强的布局功能。
library row;

import 'package:flutter/material.dart';

/// ZephyrUI 行组件
///
/// 布局专用的行组件，提供增强的布局功能。
///
/// 示例用法:
/// ```dart
/// ZephyrRow(
///   children: [
///     Text('左侧'),
///     Text('右侧'),
///   ],
/// )
/// ```
class ZephyrLayoutRow extends StatelessWidget {
  /// 创建行组件
  const ZephyrLayoutRow({
    required this.children,
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.spacing = 0,
    this.padding,
    this.margin,
    this.gutter,
    this.wrap = false,
    this.theme,
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

  /// 网格间距（用于响应式布局）
  final double? gutter;

  /// 是否换行
  final bool wrap;

  /// 主题
  final ZephyrLayoutRowTheme? theme;

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = theme ?? ZephyrLayoutRowTheme.of(context);
    final effectiveSpacing = spacing > 0 ? spacing : effectiveTheme.spacing;
    final effectiveGutter = gutter ?? effectiveTheme.gutter;

    var spacedChildren = <Widget>[];

    for (var i = 0; i < children.length; i++) {
      // 添加间距
      if (i > 0 && effectiveSpacing > 0) {
        spacedChildren.add(SizedBox(width: effectiveSpacing));
      }
      spacedChildren.add(children[i]);
    }

    Widget row;

    if (wrap) {
      // 换行布局
      row = Wrap(
        spacing: effectiveGutter,
        runSpacing: effectiveGutter,
        alignment: _wrapAlignmentFromMainAxisAlignment(mainAxisAlignment),
        crossAxisAlignment:
            _wrapCrossAxisAlignmentFromCrossAxisAlignment(crossAxisAlignment),
        children: spacedChildren,
      );
    } else {
      // 普通行布局
      row = Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        children: spacedChildren,
      );
    }

    // 应用内边距
    if (padding != null) {
      row = Padding(
        padding: padding!,
        child: row,
      );
    }

    // 应用外边距
    if (margin != null) {
      row = Container(
        margin: margin,
        child: row,
      );
    }

    return row;
  }

  /// 将 MainAxisAlignment 转换为 WrapAlignment
  WrapAlignment _wrapAlignmentFromMainAxisAlignment(
      MainAxisAlignment alignment) {
    switch (alignment) {
      case MainAxisAlignment.start:
        return WrapAlignment.start;
      case MainAxisAlignment.end:
        return WrapAlignment.end;
      case MainAxisAlignment.center:
        return WrapAlignment.center;
      case MainAxisAlignment.spaceBetween:
        return WrapAlignment.spaceBetween;
      case MainAxisAlignment.spaceAround:
        return WrapAlignment.spaceAround;
      case MainAxisAlignment.spaceEvenly:
        return WrapAlignment.spaceEvenly;
    }
  }

  /// 将 CrossAxisAlignment 转换为 WrapCrossAlignment
  WrapCrossAlignment _wrapCrossAxisAlignmentFromCrossAxisAlignment(
      CrossAxisAlignment alignment) {
    switch (alignment) {
      case CrossAxisAlignment.start:
        return WrapCrossAlignment.start;
      case CrossAxisAlignment.end:
        return WrapCrossAlignment.end;
      case CrossAxisAlignment.center:
        return WrapCrossAlignment.center;
      case CrossAxisAlignment.stretch:
        return WrapCrossAlignment
            .start; // WrapCrossAlignment 没有 stretch，使用 start 替代
      case CrossAxisAlignment.baseline:
        return WrapCrossAlignment.center;
    }
  }
}

/// ZephyrUI 布局行主题
class ZephyrLayoutRowTheme {
  /// 创建行主题
  const ZephyrLayoutRowTheme({
    this.spacing = 0,
    this.gutter = 0,
  });

  /// 默认间距
  final double spacing;

  /// 网格间距
  final double gutter;

  /// 从上下文获取主题
  static ZephyrLayoutRowTheme of(BuildContext context) {
    return const ZephyrLayoutRowTheme();
  }

  /// 创建主题副本
  ZephyrLayoutRowTheme copyWith({
    double? spacing,
    double? gutter,
  }) {
    return ZephyrLayoutRowTheme(
      spacing: spacing ?? this.spacing,
      gutter: gutter ?? this.gutter,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is ZephyrLayoutRowTheme &&
        other.spacing == spacing &&
        other.gutter == gutter;
  }

  @override
  int get hashCode {
    return Object.hash(
      spacing,
      gutter,
    );
  }
}
