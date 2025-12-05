/// VelocityUI Toast组件
library velocity_toast;

import 'package:flutter/material.dart';
import 'toast_style.dart';

export 'toast_style.dart';

/// Toast类型
enum VelocityToastType { info, success, warning, error }

/// Toast位置
enum VelocityToastPosition { top, center, bottom }

/// VelocityUI Toast
class VelocityToast {
  static OverlayEntry? _overlayEntry;

  /// 显示Toast
  static void show(
    BuildContext context, {
    required String message,
    VelocityToastType type = VelocityToastType.info,
    VelocityToastPosition position = VelocityToastPosition.bottom,
    Duration duration = const Duration(seconds: 2),
    VelocityToastStyle? style,
  }) {
    dismiss();
    final effectiveStyle = style ?? VelocityToastStyle.fromType(type);
    
    _overlayEntry = OverlayEntry(
      builder: (context) => _ToastWidget(
        message: message,
        position: position,
        style: effectiveStyle,
      ),
    );
    
    Overlay.of(context).insert(_overlayEntry!);
    Future.delayed(duration, dismiss);
  }

  /// 关闭Toast
  static void dismiss() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

class _ToastWidget extends StatelessWidget {
  const _ToastWidget({required this.message, required this.position, required this.style});
  final String message;
  final VelocityToastPosition position;
  final VelocityToastStyle style;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: position == VelocityToastPosition.top ? MediaQuery.of(context).padding.top + 50 : null,
      bottom: position == VelocityToastPosition.bottom ? MediaQuery.of(context).padding.bottom + 50 : null,
      left: 0,
      right: 0,
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: style.padding,
            decoration: BoxDecoration(color: style.backgroundColor, borderRadius: style.borderRadius, boxShadow: style.boxShadow),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (style.icon != null) ...[Icon(style.icon, size: style.iconSize, color: style.iconColor), SizedBox(width: style.iconSpacing)],
                Text(message, style: style.textStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
