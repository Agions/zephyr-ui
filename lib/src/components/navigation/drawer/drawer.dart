/// VelocityUI 抽屉组件
library velocity_drawer;

import 'package:flutter/material.dart';
import 'drawer_style.dart';

export 'drawer_style.dart';

/// VelocityUI 抽屉
class VelocityDrawer extends StatelessWidget {
  const VelocityDrawer({
    required this.items, this.header,
    this.footer,
    this.selectedIndex,
    this.onItemTap,
    this.style,
    super.key,
  });

  final Widget? header;
  final List<VelocityDrawerItem> items;
  final Widget? footer;
  final int? selectedIndex;
  final ValueChanged<int>? onItemTap;
  final VelocityDrawerStyle? style;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? const VelocityDrawerStyle();

    return Drawer(
      backgroundColor: effectiveStyle.backgroundColor,
      width: effectiveStyle.width,
      child: SafeArea(
        child: Column(
          children: [
            if (header != null) header!,
            Expanded(
              child: ListView.builder(
                padding: effectiveStyle.itemsPadding,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final isSelected = selectedIndex == index;

                  if (item.isDivider) {
                    return Divider(
                        color: effectiveStyle.dividerColor,
                        height: effectiveStyle.dividerHeight);
                  }

                  return ListTile(
                    leading: item.icon != null
                        ? Icon(item.icon,
                            color: isSelected
                                ? effectiveStyle.selectedColor
                                : effectiveStyle.iconColor)
                        : null,
                    title: Text(item.label!,
                        style: (isSelected
                            ? effectiveStyle.selectedLabelStyle
                            : effectiveStyle.labelStyle)),
                    trailing: item.trailing,
                    selected: isSelected,
                    selectedTileColor: effectiveStyle.selectedBackgroundColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: effectiveStyle.itemBorderRadius),
                    onTap: () {
                      onItemTap?.call(index);
                      if (item.onTap != null) item.onTap!();
                    },
                  );
                },
              ),
            ),
            if (footer != null) footer!,
          ],
        ),
      ),
    );
  }
}

/// 抽屉项
class VelocityDrawerItem {
  const VelocityDrawerItem({this.icon, this.label, this.trailing, this.onTap})
      : isDivider = false;
  const VelocityDrawerItem.divider()
      : icon = null,
        label = null,
        trailing = null,
        onTap = null,
        isDivider = true;

  final IconData? icon;
  final String? label;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isDivider;
}
