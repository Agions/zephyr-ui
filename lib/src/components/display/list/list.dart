import 'package:flutter/material.dart';
import 'list_theme.dart';

class ZephyrListItem {
  const ZephyrListItem({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.onLongPress,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
}

class ZephyrList extends StatelessWidget {
  const ZephyrList({
    super.key,
    required this.items,
    this.padding,
    this.shrinkWrap = true,
    this.physics,
  });

  final List<ZephyrListItem> items;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: items.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          leading: item.leading,
          title: Text(item.title),
          subtitle: item.subtitle != null ? Text(item.subtitle!) : null,
          trailing: item.trailing,
          onTap: item.onTap,
          onLongPress: item.onLongPress,
        );
      },
    );
  }
}

class ZephyrListView extends StatelessWidget {
  const ZephyrListView({
    super.key,
    required this.children,
    this.padding,
    this.shrinkWrap = true,
    this.physics,
  });

  final List<Widget> children;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics,
      children: children,
    );
  }
}
