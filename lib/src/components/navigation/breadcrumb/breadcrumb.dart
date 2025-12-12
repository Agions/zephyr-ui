/// VelocityUI 面包屑导航组件
library velocity_breadcrumb;

import 'package:flutter/material.dart';
import 'breadcrumb_style.dart';

export 'breadcrumb_style.dart';

/// VelocityUI 面包屑导航组件
class VelocityBreadcrumb extends StatelessWidget {
  /// 创建面包屑导航组件
  const VelocityBreadcrumb({
    required this.items,
    super.key,
    this.style,
    this.onItemTap,
    this.separator,
    this.wrap = false,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  /// 面包屑项列表
  final List<VelocityBreadcrumbItem> items;

  /// 样式
  final VelocityBreadcrumbStyle? style;

  /// 项点击事件
  final ValueChanged<int>? onItemTap;

  /// 分隔符
  final String? separator;

  /// 是否自动换行
  final bool? wrap;

  /// 主轴对齐方式
  final MainAxisAlignment mainAxisAlignment;

  /// 交叉轴对齐方式
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? VelocityBreadcrumbStyle.defaults();
    final actualWrap = wrap ?? effectiveStyle.wrap;
    final actualSeparator = separator ?? effectiveStyle.separator;

    return Container(
      child: actualWrap
          ? Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: effectiveStyle.spacing,
              children: _buildItems(effectiveStyle, actualSeparator),
            )
          : Row(
              mainAxisAlignment: mainAxisAlignment,
              crossAxisAlignment: crossAxisAlignment,
              children: _buildItems(effectiveStyle, actualSeparator),
            ),
    );
  }

  List<Widget> _buildItems(
      VelocityBreadcrumbStyle effectiveStyle, String actualSeparator) {
    final children = <Widget>[];

    for (var i = 0; i < items.length; i++) {
      final item = items[i];
      final isActive = i == items.length - 1;

      children.add(GestureDetector(
        onTap: () => onItemTap?.call(i),
        child: Padding(
          padding: effectiveStyle.itemPadding,
          child: Text(
            item.label,
            style: isActive
                ? effectiveStyle.activeTextStyle
                : effectiveStyle.textStyle,
          ),
        ),
      ));

      if (i < items.length - 1) {
        children.add(Padding(
          padding: effectiveStyle.itemPadding,
          child: Text(
            actualSeparator,
            style: effectiveStyle.separatorStyle,
          ),
        ));
      }
    }

    return children;
  }
}

/// VelocityUI 面包屑项组件
class VelocityBreadcrumbItem {
  /// 创建面包屑项
  const VelocityBreadcrumbItem({
    required this.label,
    this.icon,
    this.route,
  });

  /// 标签文本
  final String label;

  /// 图标
  final IconData? icon;

  /// 路由路径
  final String? route;
}
