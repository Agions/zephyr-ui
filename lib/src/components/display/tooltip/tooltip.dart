import 'dart:async';
import 'package:flutter/material.dart';
import 'tooltip_theme.dart';

class ZephyrTooltip extends StatefulWidget {
  const ZephyrTooltip({
    required this.child,
    required this.message,
    super.key,
    this.theme,
    this.placement = ZephyrTooltipPlacement.top,
    this.trigger = ZephyrTooltipTrigger.hover,
    this.duration = const Duration(milliseconds: 200),
    this.showDelay = const Duration(milliseconds: 500),
    this.hideDelay = const Duration(milliseconds: 100),
    this.disabled = false,
    this.overlay = true,
    this.arrow = true,
    this.maxWidth = 350,
  });

  final Widget child;
  final String message;
  final ZephyrTooltipTheme? theme;
  final ZephyrTooltipPlacement placement;
  final ZephyrTooltipTrigger trigger;
  final Duration duration;
  final Duration showDelay;
  final Duration hideDelay;
  final bool disabled;
  final bool overlay;
  final bool arrow;
  final double maxWidth;

  @override
  State<ZephyrTooltip> createState() => _ZephyrTooltipState();
}

class _ZephyrTooltipState extends State<ZephyrTooltip> {
  bool _isShowing = false;
  Timer? _showTimer;
  Timer? _hideTimer;

  @override
  void dispose() {
    _showTimer?.cancel();
    _hideTimer?.cancel();
    super.dispose();
  }

  void _showTooltip() {
    if (widget.disabled) return;

    _hideTimer?.cancel();
    _showTimer?.cancel();

    _showTimer = Timer(widget.showDelay, () {
      setState(() {
        _isShowing = true;
      });
    });
  }

  void _hideTooltip() {
    _showTimer?.cancel();

    _hideTimer = Timer(widget.hideDelay, () {
      setState(() {
        _isShowing = false;
      });
    });
  }

  Widget _buildTooltipContent(
      BuildContext context, ZephyrTooltipTheme themeData) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: widget.maxWidth,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: themeData.backgroundColor,
          borderRadius: BorderRadius.circular(themeData.borderRadius ?? 6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          widget.message,
          style: themeData.textStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.disabled) {
      return widget.child;
    }

    return Tooltip(
      message: widget.message,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inverseSurface,
        borderRadius: BorderRadius.circular(6),
      ),
      textStyle: TextStyle(
        color: Theme.of(context).colorScheme.onInverseSurface,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      preferBelow: widget.placement == ZephyrTooltipPlacement.bottom,
      verticalOffset: widget.placement == ZephyrTooltipPlacement.top ? -20 : 20,
      child: widget.child,
    );
  }
}

class ZephyrRichTooltip extends StatefulWidget {
  const ZephyrRichTooltip({
    required this.child,
    required this.title,
    super.key,
    this.content,
    this.actions,
    this.theme,
    this.placement = ZephyrTooltipPlacement.top,
    this.trigger = ZephyrTooltipTrigger.click,
    this.width = 300,
    this.disabled = false,
    this.closeOnClickOutside = true,
  });

  final Widget child;
  final String title;
  final Widget? content;
  final List<Widget>? actions;
  final ZephyrTooltipTheme? theme;
  final ZephyrTooltipPlacement placement;
  final ZephyrTooltipTrigger trigger;
  final double width;
  final bool disabled;
  final bool closeOnClickOutside;

  @override
  State<ZephyrRichTooltip> createState() => _ZephyrRichTooltipState();
}

class _ZephyrRichTooltipState extends State<ZephyrRichTooltip> {
  bool _isShowing = false;
  final LayerLink _link = LayerLink();

  void _toggleTooltip() {
    if (widget.disabled) return;

    setState(() {
      _isShowing = !_isShowing;
    });
  }

  void _hideTooltip() {
    setState(() {
      _isShowing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = widget.theme ?? ZephyrTooltipTheme.of(context);

    return CompositedTransformTarget(
      link: _link,
      child: GestureDetector(
        onTap: widget.trigger == ZephyrTooltipTrigger.click
            ? _toggleTooltip
            : null,
        child: MouseRegion(
          onEnter: widget.trigger == ZephyrTooltipTrigger.hover
              ? (_) => _toggleTooltip()
              : null,
          onExit: widget.trigger == ZephyrTooltipTrigger.hover
              ? (_) => _hideTooltip()
              : null,
          child: widget.child,
        ),
      ),
    );
  }
}

class ZephyrTooltipGroup extends StatelessWidget {
  const ZephyrTooltipGroup({
    required this.children,
    super.key,
    this.theme,
    this.placement = ZephyrTooltipPlacement.top,
    this.trigger = ZephyrTooltipTrigger.hover,
  });

  final List<ZephyrTooltip> children;
  final ZephyrTooltipTheme? theme;
  final ZephyrTooltipPlacement placement;
  final ZephyrTooltipTrigger trigger;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children.map((child) {
        return ZephyrTooltip(
          message: child.message,
          theme: theme ?? child.theme,
          placement: placement,
          trigger: trigger,
          child: child.child,
        );
      }).toList(),
    );
  }
}

enum ZephyrTooltipPlacement {
  top,
  bottom,
  left,
  right,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
  leftTop,
  leftBottom,
  rightTop,
  rightBottom,
}

enum ZephyrTooltipTrigger {
  hover,
  click,
  focus,
  manual,
}
