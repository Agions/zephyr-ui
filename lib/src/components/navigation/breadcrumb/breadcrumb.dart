/// chromaUI 面包屑导航组件
///
/// 提供面包屑导航功能，支持自定义分隔符和点击事件。
library breadcrumb;

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:chroma_ui/chroma_ui.dart';

/// 面包屑项
class chromaBreadcrumbItem {
  /// 标题
  final String title;

  /// 点击回调
  final VoidCallback? onTap;

  /// 图标
  final IconData? icon;

  /// 是否禁用
  final bool disabled;

  /// 自定义数据
  final dynamic data;

  const chromaBreadcrumbItem({
    required this.title,
    this.onTap,
    this.icon,
    this.disabled = false,
    this.data,
  });
}

/// chromaUI 面包屑导航组件
///
/// 用于显示当前页面在层级结构中的位置，并提供快速导航功能。
///
/// 示例用法:
/// ```dart
/// chromaBreadcrumb(
///   items: [
///     chromaBreadcrumbItem(
///       title: '首页',
///       onTap: () => Navigator.pushNamed(context, '/home'),
///     ),
///     chromaBreadcrumbItem(
///       title: '产品',
///       onTap: () => Navigator.pushNamed(context, '/products'),
///     ),
///     chromaBreadcrumbItem(
///       title: '详情',
///       disabled: true,
///     ),
///   ],
/// )
/// ```
class chromaBreadcrumb extends StatelessWidget {
  /// 创建面包屑导航
  const chromaBreadcrumb({
    Key? key,
    required this.items,
    this.separator = '/',
    this.maxItems = 5,
    this.collapsedItemText = '...',
    this.size = chromaSize.md,
    this.variant = chromaVariant.outline,
    this.theme,
  }) : super(key: key);

  /// 面包屑项列表
  final List<chromaBreadcrumbItem> items;

  /// 分隔符
  final String separator;

  /// 最大显示项数
  final int maxItems;

  /// 折叠项文本
  final String collapsedItemText;

  /// 尺寸
  final chromaSize size;

  /// 变体
  final chromaVariant variant;

  /// 主题
  final chromaBreadcrumbTheme? theme;

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = theme ?? chromaBreadcrumbTheme.of(context);

    return Container(
      padding: effectiveTheme.padding,
      decoration: BoxDecoration(
        color: effectiveTheme.backgroundColor,
        borderRadius: effectiveTheme.borderRadius,
        border: Border.all(
          color: effectiveTheme.borderColor,
          width: effectiveTheme.borderWidth,
        ),
      ),
      child: _buildBreadcrumbContent(context, effectiveTheme),
    );
  }

  Widget _buildBreadcrumbContent(BuildContext context, chromaBreadcrumbTheme theme) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    final displayItems = _getDisplayItems();
    final textScaleFactor = _getTextScaleFactor();
    final iconSize = _getIconSize(theme);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: displayItems.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final isLast = index == displayItems.length - 1;

        return Row(
          children: [
            if (index > 0) _buildSeparator(theme),
            _buildBreadcrumbItem(
              context,
              item,
              isLast,
              theme,
              textScaleFactor,
              iconSize,
            ),
          ],
        );
      }).toList(),
    );
  }

  List<chromaBreadcrumbItem> _getDisplayItems() {
    if (items.length <= maxItems) {
      return items;
    }

    final result = <chromaBreadcrumbItem>[];

    // 始终显示第一项
    result.add(items.first);

    // 添加折叠项
    if (maxItems > 2) {
      result.add(chromaBreadcrumbItem(
        title: collapsedItemText,
        disabled: true,
      ));
    }

    // 显示最后几项
    final itemsToShow = maxItems - 2;
    result.addAll(items.skip(items.length - itemsToShow));

    return result;
  }

  Widget _buildSeparator(chromaBreadcrumbTheme theme) {
    return Padding(
      padding: theme.separatorPadding,
      child: Text(
        separator,
        style: theme.separatorStyle.copyWith(
          fontSize: theme.separatorStyle.fontSize! * _getTextScaleFactor(),
        ),
      ),
    );
  }

  Widget _buildBreadcrumbItem(
    BuildContext context,
    chromaBreadcrumbItem item,
    bool isLast,
    chromaBreadcrumbTheme theme,
    double textScaleFactor,
    double iconSize,
  ) {
    final style = isLast
        ? theme.activeItemStyle.copyWith(fontSize: theme.activeItemStyle.fontSize! * textScaleFactor)
        : theme.itemStyle.copyWith(fontSize: theme.itemStyle.fontSize! * textScaleFactor);

    final Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (item.icon != null) ...[
          Icon(
            item.icon,
            size: iconSize,
            color: style.color,
          ),
          SizedBox(width: theme.iconSpacing),
        ],
        Text(
          item.title,
          style: style,
        ),
      ],
    );

    if (isLast || item.disabled || item.onTap == null) {
      return content;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: item.onTap,
        child: Container(
          padding: theme.itemPadding,
          decoration: BoxDecoration(
            borderRadius: theme.itemBorderRadius,
            color: theme.itemHoverColor,
          ),
          child: content,
        ),
      ),
    );
  }

  double _getTextScaleFactor() {
    switch (size) {
      case chromaSize.xs:
        return 0.875;
      case chromaSize.sm:
        return 0.9375;
      case chromaSize.md:
        return 1.0;
      case chromaSize.lg:
        return 1.0625;
      case chromaSize.xl:
        return 1.125;
    }
  }

  double _getIconSize(chromaBreadcrumbTheme theme) {
    return theme.iconSize * _getTextScaleFactor();
  }
}

