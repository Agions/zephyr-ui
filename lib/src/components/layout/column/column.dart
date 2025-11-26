/// ZephyrUI 列组件
///
/// 布局专用的列组件，提供增强的布局功能。
library column;

import 'package:flutter/material.dart';

/// ZephyrUI 列组件
///
/// 布局专用的列组件，提供增强的布局功能。
///
/// 示例用法:
/// ```dart
/// ZephyrColumn(
///   children: [
///     Text('上方'),
///     Text('下方'),
///   ],
/// )
/// ```
class ZephyrColumn extends StatelessWidget {
  /// 创建列组件
  const ZephyrColumn({
    required this.children,
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.spacing = 0,
    this.padding,
    this.margin,
    this.gutter,
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

  /// 主题
  final ZephyrColumnTheme? theme;

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = theme ?? ZephyrColumnTheme.of(context);
    final effectiveSpacing = spacing > 0 ? spacing : effectiveTheme.spacing;
    // final effectiveGutter = gutter ?? effectiveTheme.gutter; // 暂时未使用

    var spacedChildren = <Widget>[];

    for (var i = 0; i < children.length; i++) {
      // 添加间距
      if (i > 0 && effectiveSpacing > 0) {
        spacedChildren.add(SizedBox(height: effectiveSpacing));
      }
      spacedChildren.add(children[i]);
    }

    Widget column = Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: spacedChildren,
    );

    // 应用内边距
    if (padding != null) {
      column = Padding(
        padding: padding!,
        child: column,
      );
    }

    // 应用外边距
    if (margin != null) {
      column = Container(
        margin: margin,
        child: column,
      );
    }

    return column;
  }
}

/// ZephyrUI 列主题
class ZephyrColumnTheme {
  /// 创建列主题
  const ZephyrColumnTheme({
    this.spacing = 0,
    this.gutter = 0,
  });

  /// 默认间距
  final double spacing;

  /// 网格间距
  final double gutter;

  /// 从上下文获取主题
  static ZephyrColumnTheme of(BuildContext context) {
    return const ZephyrColumnTheme();
  }

  /// 创建主题副本
  ZephyrColumnTheme copyWith({
    double? spacing,
    double? gutter,
  }) {
    return ZephyrColumnTheme(
      spacing: spacing ?? this.spacing,
      gutter: gutter ?? this.gutter,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is ZephyrColumnTheme &&
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
