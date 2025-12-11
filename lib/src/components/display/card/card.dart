/// VelocityUI 卡片组件
library velocity_card;

import 'package:flutter/material.dart';
import 'card_style.dart';

export 'card_style.dart';

/// VelocityUI 卡片组件
class VelocityCard extends StatelessWidget {
  /// 创建卡片组件
  const VelocityCard({
    super.key,
    this.child,
    this.style,
    this.onTap,
    this.onLongPress,
  });

  /// 子组件
  final Widget? child;

  /// 自定义样式
  final VelocityCardStyle? style;

  /// 点击回调
  final VoidCallback? onTap;

  /// 长按回调
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? VelocityCardStyle.defaults();

    Widget card = Container(
      width: effectiveStyle.width,
      height: effectiveStyle.height,
      margin: effectiveStyle.margin,
      padding: effectiveStyle.padding,
      decoration: BoxDecoration(
        color: effectiveStyle.backgroundColor,
        borderRadius: effectiveStyle.borderRadius,
        border: effectiveStyle.border,
        boxShadow: effectiveStyle.boxShadow,
      ),
      clipBehavior: effectiveStyle.clipBehavior ?? Clip.none,
      child: child,
    );

    if (onTap != null || onLongPress != null) {
      card = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: effectiveStyle.borderRadius,
          child: card,
        ),
      );
    }

    return card;
  }
}

/// VelocityUI 轮廓卡片
class VelocityOutlinedCard extends StatelessWidget {
  /// 创建轮廓卡片
  const VelocityOutlinedCard({
    super.key,
    this.child,
    this.style,
    this.onTap,
  });

  final Widget? child;
  final VelocityCardStyle? style;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return VelocityCard(
      style: (style ?? VelocityCardStyle.defaults()).copyWith(
        backgroundColor: Colors.transparent,
        border: style?.border ?? VelocityCardStyle.outlinedBorder(),
        boxShadow: const [],
      ),
      onTap: onTap,
      child: child,
    );
  }
}

/// VelocityUI 填充卡片
class VelocityFilledCard extends StatelessWidget {
  /// 创建填充卡片
  const VelocityFilledCard({
    super.key,
    this.child,
    this.style,
    this.onTap,
  });

  final Widget? child;
  final VelocityCardStyle? style;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return VelocityCard(
      style: (style ?? VelocityCardStyle.defaults()).copyWith(
        backgroundColor:
            style?.backgroundColor ?? VelocityCardStyle.filledBackground(),
        boxShadow: const [],
      ),
      onTap: onTap,
      child: child,
    );
  }
}
