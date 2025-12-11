/// VelocityUI 徽章组件
library velocity_badge;

import 'package:flutter/material.dart';
import 'badge_style.dart';

export 'badge_style.dart';

/// 徽章类型
enum VelocityBadgeType { primary, success, warning, error, info }

/// VelocityUI 徽章组件
class VelocityBadge extends StatelessWidget {
  /// 创建徽章组件
  const VelocityBadge({
    super.key,
    this.count,
    this.dot = false,
    this.showZero = false,
    this.max = 99,
    this.type = VelocityBadgeType.error,
    this.offset,
    this.style,
    this.child,
  });

  /// 数量
  final int? count;

  /// 是否显示为点
  final bool dot;

  /// 是否显示零
  final bool showZero;

  /// 最大值
  final int max;

  /// 类型
  final VelocityBadgeType type;

  /// 偏移量
  final Offset? offset;

  /// 自定义样式
  final VelocityBadgeStyle? style;

  /// 子组件
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? VelocityBadgeStyle.fromType(type);
    final showBadge = dot || (count != null && (count! > 0 || showZero));

    if (!showBadge) return child ?? const SizedBox.shrink();

    Widget badge;
    if (dot) {
      badge = Container(
        width: effectiveStyle.dotSize,
        height: effectiveStyle.dotSize,
        decoration: BoxDecoration(
            color: effectiveStyle.backgroundColor, shape: BoxShape.circle),
      );
    } else {
      final displayCount = count! > max ? '$max+' : '$count';
      badge = Container(
        height: effectiveStyle.height,
        constraints: BoxConstraints(minWidth: effectiveStyle.minWidth),
        padding: effectiveStyle.padding,
        decoration: BoxDecoration(
            color: effectiveStyle.backgroundColor,
            borderRadius: effectiveStyle.borderRadius),
        child: Center(
          child: Text(displayCount, style: effectiveStyle.textStyle),
        ),
      );
    }

    if (child == null) return badge;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child!,
        Positioned(
          top: offset?.dy ?? -4,
          right: offset?.dx ?? -4,
          child: badge,
        ),
      ],
    );
  }
}
