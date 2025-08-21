import 'package:flutter/material.dart';
import 'breadcrumb_theme.dart';

/// Breadcrumb Item
/// 
/// Represents a single item in the breadcrumb navigation
class ZephyrBreadcrumbItem {
  final String title;
  final String? route;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool isCurrent;
  final Widget? customWidget;

  const ZephyrBreadcrumbItem({
    required this.title,
    this.route,
    this.icon,
    this.onTap,
    this.isCurrent = false,
    this.customWidget,
  });
}

/// Breadcrumb Component
/// 
/// A comprehensive breadcrumb navigation component with icons,
/// custom separators, and responsive design for enterprise applications.
class ZephyrBreadcrumb extends StatelessWidget {
  final List<ZephyrBreadcrumbItem> items;
  final Widget? separator;
  final ZephyrBreadcrumbTheme theme;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? spacing;
  final bool showIcons;
  final bool showCurrent;
  final bool wrapContent;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final String? semanticLabel;
  final bool enableAccessibilityFeatures;
  final double? maxWidth;
  final bool showTooltip;
  final String? tooltipPrefix;
  final int maxItems;
  final String? collapsedLabel;
  final bool autoCollapse;
  final bool enableRouteNavigation;
  final RouteObserver<PageRoute>? routeObserver;

