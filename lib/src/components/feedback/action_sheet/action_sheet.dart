/// VelocityUI 动作面板组件
library velocity_action_sheet;

import 'package:flutter/material.dart';
import 'action_sheet_style.dart';

export 'action_sheet_style.dart';

/// VelocityUI 动作面板
class VelocityActionSheet {
  static Future<T?> show<T>({
    required BuildContext context,
    required List<VelocityActionSheetItem<T>> actions, String? title,
    String? message,
    VelocityActionSheetItem<T>? cancelAction,
    VelocityActionSheetStyle? style,
  }) {
    final effectiveStyle = style ?? const VelocityActionSheetStyle();

    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => SafeArea(
        child: Container(
          margin: effectiveStyle.margin,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: effectiveStyle.backgroundColor,
                    borderRadius: effectiveStyle.borderRadius),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (title != null || message != null)
                      Padding(
                        padding: effectiveStyle.headerPadding,
                        child: Column(
                          children: [
                            if (title != null)
                              Text(title,
                                  style: effectiveStyle.titleStyle,
                                  textAlign: TextAlign.center),
                            if (message != null)
                              Padding(
                                padding:
                                    EdgeInsets.only(top: title != null ? 4 : 0),
                                child: Text(message,
                                    style: effectiveStyle.messageStyle,
                                    textAlign: TextAlign.center),
                              ),
                          ],
                        ),
                      ),
                    if (title != null || message != null)
                      Divider(height: 1, color: effectiveStyle.dividerColor),
                    ...actions.map((action) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop(action.value);
                                action.onTap?.call();
                              },
                              child: Container(
                                width: double.infinity,
                                padding: effectiveStyle.actionPadding,
                                child: Text(
                                  action.label,
                                  style: action.isDestructive
                                      ? effectiveStyle.destructiveStyle
                                      : effectiveStyle.actionStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            if (actions.last != action)
                              Divider(
                                  height: 1,
                                  color: effectiveStyle.dividerColor),
                          ],
                        )),
                  ],
                ),
              ),
              if (cancelAction != null) ...[
                SizedBox(height: effectiveStyle.cancelSpacing),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: effectiveStyle.backgroundColor,
                      borderRadius: effectiveStyle.borderRadius),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop(cancelAction.value);
                      cancelAction.onTap?.call();
                    },
                    borderRadius: effectiveStyle.borderRadius,
                    child: Padding(
                      padding: effectiveStyle.actionPadding,
                      child: Text(cancelAction.label,
                          style: effectiveStyle.cancelStyle,
                          textAlign: TextAlign.center),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class VelocityActionSheetItem<T> {
  const VelocityActionSheetItem(
      {required this.label,
      this.value,
      this.onTap,
      this.isDestructive = false});
  final String label;
  final T? value;
  final VoidCallback? onTap;
  final bool isDestructive;
}
