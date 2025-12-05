/// VelocityUI 滚动组件
library velocity_scroll;

import 'package:flutter/material.dart';
import 'scroll_style.dart';

export 'scroll_style.dart';

/// VelocityUI 滚动视图
class VelocityScrollView extends StatelessWidget {
  const VelocityScrollView({
    super.key,
    required this.children,
    this.direction = Axis.vertical,
    this.padding,
    this.physics,
    this.controller,
    this.reverse = false,
  });

  final List<Widget> children;
  final Axis direction;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final ScrollController? controller;
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: direction,
      padding: padding,
      physics: physics,
      controller: controller,
      reverse: reverse,
      child: direction == Axis.vertical
          ? Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: children)
          : Row(mainAxisSize: MainAxisSize.min, children: children),
    );
  }
}

/// VelocityUI 下拉刷新
class VelocityRefresh extends StatelessWidget {
  const VelocityRefresh({
    super.key,
    required this.child,
    required this.onRefresh,
    this.color,
    this.backgroundColor,
    this.displacement = 40,
  });

  final Widget child;
  final Future<void> Function() onRefresh;
  final Color? color;
  final Color? backgroundColor;
  final double displacement;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: color ?? Theme.of(context).primaryColor,
      backgroundColor: backgroundColor,
      displacement: displacement,
      child: child,
    );
  }
}

/// VelocityUI 滚动到顶部按钮
class VelocityScrollToTop extends StatefulWidget {
  const VelocityScrollToTop({
    super.key,
    required this.child,
    required this.controller,
    this.showAfter = 200,
    this.style,
  });

  final Widget child;
  final ScrollController controller;
  final double showAfter;
  final VelocityScrollToTopStyle? style;

  @override
  State<VelocityScrollToTop> createState() => _VelocityScrollToTopState();
}

class _VelocityScrollToTopState extends State<VelocityScrollToTop> {
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    setState(() => _showButton = widget.controller.offset > widget.showAfter);
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = widget.style ?? const VelocityScrollToTopStyle();
    
    return Stack(
      children: [
        widget.child,
        if (_showButton)
          Positioned(
            right: effectiveStyle.right,
            bottom: effectiveStyle.bottom,
            child: FloatingActionButton.small(
              onPressed: () => widget.controller.animateTo(0, duration: effectiveStyle.animationDuration, curve: Curves.easeOut),
              backgroundColor: effectiveStyle.backgroundColor,
              child: Icon(Icons.keyboard_arrow_up, color: effectiveStyle.iconColor),
            ),
          ),
      ],
    );
  }
}
