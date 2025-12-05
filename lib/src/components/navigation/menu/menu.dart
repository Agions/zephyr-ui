/// VelocityUI 菜单组件
library velocity_menu;

import 'package:flutter/material.dart';
import 'menu_style.dart';

export 'menu_style.dart';

/// VelocityUI 弹出菜单
class VelocityMenu extends StatelessWidget {
  const VelocityMenu({
    super.key,
    required this.items,
    required this.child,
    this.onSelected,
    this.offset = Offset.zero,
    this.style,
  });

  final List<VelocityMenuItem> items;
  final Widget child;
  final ValueChanged<dynamic>? onSelected;
  final Offset offset;
  final VelocityMenuStyle? style;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? const VelocityMenuStyle();

    return PopupMenuButton(
      offset: offset,
      shape: RoundedRectangleBorder(borderRadius: effectiveStyle.borderRadius),
      color: effectiveStyle.backgroundColor,
      itemBuilder: (context) => items.map((item) {
        if (item.isDivider) return const PopupMenuDivider() as PopupMenuEntry;
        return PopupMenuItem(
          value: item.value,
          enabled: !item.disabled,
          padding: effectiveStyle.itemPadding,
          child: Row(
            children: [
              if (item.icon != null) ...[
                Icon(item.icon, size: effectiveStyle.iconSize, color: item.disabled ? effectiveStyle.disabledColor : effectiveStyle.iconColor),
                SizedBox(width: effectiveStyle.iconSpacing),
              ],
              Text(item.label!, style: item.disabled ? effectiveStyle.disabledStyle : effectiveStyle.labelStyle),
            ],
          ),
        );
      }).toList(),
      onSelected: onSelected,
      child: child,
    );
  }
}

class VelocityMenuItem {
  const VelocityMenuItem({this.label, this.value, this.icon, this.disabled = false}) : isDivider = false;
  const VelocityMenuItem.divider() : label = null, value = null, icon = null, disabled = false, isDivider = true;
  final String? label;
  final dynamic value;
  final IconData? icon;
  final bool disabled;
  final bool isDivider;
}
