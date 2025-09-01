/// ZephyrUI Navigation Rail Component
/// 
/// A modern navigation rail component for desktop and tablet applications.
/// Supports labels, icons, badges, and smooth animations.
library navigation_rail;

import 'package:flutter/material.dart';
import 'navigation_rail_theme.dart';

/// Navigation rail item configuration
class ZephyrRailItem {
  /// Creates a navigation rail item
  const ZephyrRailItem({
    required this.icon,
    required this.label,
    this.selectedIcon,
    this.badge,
    this.onTap,
  });

  /// Icon for the item
  final Widget icon;

  /// Label for the item
  final String label;

  /// Icon to show when selected (optional)
  final Widget? selectedIcon;

  /// Badge to display (optional)
  final Widget? badge;

  /// Callback when tapped
  final VoidCallback? onTap;
}

/// Navigation rail type
enum ZephyrRailType {
  /// Labels only show when selected
  minimal,
  
  /// Labels always show
  extended,
  
  /// Only icons, no labels
  compact,
}

/// Label alignment type
enum ZephyrRailLabelAlignment {
  /// Labels below icons
  below,
  
  /// Labels to the right of icons
  right,
}

/// ZephyrUI Navigation Rail
class ZephyrNavigationRail extends StatefulWidget {
  /// Creates a navigation rail
  const ZephyrNavigationRail({
    Key? key,
    required this.items,
    this.currentIndex = 0,
    this.type = ZephyrRailType.extended,
    this.labelAlignment = ZephyrRailLabelAlignment.below,
    this.onTap,
    this.backgroundColor,
    this.elevation = 1.0,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.theme,
    this.animationDuration = const Duration(milliseconds: 200),
    this.width = 72.0,
    this.extendedWidth = 256.0,
    this.groupAlignment = -1.0,
    this.leading,
    this.trailing,
    this.showTrailing = true,
    this.enableFeedback = true,
    this.useIndicator = true,
    this.indicatorColor,
    this.indicatorShape,
  }) : super(key: key);

  /// List of navigation items
  final List<ZephyrRailItem> items;

  /// Current selected index
  final int currentIndex;

  /// Navigation rail type
  final ZephyrRailType type;

  /// Label alignment
  final ZephyrRailLabelAlignment labelAlignment;

  /// Callback when item is tapped
  final ValueChanged<int>? onTap;

  /// Background color
  final Color? backgroundColor;

  /// Elevation (shadow)
  final double elevation;

  /// Color for selected items
  final Color? selectedItemColor;

  /// Color for unselected items
  final Color? unselectedItemColor;

  /// Custom theme
  final ZephyrNavigationRailTheme? theme;

  /// Animation duration
  final Duration animationDuration;

  /// Width when compact
  final double width;

  /// Width when extended
  final double extendedWidth;

  /// Group alignment (-1.0 to 1.0)
  final double groupAlignment;

  /// Widget to show at the top
  final Widget? leading;

  /// Widget to show at the bottom
  final Widget? trailing;

  /// Whether to show trailing widget
  final bool showTrailing;

  /// Whether to enable feedback sounds
  final bool enableFeedback;

  /// Whether to use selection indicator
  final bool useIndicator;

  /// Indicator color
  final Color? indicatorColor;

  /// Indicator shape
  final ShapeBorder? indicatorShape;

  @override
  State<ZephyrNavigationRail> createState() => _ZephyrNavigationRailState();
}

class _ZephyrNavigationRailState extends State<ZephyrNavigationRail> {
  bool _isExtended = false;

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? ZephyrNavigationRailTheme.of(context);
    final isExtended = widget.type == ZephyrRailType.extended || _isExtended;
    final effectiveWidth = isExtended ? widget.extendedWidth : widget.width;

    return Material(
      elevation: widget.elevation,
      color: widget.backgroundColor ?? theme.backgroundColor,
      child: SizedBox(
        width: effectiveWidth,
        child: Column(
          children: [
            // Leading widget
            if (widget.leading != null)
              Padding(
                padding: theme.leadingPadding,
                child: widget.leading,
              ),
            
            // Main navigation items
            Expanded(
              child: Align(
                alignment: Alignment(0.0, widget.groupAlignment),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: widget.items.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                      return _buildRailItem(index, item, theme, isExtended);
                    }).toList(),
                  ),
                ),
              ),
            ),
            
