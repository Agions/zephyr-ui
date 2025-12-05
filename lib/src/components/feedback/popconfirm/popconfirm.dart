/// VelocityUI 确认气泡组件
library velocity_popconfirm;

import 'package:flutter/material.dart';
import 'popconfirm_style.dart';

export 'popconfirm_style.dart';

/// VelocityUI 确认气泡
class VelocityPopconfirm extends StatefulWidget {
  const VelocityPopconfirm({
    super.key,
    required this.child,
    required this.title,
    this.content,
    this.confirmText = '确定',
    this.cancelText = '取消',
    this.onConfirm,
    this.onCancel,
    this.style,
  });

  final Widget child;
  final String title;
  final String? content;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final VelocityPopconfirmStyle? style;

  @override
  State<VelocityPopconfirm> createState() => _VelocityPopconfirmState();
}

class _VelocityPopconfirmState extends State<VelocityPopconfirm> {
  final _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  void _show() {
    final effectiveStyle = widget.style ?? const VelocityPopconfirmStyle();
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(onTap: _hide, child: Container(color: Colors.transparent)),
          Positioned(
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(-60 + size.width / 2, -10),
              targetAnchor: Alignment.topCenter,
              followerAnchor: Alignment.bottomCenter,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: effectiveStyle.width,
                  padding: effectiveStyle.padding,
                  decoration: BoxDecoration(
                    color: effectiveStyle.backgroundColor,
                    borderRadius: effectiveStyle.borderRadius,
                    boxShadow: effectiveStyle.boxShadow,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.help_outline, size: 16, color: effectiveStyle.iconColor),
                          const SizedBox(width: 8),
                          Expanded(child: Text(widget.title, style: effectiveStyle.titleStyle)),
                        ],
                      ),
                      if (widget.content != null) Padding(
                        padding: const EdgeInsets.only(top: 8, left: 24),
                        child: Text(widget.content!, style: effectiveStyle.contentStyle),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () { _hide(); widget.onCancel?.call(); },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  border: Border.all(color: effectiveStyle.cancelBorderColor),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(widget.cancelText, style: effectiveStyle.cancelStyle),
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () { _hide(); widget.onConfirm?.call(); },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: effectiveStyle.confirmBackgroundColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(widget.confirmText, style: effectiveStyle.confirmStyle),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
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
      child: GestureDetector(onTap: _show, child: widget.child),
    );
  }
}
