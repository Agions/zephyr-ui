/// VelocityUI 描述列表组件
library velocity_descriptions;

import 'package:flutter/material.dart';
import 'descriptions_style.dart';

/// 描述列表项
class VelocityDescriptionsItem {
  /// 创建描述列表项
  const VelocityDescriptionsItem({
    required this.title,
    required this.content,
    this.span = 1,
  });

  /// 标题
  final String title;

  /// 内容
  final String content;

  /// 占据的列数
  final int span;
}

/// VelocityUI 描述列表组件
class VelocityDescriptions extends StatelessWidget {
  /// 创建描述列表组件
  const VelocityDescriptions({
    required this.items,
    super.key,
    this.column = 3,
    this.title,
    this.style,
    this.layout = VelocityDescriptionsLayout.horizontal,
  });

  /// 描述列表项
  final List<VelocityDescriptionsItem> items;

  /// 每行显示的列数
  final int column;

  /// 描述列表标题
  final String? title;

  /// 描述列表样式
  final VelocityDescriptionsStyle? style;

  /// 布局方式
  final VelocityDescriptionsLayout layout;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? const VelocityDescriptionsStyle();
    return Container(
      margin: effectiveStyle.margin,
      decoration: BoxDecoration(
        color: effectiveStyle.backgroundColor,
        border: effectiveStyle.showBorder
            ? Border.all(
                color: effectiveStyle.borderColor,
                width: effectiveStyle.borderWidth,
              )
            : null,
        borderRadius: effectiveStyle.borderRadius,
      ),
      child: Padding(
        padding: effectiveStyle.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  title!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            _buildContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (layout == VelocityDescriptionsLayout.horizontal) {
      return _buildHorizontalLayout();
    } else {
      return _buildVerticalLayout();
    }
  }

  Widget _buildHorizontalLayout() {
    final rows = <Widget>[];
    final currentRow = <Widget>[];
    var currentColumnSpan = 0;

    for (var i = 0; i < items.length; i++) {
      final item = items[i];
      final remainingSpan = column - currentColumnSpan;

      if (item.span > remainingSpan) {
        // 填满当前行剩余空间
        if (remainingSpan > 0) {
          currentRow.add(
            Expanded(
              flex: remainingSpan,
              child: const SizedBox.shrink(),
            ),
          );
        }
        // 添加当前行
        rows.add(_buildRow(currentRow));
        // 清空当前行，开始新行
        currentRow.clear();
        currentColumnSpan = 0;
      }

      // 添加当前项
      currentRow.add(
        Expanded(
          flex: item.span,
          child: _buildDescriptionsItem(item),
        ),
      );
      currentColumnSpan += item.span;

      // 检查是否需要换行
      if (currentColumnSpan >= column || i == items.length - 1) {
        rows.add(_buildRow(currentRow));
        currentRow.clear();
        currentColumnSpan = 0;
      }
    }

    return Column(children: rows);
  }

  Widget _buildVerticalLayout() {
    return Column(
      children: items.map((item) => _buildDescriptionsItem(item)).toList(),
    );
  }

  Widget _buildRow(List<Widget> children) {
    final effectiveStyle = style ?? const VelocityDescriptionsStyle();
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
        if (effectiveStyle.showDivider)
          Container(
            height: 1,
            color: effectiveStyle.dividerColor,
            margin: EdgeInsets.only(top: effectiveStyle.rowGap),
          ),
      ],
    );
  }

  Widget _buildDescriptionsItem(VelocityDescriptionsItem item) {
    final effectiveStyle = style ?? const VelocityDescriptionsStyle();
    final itemWidget = Container(
      padding: EdgeInsets.only(
        right: effectiveStyle.columnGap,
        bottom: effectiveStyle.rowGap,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: effectiveStyle.titleWidth,
            child: Text(
              item.title,
              style: effectiveStyle.titleStyle,
              textAlign: effectiveStyle.titleTextAlign,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Text(
              item.content,
              style: effectiveStyle.contentStyle,
              textAlign: effectiveStyle.textAlign,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );

    return itemWidget;
  }
}

/// 描述列表布局方式
enum VelocityDescriptionsLayout {
  /// 水平布局
  horizontal,

  /// 垂直布局
  vertical,
}
