/// VelocityUI 列表组件
library velocity_list;

import 'package:flutter/material.dart';
import 'list_style.dart';

export 'list_style.dart';

/// VelocityUI 列表项
class VelocityListTile extends StatelessWidget {
  const VelocityListTile({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.enabled = true,
    this.selected = false,
    this.dense = false,
    this.style,
  });

  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool enabled;
  final bool selected;
  final bool dense;
  final VelocityListTileStyle? style;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? const VelocityListTileStyle();

    return Material(
      color: selected
          ? effectiveStyle.selectedColor
          : effectiveStyle.backgroundColor,
      child: InkWell(
        onTap: enabled ? onTap : null,
        onLongPress: enabled ? onLongPress : null,
        splashColor: effectiveStyle.splashColor,
        child: Container(
          padding: dense ? effectiveStyle.densePadding : effectiveStyle.padding,
          child: Row(
            children: [
              if (leading != null) ...[
                leading!,
                SizedBox(width: effectiveStyle.leadingSpacing)
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (title != null)
                      DefaultTextStyle(
                          style: effectiveStyle.titleStyle, child: title!),
                    if (subtitle != null) ...[
                      SizedBox(height: effectiveStyle.subtitleSpacing),
                      DefaultTextStyle(
                          style: effectiveStyle.subtitleStyle,
                          child: subtitle!),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...[
                SizedBox(width: effectiveStyle.trailingSpacing),
                trailing!
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// VelocityUI 列表分组
class VelocityListGroup extends StatelessWidget {
  const VelocityListGroup({
    super.key,
    this.header,
    required this.children,
    this.divider = true,
    this.style,
  });

  final Widget? header;
  final List<Widget> children;
  final bool divider;
  final VelocityListGroupStyle? style;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? const VelocityListGroupStyle();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (header != null)
          Padding(
              padding: effectiveStyle.headerPadding,
              child: DefaultTextStyle(
                  style: effectiveStyle.headerStyle, child: header!)),
        Container(
          decoration: BoxDecoration(
              color: effectiveStyle.backgroundColor,
              borderRadius: effectiveStyle.borderRadius),
          child: Column(
            children: [
              for (int i = 0; i < children.length; i++) ...[
                children[i],
                if (divider && i < children.length - 1)
                  Divider(
                      height: 1,
                      thickness: 1,
                      color: effectiveStyle.dividerColor,
                      indent: effectiveStyle.dividerIndent),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
