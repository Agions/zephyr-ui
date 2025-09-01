/// ZephyrUI Bottom Navigation Bar Component
/// 
/// A modern bottom navigation bar with support for labels, icons, badges,
/// and smooth animations. Perfect for mobile applications.
library bottom_navigation_bar;

import 'package:flutter/material.dart';
import 'bottom_navigation_bar_theme.dart';

/// Bottom navigation bar item configuration
class ZephyrBottomNavigationItem {
  /// Creates a bottom navigation item
  const ZephyrBottomNavigationItem({
    required this.icon,
    required this.label,
    this.activeIcon,
    this.badge,
    this.onTap,
  });

  /// Icon for the item
  final Widget icon;

  /// Label for the item
  final String label;

  /// Icon to show when active (optional)
  final Widget? activeIcon;

  /// Badge to display (optional)
  final Widget? badge;

  /// Callback when tapped
  final VoidCallback? onTap;
}

/// Bottom navigation bar type
enum ZephyrBottomNavigationType {
  /// Labels only show when active
  shifting,
  
  /// Labels always show
  fixed,
  
  /// Only icons, no labels
  iconOnly,
}

/// ZephyrUI Bottom Navigation Bar
class ZephyrBottomNavigationBar extends StatefulWidget {
  /// Creates a bottom navigation bar
  const ZephyrBottomNavigationBar({
    super.key,
    required this.items,
    this.currentIndex = 0,
    this.type = ZephyrBottomNavigationType.fixed,
    this.onTap,
    this.backgroundColor,
    this.elevation = 8.0,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.theme,
    this.animationDuration = const Duration(milliseconds: 200),
    this.showSelectedLabels = true,
    this.showUnselectedLabels = true,
    this.enableFeedback = true,
  });

  /// List of navigation items
  final List<ZephyrBottomNavigationItem> items;

  /// Current selected index
  final int currentIndex;

  /// Navigation bar type
  final ZephyrBottomNavigationType type;

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
  final ZephyrBottomNavigationBarTheme? theme;

  /// Animation duration
  final Duration animationDuration;

  /// Whether to show labels for selected items
  final bool showSelectedLabels;

  /// Whether to show labels for unselected items
  final bool showUnselectedLabels;

  /// Whether to enable feedback sounds
  final bool enableFeedback;

  @override
  State<ZephyrBottomNavigationBar> createState() => _ZephyrBottomNavigationBarState();
}

class _ZephyrBottomNavigationBarState extends State<ZephyrBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? ZephyrBottomNavigationBarTheme.of(context);
    
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? theme.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: widget.elevation,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: widget.items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return _buildNavItem(index, item, theme);
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    ZephyrBottomNavigationItem item,
    ZephyrBottomNavigationBarTheme theme,
  ) {
    final isSelected = index == widget.currentIndex;
    final shouldShowLabel = _shouldShowLabel(isSelected);

    Widget iconWidget = isSelected && item.activeIcon != null
        ? item.activeIcon!
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

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (widget.enableFeedback) {
              Feedback.forTap(context);
            }
            widget.onTap?.call(index);
            item.onTap?.call();
          },
          borderRadius: BorderRadius.circular(theme.itemBorderRadius),
          child: AnimatedContainer(
            duration: widget.animationDuration,
            padding: EdgeInsets.symmetric(
              vertical: theme.itemPaddingVertical,
              horizontal: theme.itemPaddingHorizontal,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon with badge
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    iconWidget,
                    if (item.badge != null)
                      Positioned(
                        right: -8,
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
                    style: _getLabelStyle(isSelected, theme),
                    child: Text(
                      item.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _shouldShowLabel(bool isSelected) {
    switch (widget.type) {
      case ZephyrBottomNavigationType.shifting:
        return isSelected && widget.showSelectedLabels;
      case ZephyrBottomNavigationType.fixed:
        return isSelected ? widget.showSelectedLabels : widget.showUnselectedLabels;
      case ZephyrBottomNavigationType.iconOnly:
        return false;
    }
  }

  TextStyle _getLabelStyle(bool isSelected, ZephyrBottomNavigationBarTheme theme) {
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

/// Bottom navigation bar with dot indicator
class ZephyrBottomNavigationBarWithDots extends StatefulWidget {
  /// Creates a bottom navigation bar with dot indicators
  const ZephyrBottomNavigationBarWithDots({
    super.key,
    required this.items,
    this.currentIndex = 0,
    this.type = ZephyrBottomNavigationType.fixed,
    this.onTap,
    this.backgroundColor,
    this.elevation = 8.0,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.theme,
    this.animationDuration = const Duration(milliseconds: 200),
    this.showSelectedLabels = true,
    this.showUnselectedLabels = true,
    this.enableFeedback = true,
    this.dotColor,
    this.dotSize = 4.0,
    this.showDotIndicator = true,
  });

  /// List of navigation items
  final List<ZephyrBottomNavigationItem> items;

  /// Current selected index
  final int currentIndex;

  /// Navigation bar type
  final ZephyrBottomNavigationType type;

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
  final ZephyrBottomNavigationBarTheme? theme;

  /// Animation duration
  final Duration animationDuration;

  /// Whether to show labels for selected items
  final bool showSelectedLabels;

  /// Whether to show labels for unselected items
  final bool showUnselectedLabels;

  /// Whether to enable feedback sounds
  final bool enableFeedback;

  /// Color for the dot indicator
  final Color? dotColor;

  /// Size of the dot indicator
  final double dotSize;

  /// Whether to show the dot indicator
  final bool showDotIndicator;

  @override
  State<ZephyrBottomNavigationBarWithDots> createState() => _ZephyrBottomNavigationBarWithDotsState();
}

class _ZephyrBottomNavigationBarWithDotsState extends State<ZephyrBottomNavigationBarWithDots> {
  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? ZephyrBottomNavigationBarTheme.of(context);
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Standard bottom navigation bar
        Expanded(
          child: ZephyrBottomNavigationBar(
            items: widget.items,
            currentIndex: widget.currentIndex,
            type: widget.type,
            onTap: widget.onTap,
            backgroundColor: widget.backgroundColor,
            elevation: widget.elevation,
            selectedItemColor: widget.selectedItemColor,
            unselectedItemColor: widget.unselectedItemColor,
            theme: widget.theme,
            animationDuration: widget.animationDuration,
            showSelectedLabels: widget.showSelectedLabels,
            showUnselectedLabels: widget.showUnselectedLabels,
            enableFeedback: widget.enableFeedback,
          ),
        ),
        // Dot indicator
        if (widget.showDotIndicator) ...[
          SizedBox(height: theme.dotIndicatorSpacing),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.items.asMap().entries.map((entry) {
              final index = entry.key;
              final isSelected = index == widget.currentIndex;
              
              return AnimatedContainer(
                duration: widget.animationDuration,
                margin: EdgeInsets.symmetric(horizontal: widget.dotSize / 2),
                width: isSelected ? widget.dotSize * 3 : widget.dotSize,
                height: widget.dotSize,
                decoration: BoxDecoration(
                  color: isSelected
                      ? (widget.dotColor ?? widget.selectedItemColor ?? theme.selectedColor)
                      : theme.unselectedDotColor,
                  borderRadius: BorderRadius.circular(widget.dotSize / 2),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: theme.dotIndicatorBottomSpacing),
        ],
      ],
    );
  }
}