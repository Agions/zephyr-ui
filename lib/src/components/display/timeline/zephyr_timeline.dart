/// ZephyrUI 时间线组件
/// 
/// 提供专业的时间线展示组件，支持多种样式和交互

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart' as zephyr_ui;
import 'dart:ui' as ui;

/// 时间线项目模型
class ZephyrTimelineItem {
  final String id;
  final String title;
  final String? subtitle;
  final String? description;
  final Widget? icon;
  final Color? color;
  final DateTime? time;
  final bool isCompleted;
  final bool isActive;
  final Widget? trailing;
  final VoidCallback? onTap;

  const ZephyrTimelineItem({
    required this.id,
    required this.title,
    this.subtitle,
    this.description,
    this.icon,
    this.color,
    this.time,
    this.isCompleted = false,
    this.isActive = false,
    this.trailing,
    this.onTap,
  });
}

/// 时间线方向
enum ZephyrTimelineDirection {
  vertical,
  horizontal,
}

/// 时间线样式
enum ZephyrTimelineStyle {
  basic,
  detailed,
  compact,
  card,
}

/// 时间线组件
class ZephyrTimeline extends StatelessWidget {
  final List<ZephyrTimelineItem> items;
  final ZephyrTimelineDirection direction;
  final ZephyrTimelineStyle style;
  final CrossAxisAlignment crossAxisAlignment;
  final double spacing;
  final double lineThickness;
  final Color? lineColor;
  final double dotSize;
  final EdgeInsetsGeometry padding;
  final bool showTime;
  final bool showTrailing;
  final ZephyrTimelineTheme? theme;

