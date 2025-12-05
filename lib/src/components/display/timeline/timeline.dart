/// VelocityUI 时间线组件
library velocity_timeline;

import 'package:flutter/material.dart';
import 'timeline_style.dart';

export 'timeline_style.dart';

/// VelocityUI 时间线
class VelocityTimeline extends StatelessWidget {
  const VelocityTimeline({
    super.key,
    required this.items,
    this.reverse = false,
    this.style,
  });

  final List<VelocityTimelineItem> items;
  final bool reverse;
  final VelocityTimelineStyle? style;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? const VelocityTimelineStyle();
    final displayItems = reverse ? items.reversed.toList() : items;

    return Column(
      children: [
        for (int i = 0; i < displayItems.length; i++)
          _buildItem(displayItems[i], i, displayItems.length, effectiveStyle),
      ],
    );
  }

  Widget _buildItem(VelocityTimelineItem item, int index, int total, VelocityTimelineStyle style) {
    final isLast = index == total - 1;
    final dotColor = item.color ?? style.dotColor;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: style.lineOffset,
            child: Column(
              children: [
                if (item.icon != null)
                  Container(
                    width: style.dotSize,
                    height: style.dotSize,
                    decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
                    child: Icon(item.icon, size: style.dotSize * 0.6, color: Colors.white),
                  )
                else
                  Container(
                    width: style.dotSize,
                    height: style.dotSize,
                    decoration: BoxDecoration(
                      color: item.hollow ? Colors.white : dotColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: dotColor, width: 2),
                    ),
                  ),
                if (!isLast)
                  Expanded(
                    child: Container(width: style.lineWidth, color: style.lineColor),
                  ),
              ],
            ),
          ),
          SizedBox(width: style.contentSpacing),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : style.itemSpacing),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (item.label != null)
                    Text(item.label!, style: style.labelStyle),
                  if (item.time != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(item.time!, style: style.timeStyle),
                    ),
                  if (item.content != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: item.content!,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 时间线项
class VelocityTimelineItem {
  const VelocityTimelineItem({
    this.label,
    this.time,
    this.content,
    this.icon,
    this.color,
    this.hollow = false,
  });

  final String? label;
  final String? time;
  final Widget? content;
  final IconData? icon;
  final Color? color;
  final bool hollow;
}