/// 面包屑主题
class chromaBreadcrumbTheme extends ThemeExtension<chromaBreadcrumbTheme> {
  const chromaBreadcrumbTheme({
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 1.0,
    this.borderRadius,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.separatorStyle,
    this.separatorPadding = const EdgeInsets.symmetric(horizontal: 8),
    this.itemStyle,
    this.activeItemStyle,
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    this.itemBorderRadius,
    this.itemHoverColor,
    this.iconSize = 16.0,
    this.iconSpacing = 4.0,
  });

  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final BorderRadius? borderRadius;
  final EdgeInsets padding;
  final TextStyle? separatorStyle;
  final EdgeInsets separatorPadding;
  final TextStyle? itemStyle;
  final TextStyle? activeItemStyle;
  final EdgeInsets itemPadding;
  final BorderRadius? itemBorderRadius;
  final Color? itemHoverColor;
  final double iconSize;
  final double iconSpacing;

  @override
  chromaBreadcrumbTheme copyWith({
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    TextStyle? separatorStyle,
    EdgeInsets? separatorPadding,
    TextStyle? itemStyle,
    TextStyle? activeItemStyle,
    EdgeInsets? itemPadding,
    BorderRadius? itemBorderRadius,
    Color? itemHoverColor,
    double? iconSize,
    double? iconSpacing,
  }) {
    return chromaBreadcrumbTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      separatorStyle: separatorStyle ?? this.separatorStyle,
      separatorPadding: separatorPadding ?? this.separatorPadding,
      itemStyle: itemStyle ?? this.itemStyle,
      activeItemStyle: activeItemStyle ?? this.activeItemStyle,
      itemPadding: itemPadding ?? this.itemPadding,
      itemBorderRadius: itemBorderRadius ?? this.itemBorderRadius,
      itemHoverColor: itemHoverColor ?? this.itemHoverColor,
      iconSize: iconSize ?? this.iconSize,
      iconSpacing: iconSpacing ?? this.iconSpacing,
    );
  }

  @override
  chromaBreadcrumbTheme lerp(ThemeExtension<chromaBreadcrumbTheme>? other, double t) {
    if (other is! chromaBreadcrumbTheme) {
      return this;
    }

    return chromaBreadcrumbTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      borderColor: Color.lerp(borderColor, other.borderColor, t),
      borderWidth: ui.lerpDouble(borderWidth, other.borderWidth, t)!,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t),
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t)!,
      separatorStyle: TextStyle.lerp(separatorStyle, other.separatorStyle, t),
      separatorPadding: EdgeInsetsGeometry.lerp(separatorPadding, other.separatorPadding, t)!,
      itemStyle: TextStyle.lerp(itemStyle, other.itemStyle, t),
      activeItemStyle: TextStyle.lerp(activeItemStyle, other.activeItemStyle, t),
      itemPadding: EdgeInsetsGeometry.lerp(itemPadding, other.itemPadding, t)!,
      itemBorderRadius: BorderRadius.lerp(itemBorderRadius, other.itemBorderRadius, t),
      itemHoverColor: Color.lerp(itemHoverColor, other.itemHoverColor, t),
      iconSize: ui.lerpDouble(iconSize, other.iconSize, t)!,
      iconSpacing: ui.lerpDouble(iconSpacing, other.iconSpacing, t)!,
    );
  }

  static chromaBreadcrumbTheme of(BuildContext context) {
    final theme = Theme.of(context);
    return theme.extension<chromaBreadcrumbTheme>() ?? _fallbackTheme(context);
  }

  static chromaBreadcrumbTheme _fallbackTheme(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return chromaBreadcrumbTheme(
      backgroundColor: Colors.transparent,
      borderColor: colorScheme.outline.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(4),
      separatorStyle: textTheme.bodySmall?.copyWith(
        color: colorScheme.onSurface.withValues(alpha: 0.6),
      ),
      itemStyle: textTheme.bodySmall?.copyWith(
        color: colorScheme.primary,
        fontWeight: FontWeight.w400,
      ),
      activeItemStyle: textTheme.bodySmall?.copyWith(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w500,
      ),
      itemBorderRadius: BorderRadius.circular(2),
      itemHoverColor: colorScheme.primary.withValues(alpha: 0.1),
    );
  }
}