  const ZephyrTimeline({
    Key? key,
    required this.items,
    this.direction = ZephyrTimelineDirection.vertical,
    this.style = ZephyrTimelineStyle.basic,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.spacing = 16.0,
    this.lineThickness = 2.0,
    this.lineColor,
    this.dotSize = 12.0,
    this.padding = const EdgeInsets.all(16.0),
    this.showTime = true,
    this.showTrailing = true,
    this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = ZephyrTimelineTheme.resolve(context, theme);
    
    return zephyr_ui.ZephyrPerformanceWidget(
      widgetName: 'ZephyrTimeline',
      child: Container(
        padding: padding,
        child: direction == ZephyrTimelineDirection.vertical
            ? _buildVerticalTimeline(effectiveTheme)
            : _buildHorizontalTimeline(effectiveTheme),
      ),
    );
  }

  Widget _buildVerticalTimeline(ZephyrTimelineTheme effectiveTheme) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: List.generate(items.length * 2 - 1, (index) {
        if (index.isOdd) {
          // 连接线
          final itemIndex = index ~/ 2;
          final isLastItem = itemIndex == items.length - 1;
          
          if (isLastItem) return const SizedBox.shrink();
          
          return Container(
            width: lineThickness,
            height: spacing,
            color: lineColor ?? effectiveTheme.lineColor,
          );
        }
        
        // 时间线项目
        final itemIndex = index ~/ 2;
        final item = items[itemIndex];
        final isLastItem = itemIndex == items.length - 1;
        
        return _buildTimelineItem(
          item,
          effectiveTheme,
          isLastItem: isLastItem,
        );
      }),
    );
  }

  Widget _buildHorizontalTimeline(ZephyrTimelineTheme effectiveTheme) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: crossAxisAlignment,
        children: List.generate(items.length * 2 - 1, (index) {
          if (index.isOdd) {
            // 连接线
            final itemIndex = index ~/ 2;
            final isLastItem = itemIndex == items.length - 1;
            
            if (isLastItem) return const SizedBox.shrink();
            
            return Container(
              width: spacing,
              height: lineThickness,
              color: lineColor ?? effectiveTheme.lineColor,
            );
          }
          
          // 时间线项目
          final itemIndex = index ~/ 2;
          final item = items[itemIndex];
          final isLastItem = itemIndex == items.length - 1;
          
          return _buildTimelineItem(
            item,
            effectiveTheme,
            isLastItem: isLastItem,
            isHorizontal: true,
          );
        }),
      ),
    );
  }

  Widget _buildTimelineItem(
    ZephyrTimelineItem item,
    ZephyrTimelineTheme effectiveTheme, {
    bool isLastItem = false,
    bool isHorizontal = false,
  }) {
    final itemWidget = switch (style) {
      ZephyrTimelineStyle.basic => _buildBasicItem(item, effectiveTheme),
      ZephyrTimelineStyle.detailed => _buildDetailedItem(item, effectiveTheme),
      ZephyrTimelineStyle.compact => _buildCompactItem(item, effectiveTheme),
      ZephyrTimelineStyle.card => _buildCardItem(item, effectiveTheme),
    };

    return InkWell(
      onTap: item.onTap,
      borderRadius: BorderRadius.circular(effectiveTheme.borderRadius),
      child: isHorizontal
          ? Column(
              crossAxisAlignment: crossAxisAlignment,
              children: [
                _buildTimelineDot(item, effectiveTheme),
                const SizedBox(height: 8),
                itemWidget,
              ],
            )
          : Row(
              crossAxisAlignment: crossAxisAlignment,
              children: [
                _buildTimelineDot(item, effectiveTheme),
                const SizedBox(width: 16),
                Expanded(child: itemWidget),
                if (showTrailing && item.trailing != null) ...[
                  const SizedBox(width: 8),
                  item.trailing!,
                ],
              ],
            ),
    );
  }

  Widget _buildTimelineDot(ZephyrTimelineItem item, ZephyrTimelineTheme effectiveTheme) {
    final dotColor = item.color ?? 
        (item.isCompleted 
            ? effectiveTheme.completedColor 
            : item.isActive 
                ? effectiveTheme.activeColor 
                : effectiveTheme.inactiveColor);

    return Container(
      width: dotSize,
      height: dotSize,
      decoration: BoxDecoration(
        color: dotColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: effectiveTheme.borderColor,
          width: effectiveTheme.borderWidth,
        ),
      ),
      child: item.icon != null
          ? IconTheme(
              data: IconThemeData(
                color: effectiveTheme.iconColor,
                size: dotSize * 0.6,
              ),
              child: item.icon!,
            )
          : null,
    );
  }

  Widget _buildBasicItem(ZephyrTimelineItem item, ZephyrTimelineTheme effectiveTheme) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        ZephyrText.subtitle(
          text: item.title,
          color: item.isActive ? effectiveTheme.activeTextColor : effectiveTheme.textColor,
        ),
        if (item.subtitle != null) ...[
          const SizedBox(height: 4),
          ZephyrText.body(
            text: item.subtitle!,
            color: effectiveTheme.subtitleColor,
          ),
        ],
        if (showTime && item.time != null) ...[
          const SizedBox(height: 4),
          ZephyrText.caption(
            text: _formatTime(item.time!),
            color: effectiveTheme.timeColor,
          ),
        ],
      ],
    );
  }

  Widget _buildDetailedItem(ZephyrTimelineItem item, ZephyrTimelineTheme effectiveTheme) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Row(
          children: [
            Expanded(
              child: ZephyrText.subtitle(
                text: item.title,
                color: item.isActive ? effectiveTheme.activeTextColor : effectiveTheme.textColor,
              ),
            ),
            if (showTime && item.time != null)
              ZephyrText.caption(
                text: _formatTime(item.time!),
                color: effectiveTheme.timeColor,
              ),
          ],
        ),
        if (item.subtitle != null) ...[
          const SizedBox(height: 4),
          ZephyrText.body(
            text: item.subtitle!,
            color: effectiveTheme.subtitleColor,
          ),
        ],
        if (item.description != null) ...[
          const SizedBox(height: 8),
          ZephyrText.body(
            text: item.description!,
            color: effectiveTheme.descriptionColor,
          ),
        ],
      ],
    );
  }

  Widget _buildCompactItem(ZephyrTimelineItem item, ZephyrTimelineTheme effectiveTheme) {
    return Row(
      children: [
        Expanded(
          child: ZephyrText.body(
            text: item.title,
            color: item.isActive ? effectiveTheme.activeTextColor : effectiveTheme.textColor,
          ),
        ),
        if (showTime && item.time != null)
          ZephyrText.caption(
            text: _formatTime(item.time!),
            color: effectiveTheme.timeColor,
          ),
      ],
    );
  }

  Widget _buildCardItem(ZephyrTimelineItem item, ZephyrTimelineTheme effectiveTheme) {
    return ZephyrCard(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _buildDetailedItem(item, effectiveTheme),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays == 0) {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return '昨天 ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}天前';
    } else {
      return '${time.month}/${time.day}';
    }
  }
}