            // Trailing widget
            if (widget.trailing != null && widget.showTrailing)
              Padding(
                padding: theme.trailingPadding,
                child: widget.trailing,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRailItem(
    int index,
    ZephyrRailItem item,
    ZephyrNavigationRailTheme theme,
    bool isExtended,
  ) {
    final isSelected = index == widget.currentIndex;
    final shouldShowLabel = _shouldShowLabel(isSelected, isExtended);

    Widget iconWidget = isSelected && item.selectedIcon != null
        ? item.selectedIcon!
        : item.icon;

    // Apply color based on selection state
    if (isSelected) {
      iconWidget = IconTheme(
        data: IconThemeData(
          color: widget.selectedItemColor ?? theme.selectedColor,
          size: theme.selectedIconSize,
        ),
        child: iconWidget,
      );
    } else {
      iconWidget = IconTheme(
        data: IconThemeData(
          color: widget.unselectedItemColor ?? theme.unselectedColor,
          size: theme.unselectedIconSize,
        ),
        child: iconWidget,
      );
    }

    Widget itemContent = Container(
      width: isExtended ? widget.extendedWidth : widget.width,
      height: theme.itemHeight,
      child: Stack(
        children: [
          // Selection indicator
          if (widget.useIndicator && isSelected)
            Positioned.fill(
              child: AnimatedContainer(
                duration: widget.animationDuration,
                decoration: BoxDecoration(
                  color: widget.indicatorColor ?? theme.indicatorColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          
          // Main content
          AnimatedContainer(
            duration: widget.animationDuration,
            padding: theme.itemPadding,
            child: widget.labelAlignment == ZephyrRailLabelAlignment.below
                ? _buildVerticalLayout(iconWidget, item, shouldShowLabel, theme)
                : _buildHorizontalLayout(iconWidget, item, shouldShowLabel, theme),
          ),
        ],
      ),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (widget.enableFeedback) {
            Feedback.forTap(context);
          }
          widget.onTap?.call(index);
          item.onTap?.call();
        },
        borderRadius: theme.itemBorderRadius,
        child: itemContent,
      ),
    );
  }

  Widget _buildVerticalLayout(
    Widget iconWidget,
    ZephyrRailItem item,
    bool shouldShowLabel,
    ZephyrNavigationRailTheme theme,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Icon with badge
        Stack(
          clipBehavior: Clip.none,
          children: [
            iconWidget,
            if (item.badge != null)
              Positioned(
                right: -4,
                top: -4,
                child: item.badge!,
              ),
          ],
        ),
        // Label
        if (shouldShowLabel) ...[
          SizedBox(height: theme.labelSpacing),
          AnimatedDefaultTextStyle(
            duration: widget.animationDuration,
            style: _getLabelStyle(true, theme),
            child: Text(
              item.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildHorizontalLayout(
    Widget iconWidget,
    ZephyrRailItem item,
    bool shouldShowLabel,
    ZephyrNavigationRailTheme theme,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Icon with badge
        Stack(
          clipBehavior: Clip.none,
          children: [
            iconWidget,
            if (item.badge != null)
              Positioned(
                right: -4,
                top: -4,
                child: item.badge!,
              ),
          ],
        ),
        // Label
        if (shouldShowLabel) ...[
          SizedBox(width: theme.labelSpacing),
          Expanded(
            child: AnimatedDefaultTextStyle(
              duration: widget.animationDuration,
              style: _getLabelStyle(true, theme),
              child: Text(
                item.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ],
    );
  }

  bool _shouldShowLabel(bool isSelected, bool isExtended) {
    switch (widget.type) {
      case ZephyrRailType.minimal:
        return isSelected;
      case ZephyrRailType.extended:
        return true;
      case ZephyrRailType.compact:
        return false;
    }
  }

  TextStyle _getLabelStyle(bool isSelected, ZephyrNavigationRailTheme theme) {
    if (isSelected) {
      return theme.selectedLabelStyle.copyWith(
        color: widget.selectedItemColor ?? theme.selectedColor,
      );
    } else {
      return theme.unselectedLabelStyle.copyWith(
        color: widget.unselectedItemColor ?? theme.unselectedColor,
      );
    }
  }
}

/// Expandable navigation rail with toggle button
class ZephyrExpandableNavigationRail extends StatefulWidget {
  /// Creates an expandable navigation rail
  const ZephyrExpandableNavigationRail({
    Key? key,
    required this.items,
    this.currentIndex = 0,
    this.onTap,
    this.backgroundColor,
    this.elevation = 1.0,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.theme,
    this.animationDuration = const Duration(milliseconds: 200),
    this.width = 72.0,
    this.extendedWidth = 256.0,
    this.groupAlignment = -1.0,
    this.leading,
    this.trailing,
    this.showTrailing = true,
    this.enableFeedback = true,
    this.useIndicator = true,
    this.indicatorColor,
    this.indicatorShape,
    this.initiallyExtended = false,
    this.toggleIcon,
    this.extendedToggleIcon,
  }) : super(key: key);

  /// List of navigation items
  final List<ZephyrRailItem> items;

  /// Current selected index
  final int currentIndex;

  /// Callback when item is tapped
  final ValueChanged<int>? onTap;

  /// Background color
  final Color? backgroundColor;

  /// Elevation (shadow)
  final double elevation;

  /// Color for selected items
  final Color? selectedItemColor;

  /// Color for unselected items
  final Color? unselectedItemColor;

  /// Custom theme
  final ZephyrNavigationRailTheme? theme;

  /// Animation duration
  final Duration animationDuration;

  /// Width when compact
  final double width;

  /// Width when extended
  final double extendedWidth;

  /// Group alignment (-1.0 to 1.0)
  final double groupAlignment;

  /// Widget to show at the top
  final Widget? leading;

  /// Widget to show at the bottom
  final Widget? trailing;

  /// Whether to show trailing widget
  final bool showTrailing;

  /// Whether to enable feedback sounds
  final bool enableFeedback;

  /// Whether to use selection indicator
  final bool useIndicator;

  /// Indicator color
  final Color? indicatorColor;

  /// Indicator shape
  final ShapeBorder? indicatorShape;

  /// Whether to start in extended state
  final bool initiallyExtended;

  /// Icon for toggle button when collapsed
  final Widget? toggleIcon;

  /// Icon for toggle button when extended
  final Widget? extendedToggleIcon;

  @override
  State<ZephyrExpandableNavigationRail> createState() => _ZephyrExpandableNavigationRailState();
}

class _ZephyrExpandableNavigationRailState extends State<ZephyrExpandableNavigationRail> {
  late bool _isExtended;

  @override
  void initState() {
    super.initState();
    _isExtended = widget.initiallyExtended;
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? ZephyrNavigationRailTheme.of(context);
    
    return ZephyrNavigationRail(
      items: widget.items,
      currentIndex: widget.currentIndex,
      type: _isExtended ? ZephyrRailType.extended : ZephyrRailType.minimal,
      onTap: widget.onTap,
      backgroundColor: widget.backgroundColor,
      elevation: widget.elevation,
      selectedItemColor: widget.selectedItemColor,
      unselectedItemColor: widget.unselectedItemColor,
      theme: theme,
      animationDuration: widget.animationDuration,
      width: widget.width,
      extendedWidth: widget.extendedWidth,
      groupAlignment: widget.groupAlignment,
      leading: widget.leading,
      trailing: Column(
        children: [
          if (widget.trailing != null && widget.showTrailing)
            widget.trailing!,
          SizedBox(height: theme.toggleButtonSpacing),
          _buildToggleButton(theme),
        ],
      ),
      showTrailing: true,
      enableFeedback: widget.enableFeedback,
      useIndicator: widget.useIndicator,
      indicatorColor: widget.indicatorColor,
      indicatorShape: widget.indicatorShape,
    );
  }

  Widget _buildToggleButton(ZephyrNavigationRailTheme theme) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            _isExtended = !_isExtended;
          });
        },
        borderRadius: theme.itemBorderRadius,
        child: Container(
          width: theme.itemHeight,
          height: theme.itemHeight,
          padding: theme.itemPadding,
          child: IconTheme(
            data: IconThemeData(
              color: theme.unselectedColor,
              size: theme.unselectedIconSize,
            ),
            child: _isExtended
                ? (widget.extendedToggleIcon ?? const Icon(Icons.keyboard_arrow_left))
                : (widget.toggleIcon ?? const Icon(Icons.keyboard_arrow_right)),
          ),
        ),
      ),
    );
  }
}