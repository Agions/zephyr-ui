/// ZephyrUI Breadcrumb Navigation Component
/// 
/// A breadcrumb navigation component that shows the user's location in a hierarchy.
/// Supports custom separators, icons, and interactive navigation.
library breadcrumb;

import 'package:flutter/material.dart';
import 'breadcrumb_theme.dart';

/// Breadcrumb item configuration
class ZephyrBreadcrumbItem {
  /// Creates a breadcrumb item
  const ZephyrBreadcrumbItem({
    required this.title,
    this.icon,
    this.onTap,
    this.isCurrent = false,
    this.isDisabled = false,
    this.tooltip,
  });

  /// Title of the breadcrumb item
  final String title;

  /// Optional icon for the breadcrumb item
  final Widget? icon;

  /// Callback when tapped (null if not clickable)
  final VoidCallback? onTap;

  /// Whether this is the current page
  final bool isCurrent;

  /// Whether this item is disabled
  final bool isDisabled;

  /// Optional tooltip text
  final String? tooltip;

  /// Create a copy with modified properties
  ZephyrBreadcrumbItem copyWith({
    String? title,
    Widget? icon,
    VoidCallback? onTap,
    bool? isCurrent,
    bool? isDisabled,
    String? tooltip,
  }) {
    return ZephyrBreadcrumbItem(
      title: title ?? this.title,
      icon: icon ?? this.icon,
      onTap: onTap ?? this.onTap,
      isCurrent: isCurrent ?? this.isCurrent,
      isDisabled: isDisabled ?? this.isDisabled,
      tooltip: tooltip ?? this.tooltip,
    );
  }
}

/// Breadcrumb separator type
enum ZephyrBreadcrumbSeparatorType {
  /// Default slash separator
  slash,
  
  /// Chevron separator
  chevron,
  
  /// Arrow separator
  arrow,
  
  /// Dot separator
  dot,
  
  /// Custom widget separator
  custom,
}

/// ZephyrUI Breadcrumb Navigation
class ZephyrBreadcrumb extends StatefulWidget {
  /// Creates a breadcrumb navigation
  const ZephyrBreadcrumb({
    Key? key,
    required this.items,
    this.separatorType = ZephyrBreadcrumbSeparatorType.chevron,
    this.customSeparator,
    this.maxItems = 5,
    this.theme,
    this.overflowItemText = '...',
    this.onOverflowTap,
    this.direction = Axis.horizontal,
    this.spacing = 8.0,
    this.separatorSpacing = 8.0,
    this.showTooltip = true,
  }) : super(key: key);

  /// List of breadcrumb items
  final List<ZephyrBreadcrumbItem> items;

  /// Type of separator between items
  final ZephyrBreadcrumbSeparatorType separatorType;

  /// Custom separator widget
  final Widget? customSeparator;

  /// Maximum number of items to show before truncating
  final int maxItems;

  /// Custom theme
  final ZephyrBreadcrumbTheme? theme;

  /// Text to show for overflow item
  final String overflowItemText;

  /// Callback when overflow item is tapped
  final VoidCallback? onOverflowTap;

  /// Direction of the breadcrumb
  final Axis direction;

  /// Spacing between items
  final double spacing;

  /// Spacing around separators
  final double separatorSpacing;

  /// Whether to show tooltips
  final bool showTooltip;

  @override
  State<ZephyrBreadcrumb> createState() => _ZephyrBreadcrumbState();
}

class _ZephyrBreadcrumbState extends State<ZephyrBreadcrumb> {
  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? ZephyrBreadcrumbTheme.of(context);
    
    List<ZephyrBreadcrumbItem> effectiveItems = widget.items;
    
    // Handle overflow
    if (effectiveItems.length > widget.maxItems) {
      effectiveItems = _handleOverflow(effectiveItems);
    }