/// 时间线主题
class ZephyrTimelineTheme extends ThemeExtension<ZephyrTimelineTheme> {
  final Color lineColor;
  final Color completedColor;
  final Color activeColor;
  final Color inactiveColor;
  final Color borderColor;
  final double borderWidth;
  final Color iconColor;
  final Color textColor;
  final Color activeTextColor;
  final Color subtitleColor;
  final Color descriptionColor;
  final Color timeColor;
  final double borderRadius;

  const ZephyrTimelineTheme({
    required this.lineColor,
    required this.completedColor,
    required this.activeColor,
    required this.inactiveColor,
    required this.borderColor,
    required this.borderWidth,
    required this.iconColor,
    required this.textColor,
    required this.activeTextColor,
    required this.subtitleColor,
    required this.descriptionColor,
    required this.timeColor,
    required this.borderRadius,
  });

  @override
  ZephyrTimelineTheme copyWith({
    Color? lineColor,
    Color? completedColor,
    Color? activeColor,
    Color? inactiveColor,
    Color? borderColor,
    double? borderWidth,
    Color? iconColor,
    Color? textColor,
    Color? activeTextColor,
    Color? subtitleColor,
    Color? descriptionColor,
    Color? timeColor,
    double? borderRadius,
  }) {
    return ZephyrTimelineTheme(
      lineColor: lineColor ?? this.lineColor,
      completedColor: completedColor ?? this.completedColor,
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      iconColor: iconColor ?? this.iconColor,
      textColor: textColor ?? this.textColor,
      activeTextColor: activeTextColor ?? this.activeTextColor,
      subtitleColor: subtitleColor ?? this.subtitleColor,
      descriptionColor: descriptionColor ?? this.descriptionColor,
      timeColor: timeColor ?? this.timeColor,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  ZephyrTimelineTheme lerp(ThemeExtension<ZephyrTimelineTheme>? other, double t) {
    if (other is! ZephyrTimelineTheme) {
      return this;
    }
    return ZephyrTimelineTheme(
      lineColor: Color.lerp(lineColor, other.lineColor, t)!,
      completedColor: Color.lerp(completedColor, other.completedColor, t)!,
      activeColor: Color.lerp(activeColor, other.activeColor, t)!,
      inactiveColor: Color.lerp(inactiveColor, other.inactiveColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      borderWidth: ui.lerpDouble(borderWidth, other.borderWidth, t) ?? borderWidth,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      activeTextColor: Color.lerp(activeTextColor, other.activeTextColor, t)!,
      subtitleColor: Color.lerp(subtitleColor, other.subtitleColor, t)!,
      descriptionColor: Color.lerp(descriptionColor, other.descriptionColor, t)!,
      timeColor: Color.lerp(timeColor, other.timeColor, t)!,
      borderRadius: ui.lerpDouble(borderRadius, other.borderRadius, t) ?? borderRadius,
    );
  }

  static ZephyrTimelineTheme of(BuildContext context) {
    final theme = Theme.of(context).extension<ZephyrTimelineTheme>();
    return theme ?? _createDefaultTheme(ZephyrThemeData.of(context));
  }

  static ZephyrTimelineTheme resolve(
    BuildContext context,
    ZephyrTimelineTheme? theme,
  ) {
    return theme ?? of(context);
  }

  static ZephyrTimelineTheme _createDefaultTheme(ZephyrThemeData zephyrTheme) {
    return ZephyrTimelineTheme(
      lineColor: Colors.grey.shade300,
      completedColor: Colors.green,
      activeColor: Colors.blue,
      inactiveColor: Colors.grey.shade400,
      borderColor: Colors.white,
      borderWidth: 2.0,
      iconColor: Colors.white,
      textColor: Colors.grey.shade800,
      activeTextColor: Colors.blue.shade800,
      subtitleColor: Colors.grey.shade600,
      descriptionColor: Colors.grey.shade500,
      timeColor: Colors.grey.shade500,
      borderRadius: 8.0,
    );
  }
}