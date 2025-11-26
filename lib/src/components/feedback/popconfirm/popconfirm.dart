/// ZephyrUI 气泡确认框组件
///
/// 提供气泡确认框功能。
library popconfirm;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI 气泡确认框组件
///
/// 用于在点击元素时显示一个确认气泡，通常用于需要用户确认的操作。
///
/// 示例用法:
/// ```dart
/// ZephyrPopconfirm(
///   title: '确认删除？',
///   message: '此操作不可恢复',
///   onConfirm: () {
///     // 确认操作
///   },
///   child: ZephyrButton(
///     text: '删除',
///     variant: ZephyrVariant.error,
///   ),
/// )
/// ```
class ZephyrPopconfirm extends StatefulWidget {
  /// 创建一个气泡确认框组件
  const ZephyrPopconfirm({
    required this.child,
    required this.title,
    super.key,
    this.message,
    this.onConfirm,
    this.onCancel,
    this.confirmText = '确认',
    this.cancelText = '取消',
    this.confirmVariant = ZephyrVariant.primary,
    this.cancelVariant = ZephyrVariant.neutral,
    this.icon,
    this.theme,
    this.placement = ZephyrPopconfirmPlacement.top,
    this.triggerMode = ZephyrPopconfirmTriggerMode.click,
    this.disabled = false,
  });

  /// 子组件
  final Widget child;

  /// 标题
  final String title;

  /// 消息内容
  final String? message;

  /// 确认回调
  final VoidCallback? onConfirm;

  /// 取消回调
  final VoidCallback? onCancel;

  /// 确认按钮文本
  final String confirmText;

  /// 取消按钮文本
  final String cancelText;

  /// 确认按钮变体
  final ZephyrVariant confirmVariant;

  /// 取消按钮变体
  final ZephyrVariant cancelVariant;

  /// 自定义图标
  final Widget? icon;

  /// 自定义主题
  final ZephyrPopconfirmTheme? theme;

  /// 弹出位置
  final ZephyrPopconfirmPlacement placement;

  /// 触发模式
  final ZephyrPopconfirmTriggerMode triggerMode;

  /// 是否禁用
  final bool disabled;

  @override
  State<ZephyrPopconfirm> createState() => _ZephyrPopconfirmState();
}

class _ZephyrPopconfirmState extends State<ZephyrPopconfirm> {
  final OverlayPortalController _overlayController = OverlayPortalController();
  final LayerLink _layerLink = LayerLink();

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: OverlayPortal(
        controller: _overlayController,
        overlayChildBuilder: (context) => _buildOverlay(),
        child: GestureDetector(
          onTap: widget.disabled
              ? null
              : widget.triggerMode == ZephyrPopconfirmTriggerMode.click
                  ? _toggleOverlay
                  : null,
          onLongPress: widget.disabled
              ? null
              : widget.triggerMode == ZephyrPopconfirmTriggerMode.longPress
                  ? _toggleOverlay
                  : null,
          child: widget.child,
        ),
      ),
    );
  }

  Widget _buildOverlay() {
    final theme =
        widget.theme ?? ZephyrPopconfirmTheme.fromTheme(Theme.of(context));

    return Positioned.fill(
      child: GestureDetector(
        onTap: _hideOverlay,
        child: Container(
          color: Colors.transparent,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: _getOffset(),
            child: TapRegion(
              onTapOutside: (_) => _hideOverlay(),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  constraints: const BoxConstraints(
                    minWidth: 200,
                    maxWidth: 320,
                  ),
                  margin: theme.margin,
                  padding: theme.padding,
                  decoration: BoxDecoration(
                    color: theme.backgroundColor,
                    borderRadius: theme.borderRadius,
                    border: theme.border,
                    boxShadow: theme.boxShadow,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          if (widget.icon != null) ...[
                            widget.icon!,
                            const SizedBox(width: 8),
                          ] else
                            Icon(
                              Icons.help_outline,
                              color: theme.iconColor,
                              size: 16,
                            ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              widget.title,
                              style: theme.titleStyle,
                            ),
                          ),
                        ],
                      ),
                      if (widget.message != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          widget.message!,
                          style: theme.messageStyle,
                        ),
                      ],
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              _hideOverlay();
                              widget.onCancel?.call();
                            },
                            child: Text(widget.cancelText),
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            onPressed: () {
                              _hideOverlay();
                              widget.onConfirm?.call();
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: _getConfirmButtonColor(),
                              foregroundColor: Colors.white,
                            ),
                            child: Text(widget.confirmText),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getConfirmButtonColor() {
    final theme =
        widget.theme ?? ZephyrPopconfirmTheme.fromTheme(Theme.of(context));

    switch (widget.confirmVariant) {
      case ZephyrVariant.primary:
        return theme.primaryColor;
      case ZephyrVariant.success:
        return theme.successColor;
      case ZephyrVariant.warning:
        return theme.warningColor;
      case ZephyrVariant.error:
        return theme.errorColor;
      case ZephyrVariant.info:
        return theme.infoColor;
      default:
        return theme.primaryColor;
    }
  }

  Offset _getOffset() {
    switch (widget.placement) {
      case ZephyrPopconfirmPlacement.top:
        return const Offset(0, -60);
      case ZephyrPopconfirmPlacement.bottom:
        return const Offset(0, 60);
      case ZephyrPopconfirmPlacement.left:
        return const Offset(-200, 0);
      case ZephyrPopconfirmPlacement.right:
        return const Offset(200, 0);
      case ZephyrPopconfirmPlacement.topLeft:
        return const Offset(-100, -60);
      case ZephyrPopconfirmPlacement.topRight:
        return const Offset(100, -60);
      case ZephyrPopconfirmPlacement.bottomLeft:
        return const Offset(-100, 60);
      case ZephyrPopconfirmPlacement.bottomRight:
        return const Offset(100, 60);
      default:
        return const Offset(0, -60);
    }
  }

  void _toggleOverlay() {
    if (_overlayController.isShowing) {
      _hideOverlay();
    } else {
      _showOverlay();
    }
  }

  void _showOverlay() {
    _overlayController.show();
  }

  void _hideOverlay() {
    _overlayController.hide();
  }
}
