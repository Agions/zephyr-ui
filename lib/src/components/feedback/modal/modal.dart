import 'package:flutter/material.dart';

import 'package:zephyr_ui/zephyr_ui.dart';

/// 模态框尺寸
enum ZephyrModalSize {
  /// 小尺寸
  small,

  /// 中等尺寸
  medium,

  /// 大尺寸
  large,

  /// 全屏
  fullscreen,
}

/// ZephyrUI 模态框组件
///
/// 一个功能丰富的模态框组件，支持多种尺寸、自定义内容和操作按钮。
///
/// 示例用法:
/// ```dart
/// ZephyrModal.show(
///   context: context,
///   title: '确认删除',
///   content: '确定要删除这个项目吗？此操作不可撤销。',
///   actions: [
///     ZephyrModalAction(
///       text: '取消',
///       onPressed: () => Navigator.of(context).pop(),
///     ),
///     ZephyrModalAction(
///       text: '删除',
///       variant: ZephyrVariant.error,
///       onPressed: () {
///         // 执行删除操作
///         Navigator.of(context).pop();
///       },
///     ),
///   ],
/// )
/// ```
class ZephyrModal extends StatelessWidget {
  /// 创建一个模态框组件
  const ZephyrModal({
    Key? key,
    this.title,
    this.content,
    this.child,
    this.actions,
    this.size = ZephyrModalSize.medium,
    this.dismissible = true,
    this.showCloseButton = true,
    this.onClose,
    this.theme,
  }) : super(key: key);

  /// 标题
  final String? title;

  /// 内容文本
  final String? content;

  /// 自定义内容组件
  final Widget? child;

  /// 操作按钮列表
  final List<ZephyrModalAction>? actions;

  /// 模态框尺寸
  final ZephyrModalSize size;

  /// 是否可以通过点击遮罩层关闭
  final bool dismissible;

  /// 是否显示关闭按钮
  final bool showCloseButton;

  /// 关闭回调
  final VoidCallback? onClose;

  /// 自定义主题
  final ZephyrModalTheme? theme;

  /// 显示模态框
  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    String? content,
    Widget? child,
    List<ZephyrModalAction>? actions,
    ZephyrModalSize size = ZephyrModalSize.medium,
    bool dismissible = true,
    bool showCloseButton = true,
    VoidCallback? onClose,
    ZephyrModalTheme? theme,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: dismissible,
      builder: (context) => ZephyrModal(
        title: title,
        content: content,
        actions: actions,
        size: size,
        dismissible: dismissible,
        showCloseButton: showCloseButton,
        onClose: onClose,
        theme: theme,
        child: child,
      ),
    );
  }

  /// 显示确认对话框
  static Future<bool?> showConfirm({
    required BuildContext context,
    required String title,
    required String content,
    String confirmText = '确认',
    String cancelText = '取消',
    ZephyrVariant confirmVariant = ZephyrVariant.primary,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    ZephyrModalTheme? theme,
  }) {
    return show<bool>(
      context: context,
      title: title,
      content: content,
      theme: theme,
      actions: [
        ZephyrModalAction(
          text: cancelText,
          variant: ZephyrVariant.outline,
          onPressed: () {
            onCancel?.call();
            Navigator.of(context).pop(false);
          },
        ),
        ZephyrModalAction(
          text: confirmText,
          variant: confirmVariant,
          onPressed: () {
            onConfirm?.call();
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }

  /// 显示警告对话框
  static Future<void> showAlert({
    required BuildContext context,
    required String title,
    required String content,
    String buttonText = '确定',
    VoidCallback? onPressed,
    ZephyrModalTheme? theme,
  }) {
    return show<void>(
      context: context,
      title: title,
      content: content,
      theme: theme,
      actions: [
        ZephyrModalAction(
          text: buttonText,
          variant: ZephyrVariant.primary,
          onPressed: () {
            onPressed?.call();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? ZephyrModalTheme.of(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: theme.margin as EdgeInsets,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: _getMaxWidth(theme),
          maxHeight: _getMaxHeight(theme),
        ),
        decoration: BoxDecoration(
          color: theme.backgroundColor,
          borderRadius: theme.borderRadius,
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor,
              blurRadius: theme.elevation,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title != null || showCloseButton) _buildHeader(context, theme),
            Flexible(child: _buildContent(theme)),
            if (actions != null && actions!.isNotEmpty) _buildActions(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ZephyrModalTheme theme) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        theme.padding.horizontal / 2,
        theme.padding.vertical / 2,
        showCloseButton ? 8.0 : theme.padding.horizontal / 2,
        0,
      ),
      child: Row(
        children: [
          if (title != null)
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: theme.padding.horizontal / 2,
                  top: theme.padding.vertical / 2,
                ),
                child: Text(
                  title!,
                  style: theme.titleTextStyle,
                ),
              ),
            ),
          if (showCloseButton)
            IconButton(
              onPressed: () {
                onClose?.call();
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
              iconSize: 20,
              padding: const EdgeInsets.all(8),
              constraints: const BoxConstraints(
                minWidth: 36,
                minHeight: 36,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContent(ZephyrModalTheme theme) {
    return Container(
      padding: theme.padding,
      child: child ??
          (content != null
              ? Text(
                  content!,
                  style: theme.contentTextStyle,
                )
              : const SizedBox.shrink()),
    );
  }

  Widget _buildActions(ZephyrModalTheme theme) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        theme.padding.horizontal / 2,
        0,
        theme.padding.horizontal / 2,
        theme.padding.vertical / 2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: actions!
            .map((action) => Padding(
                  padding: EdgeInsets.only(left: theme.actionSpacing),
                  child: action,
                ))
            .toList(),
      ),
    );
  }

  double _getMaxWidth(ZephyrModalTheme theme) {
    switch (size) {
      case ZephyrModalSize.small:
        return 400.0;
      case ZephyrModalSize.medium:
        return theme.maxWidth;
      case ZephyrModalSize.large:
        return 800.0;
      case ZephyrModalSize.fullscreen:
        return double.infinity;
    }
  }

  double _getMaxHeight(ZephyrModalTheme theme) {
    switch (size) {
      case ZephyrModalSize.fullscreen:
        return double.infinity;
      default:
        return theme.maxHeight;
    }
  }
}

/// 模态框操作按钮
class ZephyrModalAction extends StatelessWidget {
  /// 创建一个模态框操作按钮
  const ZephyrModalAction({
    Key? key,
    required this.text,
    required this.onPressed,
    this.variant = ZephyrVariant.primary,
    this.size = ZephyrSize.md,
    this.icon,
  }) : super(key: key);

  /// 按钮文本
  final String text;

  /// 点击回调
  final VoidCallback onPressed;

  /// 按钮变体
  final ZephyrVariant variant;

  /// 按钮尺寸
  final ZephyrSize size;

  /// 按钮图标
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    // 这里应该使用 ZephyrButton，但为了避免循环依赖，暂时使用 ElevatedButton
    // 在实际项目中，应该重构为使用统一的按钮组件
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon != null ? Icon(icon, size: 16) : const SizedBox.shrink(),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}
