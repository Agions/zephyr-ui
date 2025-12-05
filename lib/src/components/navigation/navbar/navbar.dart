/// VelocityUI 导航栏组件
library velocity_navbar;

import 'package:flutter/material.dart';
import 'navbar_style.dart';

export 'navbar_style.dart';

/// VelocityUI 导航栏
class VelocityNavbar extends StatelessWidget implements PreferredSizeWidget {
  const VelocityNavbar({
    super.key,
    this.title,
    this.titleWidget,
    this.leading,
    this.actions,
    this.centerTitle = true,
    this.style,
  });

  final String? title;
  final Widget? titleWidget;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;
  final VelocityNavbarStyle? style;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? const VelocityNavbarStyle();
    return AppBar(
      title: titleWidget ?? (title != null ? Text(title!, style: effectiveStyle.titleStyle) : null),
      leading: leading,
      actions: actions,
      centerTitle: centerTitle,
      backgroundColor: effectiveStyle.backgroundColor,
      foregroundColor: effectiveStyle.foregroundColor,
      elevation: effectiveStyle.elevation,
      shadowColor: effectiveStyle.shadowColor,
    );
  }
}

/// VelocityUI 底部导航栏
class VelocityBottomNavbar extends StatelessWidget {
  const VelocityBottomNavbar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.style,
  });

  final List<VelocityBottomNavbarItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VelocityBottomNavbarStyle? style;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? const VelocityBottomNavbarStyle();
    return BottomNavigationBar(
      items: items.map((item) => BottomNavigationBarItem(
        icon: Icon(item.icon),
        activeIcon: Icon(item.activeIcon ?? item.icon),
        label: item.label,
      )).toList(),
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: effectiveStyle.backgroundColor,
      selectedItemColor: effectiveStyle.selectedColor,
      unselectedItemColor: effectiveStyle.unselectedColor,
      selectedFontSize: effectiveStyle.selectedFontSize,
      unselectedFontSize: effectiveStyle.unselectedFontSize,
      elevation: effectiveStyle.elevation,
    );
  }
}

/// 底部导航项
class VelocityBottomNavbarItem {
  const VelocityBottomNavbarItem({
    required this.icon,
    this.activeIcon,
    required this.label,
  });
  
  final IconData icon;
  final IconData? activeIcon;
  final String label;
}