    return widget.direction == Axis.horizontal
        ? _buildHorizontalBreadcrumb(effectiveItems, theme)
        : _buildVerticalBreadcrumb(effectiveItems, theme);
  }

  Widget _buildHorizontalBreadcrumb(
    List<ZephyrBreadcrumbItem> items,
    ZephyrBreadcrumbTheme theme,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _buildBreadcrumbItems(items, theme, isHorizontal: true),
      ),
    );
  }

  Widget _buildVerticalBreadcrumb(
    List<ZephyrBreadcrumbItem> items,
    ZephyrBreadcrumbTheme theme,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildBreadcrumbItems(items, theme, isHorizontal: false),
    );
  }

  List<Widget> _buildBreadcrumbItems(
    List<ZephyrBreadcrumbItem> items,
    ZephyrBreadcrumbTheme theme, {
    required bool isHorizontal,
  }) {
    final List<Widget> children = [];

    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final isLast = i == items.length - 1;

      // Add item
      children.add(
        _buildBreadcrumbItem(item, theme, isLast: isLast),
      );

      // Add separator if not last item
      if (!isLast) {
        if (isHorizontal) {
          children.add(SizedBox(width: widget.separatorSpacing));
        } else {
          children.add(SizedBox(height: widget.separatorSpacing));
        }
        children.add(_buildSeparator(theme));
        if (isHorizontal) {
          children.add(SizedBox(width: widget.separatorSpacing));
        } else {
          children.add(SizedBox(height: widget.separatorSpacing));
        }
      }
    }

    return children;
  }

  Widget _buildBreadcrumbItem(
    ZephyrBreadcrumbItem item,
    ZephyrBreadcrumbTheme theme, {
    required bool isLast,
  }) {
    final isClickable = item.onTap != null && !item.isDisabled && !item.isCurrent;
    final textStyle = _getTextStyle(item, theme);

    Widget itemContent = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (item.icon != null) ...[
          item.icon!,
          SizedBox(width: widget.spacing / 2),
        ],
        Flexible(
          child: Text(
            item.title,
            style: textStyle,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );

    // Add tooltip if enabled
    if (widget.showTooltip && (item.tooltip != null || item.title.length > 20)) {
      itemContent = Tooltip(
        message: item.tooltip ?? item.title,
        child: itemContent,
      );
    }

    // Make interactive if clickable
    if (isClickable) {
      itemContent = MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: item.onTap,
          child: itemContent,
        ),
      );
    }

    return Container(
      padding: theme.itemPadding,
      decoration: isLast
          ? BoxDecoration(
              color: theme.currentItemBackgroundColor,
              borderRadius: theme.itemBorderRadius,
            )
          : null,
      child: DefaultTextStyle(
        style: textStyle,
        child: itemContent,
      ),
    );
  }

  Widget _buildSeparator(ZephyrBreadcrumbTheme theme) {
    switch (widget.separatorType) {
      case ZephyrBreadcrumbSeparatorType.slash:
        return Text(
          '/',
          style: theme.separatorStyle,
        );
      case ZephyrBreadcrumbSeparatorType.chevron:
        return Icon(
          Icons.chevron_right,
          size: theme.separatorIconSize,
          color: theme.separatorStyle.color,
        );
      case ZephyrBreadcrumbSeparatorType.arrow:
        return Icon(
          Icons.arrow_forward_ios,
          size: theme.separatorIconSize,
          color: theme.separatorStyle.color,
        );
      case ZephyrBreadcrumbSeparatorType.dot:
        return Container(
          width: theme.separatorIconSize,
          height: theme.separatorIconSize,
          decoration: BoxDecoration(
            color: theme.separatorStyle.color,
            shape: BoxShape.circle,
          ),
        );
      case ZephyrBreadcrumbSeparatorType.custom:
        return widget.customSeparator ?? const Text('/');
    }
  }

  TextStyle _getTextStyle(ZephyrBreadcrumbItem item, ZephyrBreadcrumbTheme theme) {
    if (item.isCurrent) {
      return theme.currentItemStyle;
    } else if (item.isDisabled) {
      return theme.disabledItemStyle;
    } else {
      return theme.itemStyle;
    }
  }

  List<ZephyrBreadcrumbItem> _handleOverflow(List<ZephyrBreadcrumbItem> items) {
    final List<ZephyrBreadcrumbItem> result = [];
    
    // Always show first item
    result.add(items.first);
    
    // Add overflow item if needed
    if (items.length > widget.maxItems) {
      result.add(
        ZephyrBreadcrumbItem(
          title: widget.overflowItemText,
          onTap: widget.onOverflowTap,
          isDisabled: widget.onOverflowTap == null,
        ),
      );
    }
    
    // Always show last few items
    final itemsToShow = widget.maxItems - 2;
    final startIndex = items.length - itemsToShow;
    for (int i = startIndex; i < items.length; i++) {
      if (i > 0) { // Skip first item as it's already added
        result.add(items[i]);
      }
    }
    
    return result;
  }
}

