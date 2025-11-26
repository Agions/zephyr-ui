/// ZephyrUI 布局间距组件
///
/// 布局专用的间距组件，提供更灵活的间距控制。
library space;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// 间距方向枚举 - 提供更语义化的方向定义
enum ZephyrSpaceDirection {
  horizontal,
  vertical,
}

/// 间距大小枚举 - 提供语义化的尺寸定义
enum ZephyrSpaceSize {
  xs(ZephyrSpacing.xs),
  sm(ZephyrSpacing.sm),
  md(ZephyrSpacing.md),
  lg(ZephyrSpacing.lg),
  large(ZephyrSpacing.lg),
  xl(ZephyrSpacing.xl),
  xxl(ZephyrSpacing.xxl);

  const ZephyrSpaceSize(this.value);

  final double value;
}

/// ZephyrUI 布局间距
///
/// 布局专用的间距组件，提供更灵活的间距控制。
///
/// 示例用法:
/// ```dart
/// ZephyrSpace(
///   direction: Axis.vertical,
///   size: ZephyrSpacing.lg,
///   children: [
///     Text('上方'),
///     Text('下方'),
///   ],
/// )
/// ```
class ZephyrSpace extends StatelessWidget {
  /// 创建间距组件
  const ZephyrSpace({
    required this.children,
    super.key,
    this.direction = Axis.horizontal,
    this.size = ZephyrSpacing.md,
    this.wrap = false,
    this.alignment,
    this.split,
    this.theme,
  });

  
  /// 子组件列表
  final List<Widget> children;

  /// 间距方向
  final Axis direction;

  /// 间距大小
  final double size;

  /// 是否换行
  final bool wrap;

  /// 对齐方式
  final AlignmentGeometry? alignment;

  /// 分隔线组件
  final Widget? split;

  /// 主题
  final ZephyrSpaceTheme? theme;

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = theme ?? ZephyrSpaceTheme.of(context);
    final effectiveSize = size > 0 ? size : effectiveTheme.size;
    // final effectiveAlignment = alignment ?? effectiveTheme.alignment; // 暂时未使用

    if (children.isEmpty) {
      return const SizedBox.shrink();
    }

    var spacedChildren = <Widget>[];

    for (var i = 0; i < children.length; i++) {
      // 添加子组件
      spacedChildren.add(children[i]);

      // 添加间距或分隔线
      if (i < children.length - 1) {
        if (split != null) {
          // 添加分隔线
          spacedChildren.add(_buildSplitter(effectiveSize));
        } else {
          // 添加间距
          spacedChildren.add(_buildSpacer(effectiveSize));
        }
      }
    }

    Widget container;

    if (wrap) {
      // 换行布局
      container = Wrap(
        spacing: direction == Axis.horizontal ? effectiveSize : 0,
        runSpacing: direction == Axis.vertical ? effectiveSize : 0,
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: spacedChildren,
      );
    } else {
      // 线性布局
      container = direction == Axis.horizontal
          ? Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: spacedChildren,
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: spacedChildren,
            );
    }

    return container;
  }

  /// 构建间距器
  Widget _buildSpacer(double size) {
    return direction == Axis.horizontal
        ? SizedBox(width: size)
        : SizedBox(height: size);
  }

  /// 构建带分隔线的间距器
  Widget _buildSpacerWithSplit(double size) {
    return direction == Axis.horizontal
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: size / 2),
              split!,
              SizedBox(width: size / 2),
            ],
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: size / 2),
              split!,
              SizedBox(height: size / 2),
            ],
          );
  }

  /// 构建分隔器
  Widget _buildSplitter(double size) {
    if (split == null) {
      return _buildSpacer(size);
    }

    return _buildSpacerWithSplit(size);
  }
}

/// ZephyrUI 间距分隔线
class ZephyrSpaceDivider extends StatelessWidget {
  /// 创建分隔线
  const ZephyrSpaceDivider({
    super.key,
    this.direction = Axis.horizontal,
    this.color,
    this.thickness = 1.0,
    this.spacing = ZephyrSpacing.md,
    this.text,
    this.size,
  });

  /// 分隔线方向
  final Axis direction;

  /// 分隔线颜色
  final Color? color;

  /// 分隔线厚度
  final double thickness;

  /// 间距大小
  final double spacing;

  /// 分隔线文本
  final String? text;

  /// 尺寸枚举
  final ZephyrSpaceSize? size;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? Theme.of(context).dividerColor;
    final sizeValue = spacing; // Use spacing directly since we removed the complex initialization
    
    // If size parameter was provided, use its value
    final effectiveSpacing = size != null ? size!.value : sizeValue;

    if (text != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (direction == Axis.horizontal)
            Expanded(
              child: Container(
                height: thickness,
                color: effectiveColor,
                margin: EdgeInsets.only(right: effectiveSpacing / 2),
              ),
            )
          else
            Container(
              width: thickness,
              color: effectiveColor,
              margin: EdgeInsets.only(bottom: effectiveSpacing / 2),
            ),
          Text(
            text!,
            style: TextStyle(
              color: effectiveColor,
              fontSize: 12,
            ),
          ),
          if (direction == Axis.horizontal)
            Expanded(
              child: Container(
                height: thickness,
                color: effectiveColor,
                margin: EdgeInsets.only(left: effectiveSpacing / 2),
              ),
            )
          else
            Container(
              width: thickness,
              color: effectiveColor,
              margin: EdgeInsets.only(top: effectiveSpacing / 2),
            ),
        ],
      );
    }

    return direction == Axis.horizontal
        ? Container(
            height: thickness,
            color: effectiveColor,
            margin: EdgeInsets.symmetric(horizontal: effectiveSpacing / 2),
          )
        : Container(
            width: thickness,
            color: effectiveColor,
            margin: EdgeInsets.symmetric(vertical: effectiveSpacing / 2),
          );
  }
}

/// ZephyrUI 间距主题
class ZephyrSpaceTheme {
  /// 创建间距主题
  const ZephyrSpaceTheme({
    this.size = ZephyrSpacing.md,
    this.alignment = Alignment.center,
  });

  /// 默认间距大小
  final double size;

  /// 默认对齐方式
  final AlignmentGeometry alignment;

  /// 从上下文获取主题
  static ZephyrSpaceTheme of(BuildContext context) {
    return const ZephyrSpaceTheme();
  }

  /// 创建主题副本
  ZephyrSpaceTheme copyWith({
    double? size,
    AlignmentGeometry? alignment,
  }) {
    return ZephyrSpaceTheme(
      size: size ?? this.size,
      alignment: alignment ?? this.alignment,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is ZephyrSpaceTheme &&
        other.size == size &&
        other.alignment == alignment;
  }

  @override
  int get hashCode {
    return Object.hash(
      size,
      alignment,
    );
  }
}