  ZephyrBreadcrumb({
    Key? key,
    required this.items,
    this.separator,
    ZephyrBreadcrumbTheme? theme,
    this.margin,
    this.padding,
    this.spacing,
    this.showIcons = true,
    this.showCurrent = true,
    this.wrapContent = false,
    this.mainAxisSize = MainAxisSize.min,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.semanticLabel,
    this.enableAccessibilityFeatures = true,
    this.maxWidth,
    this.showTooltip = true,
    this.tooltipPrefix,
    this.maxItems = 5,
    this.collapsedLabel,
    this.autoCollapse = true,
    this.enableRouteNavigation = true,
    this.routeObserver,
  })  : theme = theme ?? ZephyrBreadcrumbTheme.light(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final effectiveItems = _getEffectiveItems();
    
    return Container(
      width: maxWidth,
      margin: margin,
      padding: padding ?? theme.padding ?? const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: theme.backgroundColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(theme.borderRadius ?? 0),
        border: Border.all(
          color: theme.borderColor ?? Colors.transparent,
          width: theme.borderWidth ?? 0,
        ),
      ),
      child: Semantics(
        label: semanticLabel ?? 'Breadcrumb navigation',
        enabled: enableAccessibilityFeatures,
        child: _buildBreadcrumbContent(effectiveItems),
      ),
    );
  }

  List<ZephyrBreadcrumbItem> _getEffectiveItems() {
    if (!autoCollapse || items.length <= maxItems) {
      return items;
    }

    final result = <ZephyrBreadcrumbItem>[];
    
    // Always show first item
    result.add(items.first);
    
    // Add collapsed item
    result.add(ZephyrBreadcrumbItem(
      title: collapsedLabel ?? '...',
      isCurrent: false,
    ));
    
    // Show last maxItems - 2 items
    final startIndex = items.length - (maxItems - 2);
    result.addAll(items.sublist(startIndex.clamp(0, items.length), items.length));
    
    return result;
  }

  Widget _buildBreadcrumbContent(List<ZephyrBreadcrumbItem> effectiveItems) {
    return wrapContent
        ? _buildWrappedBreadcrumb(effectiveItems)
        : _buildSingleLineBreadcrumb(effectiveItems);
  }

  Widget _buildSingleLineBreadcrumb(List<ZephyrBreadcrumbItem> effectiveItems) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: _buildBreadcrumbRow(effectiveItems),
    );
  }

  Widget _buildWrappedBreadcrumb(List<ZephyrBreadcrumbItem> effectiveItems) {
    return _buildBreadcrumbRow(effectiveItems);
  }

  Widget _buildBreadcrumbRow(List<ZephyrBreadcrumbItem> effectiveItems) {
    return Row(
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      children: _buildBreadcrumbItems(effectiveItems),
    );
  }

  List<Widget> _buildBreadcrumbItems(List<ZephyrBreadcrumbItem> effectiveItems) {
    final widgets = <Widget>[];
    final effectiveSpacing = (spacing ?? theme.spacing) ?? 8.0;

    for (int i = 0; i < effectiveItems.length; i++) {
      final item = effectiveItems[i];
      final isLast = i == effectiveItems.length - 1;
      
      // Add breadcrumb item
      widgets.add(
        Flexible(
          child: _buildBreadcrumbItem(item, isLast),
        ),
      );

      // Add separator (except for last item)
      if (!isLast) {
        widgets.add(
          Padding(
            padding: EdgeInsets.symmetric(horizontal: effectiveSpacing / 2),
            child: separator ?? _buildDefaultSeparator(),
          ),
        );
      }
    }

    return widgets;
  }

  Widget _buildBreadcrumbItem(ZephyrBreadcrumbItem item, bool isLast) {
    final isClickable = !item.isCurrent && (item.onTap != null || item.route != null);
    final showCurrentHighlight = showCurrent && item.isCurrent;

    Widget itemWidget = item.customWidget ?? _buildDefaultItemContent(item);

    if (showTooltip && (item.title.length > 20 || isClickable)) {
      itemWidget = Tooltip(
        message: '${tooltipPrefix ?? 'Navigate to'} ${item.title}',
        child: itemWidget,
      );
    }

    if (isClickable) {
      itemWidget = InkWell(
        onTap: () => _handleItemTap(item),
        borderRadius: BorderRadius.circular(theme.itemBorderRadius ?? 0),
        child: itemWidget,
      );
    }

    return Container(
      padding: theme.itemPadding ?? const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      decoration: showCurrentHighlight
          ? BoxDecoration(
              color: theme.currentItemBackgroundColor ?? Colors.transparent,
              borderRadius: BorderRadius.circular(theme.itemBorderRadius ?? 0),
              border: Border.all(
                color: theme.currentItemBorderColor ?? Colors.transparent,
                width: theme.currentItemBorderWidth ?? 0,
              ),
            )
          : null,
      child: DefaultTextStyle(
        style: showCurrentHighlight
            ? (theme.currentItemStyle ?? const TextStyle(fontSize: 14, fontWeight: FontWeight.normal))
            : (isClickable
                ? (theme.clickableItemStyle ?? const TextStyle(fontSize: 14, fontWeight: FontWeight.normal))
                : (theme.itemStyle ?? const TextStyle(fontSize: 14, fontWeight: FontWeight.normal))),
        child: IconTheme(
          data: IconThemeData(
            color: showCurrentHighlight
                ? (theme.currentIconColor ?? Colors.black)
                : (isClickable ? (theme.clickableIconColor ?? Colors.blue) : (theme.iconColor ?? Colors.grey)),
            size: theme.iconSize ?? 16.0,
          ),
          child: itemWidget,
        ),
      ),
    );
  }

  Widget _buildDefaultItemContent(ZephyrBreadcrumbItem item) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showIcons && item.icon != null) ...[
          Icon(item.icon),
          SizedBox(width: theme.iconTextSpacing ?? 6.0),
        ],
        Flexible(
          child: Text(
            item.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildDefaultSeparator() {
    return Icon(
      theme.separatorIcon ?? Icons.chevron_right,
      color: theme.separatorColor ?? Colors.grey,
      size: theme.separatorSize ?? 18.0,
    );
  }

  void _handleItemTap(ZephyrBreadcrumbItem item) {
    if (item.onTap != null) {
      item.onTap!();
    } else if (item.route != null && enableRouteNavigation) {
      // Handle route navigation
      // This would typically integrate with your routing solution
      debugPrint('Navigate to: ${item.route}');
    }
  }
}