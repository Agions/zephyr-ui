/// ZephyrUI 全局提示组件
///
/// 提供全局的消息提示功能。
library message;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI 全局提示组件
///
/// 用于显示全局的消息提示，如成功、错误、警告、信息等。
///
/// 示例用法:
/// ```dart
/// ZephyrMessage.success(
///   content: '操作成功',
///   duration: Duration(seconds: 3),
/// )
/// ```
class ZephyrMessage extends StatefulWidget {
  /// 创建一个全局提示组件
  const ZephyrMessage({
    required this.content,
    super.key,
    this.type = ZephyrVariant.info,
    this.duration = const Duration(seconds: 3),
    this.onClose,
    this.closable = false,
    this.icon,
    this.theme,
    this.position = ZephyrMessagePosition.top,
  });

  /// 创建成功提示
  const ZephyrMessage.success({
    required this.content,
    super.key,
    this.duration = const Duration(seconds: 3),
    this.onClose,
    this.closable = false,
    this.icon,
    this.theme,
    this.position = ZephyrMessagePosition.top,
  }) : type = ZephyrVariant.success;

  /// 创建错误提示
  const ZephyrMessage.error({
    required this.content,
    super.key,
    this.duration = const Duration(seconds: 4),
    this.onClose,
    this.closable = true,
    this.icon,
    this.theme,
    this.position = ZephyrMessagePosition.top,
  }) : type = ZephyrVariant.error;

  /// 创建警告提示
  const ZephyrMessage.warning({
    required this.content,
    super.key,
    this.duration = const Duration(seconds: 3),
    this.onClose,
    this.closable = true,
    this.icon,
    this.theme,
    this.position = ZephyrMessagePosition.top,
  }) : type = ZephyrVariant.warning;

  /// 创建信息提示
  const ZephyrMessage.info({
    required this.content,
    super.key,
    this.duration = const Duration(seconds: 3),
    this.onClose,
    this.closable = false,
    this.icon,
    this.theme,
    this.position = ZephyrMessagePosition.top,
  }) : type = ZephyrVariant.info;

  /// 消息内容
  final String content;

  /// 消息类型
  final ZephyrVariant type;

  /// 显示时长
  final Duration duration;

  /// 关闭回调
  final VoidCallback? onClose;

  /// 是否可关闭
  final bool closable;

  /// 自定义图标
  final Widget? icon;

  /// 自定义主题
  final ZephyrMessageTheme? theme;

  /// 显示位置
  final ZephyrMessagePosition position;

  /// 显示全局提示
  static void show(
    BuildContext context, {
    required String content,
    ZephyrVariant type = ZephyrVariant.info,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onClose,
    bool closable = false,
    Widget? icon,
    ZephyrMessageTheme? theme,
    ZephyrMessagePosition position = ZephyrMessagePosition.top,
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => ZephyrMessage(
        content: content,
        type: type,
        duration: duration,
        onClose: onClose,
        closable: closable,
        icon: icon,
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
  State<ZephyrMessage> createState() => _ZephyrMessageState();
}

class _ZephyrMessageState extends State<ZephyrMessage>
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
        widget.theme ?? ZephyrMessageTheme.fromTheme(Theme.of(context));

    return Positioned(
      top: widget.position == ZephyrMessagePosition.top ? 20.0 : null,
      bottom: widget.position == ZephyrMessagePosition.bottom ? 20.0 : null,
      left: 20.0,
      right: 20.0,
      child: FadeTransition(
        opacity: _animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: widget.position == ZephyrMessagePosition.top
                ? const Offset(0, -1)
                : const Offset(0, 1),
            end: Offset.zero,
          ).animate(_animation),
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: theme.padding,
              decoration: BoxDecoration(
                color: theme.backgroundColor,
                borderRadius: theme.borderRadius,
                border: theme.border,
                boxShadow: theme.boxShadow,
              ),
              child: Row(
                children: [
                  _buildIcon(),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.content,
                      style: theme.contentStyle,
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
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (widget.icon != null) {
      return widget.icon!;
    }

    final theme =
        widget.theme ?? ZephyrMessageTheme.fromTheme(Theme.of(context));
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
      size: 16,
    );
  }
}
