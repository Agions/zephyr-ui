/// ZephyrUI 通知提醒组件
///
/// 提供通知提醒功能。
library notification;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI 通知提醒组件
///
/// 用于显示通知提醒，通常出现在页面右上角。
///
/// 示例用法:
/// ```dart
/// ZephyrNotification.success(
///   title: '成功',
///   message: '操作已成功完成',
///   duration: Duration(seconds: 4),
/// )
/// ```
class ZephyrNotification extends StatefulWidget {
  /// 创建一个通知提醒组件
  const ZephyrNotification({
    required this.title,
    super.key,
    this.message,
    this.type = ZephyrVariant.info,
    this.duration = const Duration(seconds: 4),
    this.onClose,
    this.closable = true,
    this.icon,
    this.avatar,
    this.actions,
    this.theme,
    this.position = ZephyrNotificationPosition.topRight,
  });

  /// 创建成功通知
  const ZephyrNotification.success({
    required this.title,
    super.key,
    this.message,
    this.duration = const Duration(seconds: 4),
    this.onClose,
    this.closable = true,
    this.icon,
    this.avatar,
    this.actions,
    this.theme,
    this.position = ZephyrNotificationPosition.topRight,
  }) : type = ZephyrVariant.success;

  /// 创建错误通知
  const ZephyrNotification.error({
    required this.title,
    super.key,
    this.message,
    this.duration = const Duration(seconds: 6),
    this.onClose,
    this.closable = true,
    this.icon,
    this.avatar,
    this.actions,
    this.theme,
    this.position = ZephyrNotificationPosition.topRight,
  }) : type = ZephyrVariant.error;

  /// 创建警告通知
  const ZephyrNotification.warning({
    required this.title,
    super.key,
    this.message,
    this.duration = const Duration(seconds: 4),
    this.onClose,
    this.closable = true,
    this.icon,
    this.avatar,
    this.actions,
    this.theme,
    this.position = ZephyrNotificationPosition.topRight,
  }) : type = ZephyrVariant.warning;

  /// 创建信息通知
  const ZephyrNotification.info({
    required this.title,
    super.key,
    this.message,
    this.duration = const Duration(seconds: 4),
    this.onClose,
    this.closable = true,
    this.icon,
    this.avatar,
    this.actions,
    this.theme,
    this.position = ZephyrNotificationPosition.topRight,
  }) : type = ZephyrVariant.info;

  /// 通知标题
  final String title;

  /// 通知内容
  final String? message;

  /// 通知类型
  final ZephyrVariant type;

  /// 显示时长
  final Duration duration;

  /// 关闭回调
  final VoidCallback? onClose;

  /// 是否可关闭
  final bool closable;

  /// 自定义图标
  final Widget? icon;

  /// 头像
  final Widget? avatar;

  /// 操作按钮
  final List<Widget>? actions;

  /// 自定义主题
  final ZephyrNotificationTheme? theme;

  /// 显示位置
  final ZephyrNotificationPosition position;

  /// 显示通知
  static void show(
    BuildContext context, {
    required String title,
    String? message,
    ZephyrVariant type = ZephyrVariant.info,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onClose,
    bool closable = true,
    Widget? icon,
    Widget? avatar,
    List<Widget>? actions,
    ZephyrNotificationTheme? theme,
    ZephyrNotificationPosition position = ZephyrNotificationPosition.topRight,
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => ZephyrNotification(
        title: title,
        message: message,
        type: type,
        duration: duration,
        onClose: onClose,
        closable: closable,
        icon: icon,
        avatar: avatar,
        actions: actions,
        theme: theme,
        position: position,
      ),
    );
    overlay.insert(overlayEntry);

    // 自动关闭
    Future.delayed(duration, () {
      overlayEntry.remove();
      onClose?.call();
    });
  }

  @override
  State<ZephyrNotification> createState() => _ZephyrNotificationState();
}

class _ZephyrNotificationState extends State<ZephyrNotification>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme =
        widget.theme ?? ZephyrNotificationTheme.fromTheme(Theme.of(context));

    return Positioned(
      top: widget.position == ZephyrNotificationPosition.topRight ||
              widget.position == ZephyrNotificationPosition.topLeft
          ? 20.0
          : null,
      bottom: widget.position == ZephyrNotificationPosition.bottomRight ||
              widget.position == ZephyrNotificationPosition.bottomLeft
          ? 20.0
          : null,
      left: widget.position == ZephyrNotificationPosition.topLeft ||
              widget.position == ZephyrNotificationPosition.bottomLeft
          ? 20.0
          : null,
      right: widget.position == ZephyrNotificationPosition.topRight ||
              widget.position == ZephyrNotificationPosition.bottomRight
          ? 20.0
          : null,
      child: FadeTransition(
        opacity: _animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: widget.position == ZephyrNotificationPosition.topRight ||
                    widget.position == ZephyrNotificationPosition.topLeft
                ? const Offset(1, -1)
                : const Offset(1, 1),
            end: Offset.zero,
          ).animate(_animation),
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 320,
              padding: theme.padding,
              decoration: BoxDecoration(
                color: theme.backgroundColor,
                borderRadius: theme.borderRadius,
                border: theme.border,
                boxShadow: theme.boxShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.avatar != null) ...[
                        widget.avatar!,
                        const SizedBox(width: 12),
                      ],
                      if (widget.icon != null) ...[
                        widget.icon!,
                        const SizedBox(width: 12),
                      ] else
                        _buildTypeIcon(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: theme.titleStyle,
                            ),
                            if (widget.message != null) ...[
                              const SizedBox(height: 4),
                              Text(
                                widget.message!,
                                style: theme.messageStyle,
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (widget.closable) ...[
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            widget.onClose?.call();
                            if (mounted) {
                              Navigator.of(context).pop();
                            }
                          },
                          child: Icon(
                            Icons.close,
                            color: theme.closeIconColor,
                            size: 16,
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (widget.actions != null) ...[
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: widget.actions!,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypeIcon() {
    final theme =
        widget.theme ?? ZephyrNotificationTheme.fromTheme(Theme.of(context));
    IconData iconData;
    Color iconColor;

    switch (widget.type) {
      case ZephyrVariant.success:
        iconData = Icons.check_circle;
        iconColor = theme.successIconColor;
        break;
      case ZephyrVariant.error:
        iconData = Icons.error;
        iconColor = theme.errorIconColor;
        break;
      case ZephyrVariant.warning:
        iconData = Icons.warning;
        iconColor = theme.warningIconColor;
        break;
      case ZephyrVariant.info:
        iconData = Icons.info;
        iconColor = theme.infoIconColor;
        break;
      default:
        iconData = Icons.info;
        iconColor = theme.infoIconColor;
    }

    return Icon(
      iconData,
      color: iconColor,
      size: 20,
    );
  }
}
