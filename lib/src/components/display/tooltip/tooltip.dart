/// VelocityUI 提示框组件
library velocity_tooltip;

import 'package:flutter/material.dart';
import 'tooltip_style.dart';

export 'tooltip_style.dart';

/// 提示位置
enum VelocityTooltipPosition { top, bottom, left, right }

/// VelocityUI 提示框
class VelocityTooltip extends StatelessWidget {
  const VelocityTooltip({
    required this.message, required this.child, super.key,
    this.position = VelocityTooltipPosition.top,
    this.richMessage,
    this.style,
  });

  final String message;
  final Widget child;
  final VelocityTooltipPosition position;
  final InlineSpan? richMessage;
  final VelocityTooltipStyle? style;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? const VelocityTooltipStyle();

    return Tooltip(
      message: richMessage == null ? message : '',
      richMessage: richMessage,
      preferBelow: position == VelocityTooltipPosition.bottom,
      verticalOffset: effectiveStyle.verticalOffset,
      padding: effectiveStyle.padding,
      margin: effectiveStyle.margin,
      decoration: BoxDecoration(
          color: effectiveStyle.backgroundColor,
          borderRadius: effectiveStyle.borderRadius,
          boxShadow: effectiveStyle.boxShadow),
      textStyle: effectiveStyle.textStyle,
      waitDuration: effectiveStyle.waitDuration,
      showDuration: effectiveStyle.showDuration,
      child: child,
    );
  }
}

/// VelocityUI Popover 气泡
class VelocityPopover extends StatefulWidget {
  const VelocityPopover({
    required this.content, required this.child, super.key,
    this.position = VelocityTooltipPosition.bottom,
    this.trigger = VelocityPopoverTrigger.tap,
    this.style,
  });

  final Widget content;
  final Widget child;
  final VelocityTooltipPosition position;
  final VelocityPopoverTrigger trigger;
  final VelocityTooltipStyle? style;

  @override
  State<VelocityPopover> createState() => _VelocityPopoverState();
}

enum VelocityPopoverTrigger { tap, longPress }

class _VelocityPopoverState extends State<VelocityPopover> {
  final _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  void _show() {
    final effectiveStyle = widget.style ?? const VelocityTooltipStyle();
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(
              0, widget.position == VelocityTooltipPosition.bottom ? 8 : -8),
          targetAnchor: widget.position == VelocityTooltipPosition.bottom
              ? Alignment.bottomCenter
              : Alignment.topCenter,
          followerAnchor: widget.position == VelocityTooltipPosition.bottom
              ? Alignment.topCenter
              : Alignment.bottomCenter,
          child: Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: _hide,
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: effectiveStyle.padding,
                decoration: BoxDecoration(
                    color: effectiveStyle.backgroundColor,
                    borderRadius: effectiveStyle.borderRadius,
                    boxShadow: effectiveStyle.boxShadow),
                child: widget.content,
              ),
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _hide();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: widget.trigger == VelocityPopoverTrigger.tap
            ? () {
                _overlayEntry == null ? _show() : _hide();
              }
            : null,
        onLongPress:
            widget.trigger == VelocityPopoverTrigger.longPress ? _show : null,
        child: widget.child,
      ),
    );
  }
}