/// Collapsible breadcrumb that expands on hover/click
class ZephyrCollapsibleBreadcrumb extends StatefulWidget {
  /// Creates a collapsible breadcrumb
  const ZephyrCollapsibleBreadcrumb({
    Key? key,
    required this.items,
    this.separatorType = ZephyrBreadcrumbSeparatorType.chevron,
    this.customSeparator,
    this.maxCollapsedItems = 3,
    this.theme,
    this.overflowItemText = '...',
    this.onOverflowTap,
    this.expandOnHover = true,
    this.showExpandButton = true,
  }) : super(key: key);

  /// List of breadcrumb items
  final List<ZephyrBreadcrumbItem> items;

  /// Type of separator between items
  final ZephyrBreadcrumbSeparatorType separatorType;

  /// Custom separator widget
  final Widget? customSeparator;

  /// Maximum number of items to show when collapsed
  final int maxCollapsedItems;

  /// Custom theme
  final ZephyrBreadcrumbTheme? theme;

  /// Text to show for overflow item
  final String overflowItemText;

  /// Callback when overflow item is tapped
  final VoidCallback? onOverflowTap;

  /// Whether to expand on hover
  final bool expandOnHover;

  /// Whether to show expand button
  final bool showExpandButton;

  @override
  State<ZephyrCollapsibleBreadcrumb> createState() => _ZephyrCollapsibleBreadcrumbState();
}

class _ZephyrCollapsibleBreadcrumbState extends State<ZephyrCollapsibleBreadcrumb> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: widget.expandOnHover ? (_) => _expand() : null,
      onExit: widget.expandOnHover ? (_) => _collapse() : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ZephyrBreadcrumb(
            items: _isExpanded ? widget.items : _getCollapsedItems(),
            separatorType: widget.separatorType,
            customSeparator: widget.customSeparator,
            maxItems: widget.maxCollapsedItems,
            theme: widget.theme,
            overflowItemText: widget.overflowItemText,
            onOverflowTap: widget.onOverflowTap,
          ),
          if (widget.showExpandButton && widget.items.length > widget.maxCollapsedItems)
            TextButton(
              onPressed: _toggleExpand,
              child: Text(_isExpanded ? '收起' : '展开全部'),
            ),
        ],
      ),
    );
  }

  List<ZephyrBreadcrumbItem> _getCollapsedItems() {
    if (widget.items.length <= widget.maxCollapsedItems) {
      return widget.items;
    }

    final List<ZephyrBreadcrumbItem> result = [];
    
    // Show first item
    result.add(widget.items.first);
    
    // Show last few items
    final itemsToShow = widget.maxCollapsedItems - 1;
    final startIndex = widget.items.length - itemsToShow;
    for (int i = startIndex; i < widget.items.length; i++) {
      if (i > 0) {
        result.add(widget.items[i]);
      }
    }
    
    return result;
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _expand() {
    if (!_isExpanded) {
      setState(() {
        _isExpanded = true;
      });
    }
  }

  void _collapse() {
    if (_isExpanded) {
      setState(() {
        _isExpanded = false;
      });
    }
  }
}