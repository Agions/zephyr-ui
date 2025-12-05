/// VelocityUI 对话框组件
library velocity_dialog;

import 'package:flutter/material.dart';
import 'dialog_style.dart';

export 'dialog_style.dart';

/// VelocityUI 对话框
class VelocityDialog {
  /// 显示确认对话框
  static Future<bool?> confirm(
    BuildContext context, {
    required String title,
    String? content,
    String confirmText = '确定',
    String cancelText = '取消',
    VelocityDialogStyle? style,
  }) async {
    final effectiveStyle = style ?? const VelocityDialogStyle();
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: effectiveStyle.titleStyle),
        content: content != null ? Text(content, style: effectiveStyle.contentStyle) : null,
        backgroundColor: effectiveStyle.backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: effectiveStyle.borderRadius),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(cancelText, style: effectiveStyle.cancelButtonStyle)),
          TextButton(onPressed: () => Navigator.of(context).pop(true), child: Text(confirmText, style: effectiveStyle.confirmButtonStyle)),
        ],
      ),
    );
  }

  /// 显示提示对话框
  static Future<void> alert(
    BuildContext context, {
    required String title,
    String? content,
    String confirmText = '确定',
    VelocityDialogStyle? style,
  }) async {
    final effectiveStyle = style ?? const VelocityDialogStyle();
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: effectiveStyle.titleStyle),
        content: content != null ? Text(content, style: effectiveStyle.contentStyle) : null,
        backgroundColor: effectiveStyle.backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: effectiveStyle.borderRadius),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(confirmText, style: effectiveStyle.confirmButtonStyle)),
        ],
      ),
    );
  }
}
