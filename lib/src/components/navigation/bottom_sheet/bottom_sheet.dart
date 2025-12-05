/// VelocityUI 底部面板组件
library velocity_bottom_sheet;

import 'package:flutter/material.dart';
import 'bottom_sheet_style.dart';

export 'bottom_sheet_style.dart';

/// VelocityUI 底部面板
class VelocityBottomSheet {
  /// 显示底部面板
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool showHandle = true,
    bool showCloseButton = false,
    bool isDismissible = true,
    bool enableDrag = true,
    double? height,
    VelocityBottomSheetStyle? style,
  }) {
    final effectiveStyle = style ?? const VelocityBottomSheetStyle();
    
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: height,
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
        decoration: BoxDecoration(
          color: effectiveStyle.backgroundColor,
          borderRadius: effectiveStyle.borderRadius,
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showHandle) Container(
                margin: effectiveStyle.handleMargin,
                width: effectiveStyle.handleWidth,
                height: effectiveStyle.handleHeight,
                decoration: BoxDecoration(color: effectiveStyle.handleColor, borderRadius: BorderRadius.circular(effectiveStyle.handleHeight / 2)),
              ),
              if (title != null || showCloseButton) Padding(
                padding: effectiveStyle.headerPadding,
                child: Row(
                  children: [
                    if (title != null) Expanded(child: Text(title, style: effectiveStyle.titleStyle)),
                    if (showCloseButton) IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.close, color: effectiveStyle.closeIconColor, size: effectiveStyle.closeIconSize),
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
              Flexible(child: SingleChildScrollView(padding: effectiveStyle.contentPadding, child: child)),
            ],
          ),
        ),
      ),
    );
  }

  /// 显示操作面板
  static Future<T?> showActions<T>({
    required BuildContext context,
    required List<VelocityBottomSheetAction> actions,
    String? title,
    String? cancelText,
    VelocityBottomSheetStyle? style,
  }) {
    final effectiveStyle = style ?? const VelocityBottomSheetStyle();
    
    return show<T>(
      context: context,
      title: title,
      style: style,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...actions.map((action) => ListTile(
            leading: action.icon != null ? Icon(action.icon, color: action.isDestructive ? effectiveStyle.destructiveColor : effectiveStyle.actionIconColor) : null,
            title: Text(action.label, style: TextStyle(color: action.isDestructive ? effectiveStyle.destructiveColor : effectiveStyle.actionTextColor, fontSize: 16)),
            onTap: () {
              Navigator.of(context).pop(action.value);
              action.onTap?.call();
            },
          )),
          if (cancelText != null) ...[
            Divider(color: effectiveStyle.dividerColor),
            ListTile(
              title: Text(cancelText, style: effectiveStyle.cancelStyle, textAlign: TextAlign.center),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ],
      ),
    );
  }
}

/// 操作项
class VelocityBottomSheetAction<T> {
  const VelocityBottomSheetAction({required this.label, this.value, this.icon, this.onTap, this.isDestructive = false});
  final String label;
  final T? value;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool isDestructive;
}
