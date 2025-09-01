import 'package:flutter/material.dart';

import 'toast_theme.dart';

/// 提示框类型
enum ZephyrToastType {
  /// 默认提示
  normal,

  /// 成功提示
  success,

  /// 警告提示
  warning,

  /// 错误提示
  error,

  /// 信息提示
  info,
}

/// 提示框位置
enum ZephyrToastPosition {
  /// 顶部
  top,

  /// 顶部居中
  topCenter,

  /// 底部
  bottom,

  /// 底部居中
  bottomCenter,

  /// 中心
  center,
}

/// ZephyrUI 提示框组件
///
/// 一个轻量级的消息提示组件，用于显示操作反馈、系统消息等。
///
/// 示例用法:
/// ```dart
/// // 显示成功提示
/// ZephyrToast.success(
///   context: context,
///   message: '操作成功！',
/// );
///
/// // 显示错误提示
/// ZephyrToast.error(
///   context: context,
///   message: '操作失败，请重试',
///   duration: Duration(seconds: 5),
/// );
/// ```
class ZephyrToast {
  ZephyrToast._();

  /// 显示提示框
  static void show({
    required BuildContext context,
    required String message,
    ZephyrToastType type = ZephyrToastType.normal,
    ZephyrToastPosition position = ZephyrToastPosition.bottomCenter,
    Duration duration = const Duration(seconds: 3),
    Widget? icon,
    bool showCloseButton = false,
    VoidCallback? onClose,
    ZephyrToastTheme? theme,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _ZephyrToastWidget(
        message: message,
        type: type,
        position: position,
        icon: icon,
        showCloseButton: showCloseButton,
        onClose: () {
          onClose?.call();
          overlayEntry.remove();
        },
        theme: theme,
      ),
    );

    overlay.insert(overlayEntry);

    // 自动移除
    Future.delayed(duration, () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }

  /// 显示成功提示
  static void success({
    required BuildContext context,
    required String message,
    ZephyrToastPosition position = ZephyrToastPosition.bottomCenter,
    Duration duration = const Duration(seconds: 3),
    Widget? icon,
    bool showCloseButton = false,
    VoidCallback? onClose,
    ZephyrToastTheme? theme,
  }) {
    show(
      context: context,
      message: message,
      type: ZephyrToastType.success,
      position: position,
      duration: duration,
      icon: icon,
      showCloseButton: showCloseButton,
      onClose: onClose,
      theme: theme,
    );
  }

  /// 显示警告提示
  static void warning({
    required BuildContext context,
    required String message,
    ZephyrToastPosition position = ZephyrToastPosition.bottomCenter,
    Duration duration = const Duration(seconds: 4),
    Widget? icon,
    bool showCloseButton = false,
    VoidCallback? onClose,
    ZephyrToastTheme? theme,
  }) {
    show(
      context: context,
      message: message,
      type: ZephyrToastType.warning,
      position: position,
      duration: duration,
      icon: icon,
      showCloseButton: showCloseButton,
      onClose: onClose,
      theme: theme,
    );
  }

  /// 显示错误提示
  static void error({
    required BuildContext context,
    required String message,
    ZephyrToastPosition position = ZephyrToastPosition.bottomCenter,
    Duration duration = const Duration(seconds: 5),
    Widget? icon,
    bool showCloseButton = true,
    VoidCallback? onClose,
    ZephyrToastTheme? theme,
  }) {
    show(
      context: context,
      message: message,
      type: ZephyrToastType.error,
      position: position,
      duration: duration,
      icon: icon,
      showCloseButton: showCloseButton,
      onClose: onClose,
      theme: theme,
    );
  }

  /// 显示信息提示
  static void info({
    required BuildContext context,
    required String message,
    ZephyrToastPosition position = ZephyrToastPosition.bottomCenter,
    Duration duration = const Duration(seconds: 3),
    Widget? icon,
    bool showCloseButton = false,
    VoidCallback? onClose,
    ZephyrToastTheme? theme,
  }) {
    show(
      context: context,
      message: message,
      type: ZephyrToastType.info,
      position: position,
      duration: duration,
      icon: icon,
      showCloseButton: showCloseButton,
      onClose: onClose,
      theme: theme,
    );
  }
}

/// 提示框组件实现
class _ZephyrToastWidget extends StatefulWidget {
  const _ZephyrToastWidget({
    required this.message,
    required this.type,
    required this.position,
    required this.onClose,
    this.icon,
    this.showCloseButton = false,
    this.theme,
  });

  final String message;
  final ZephyrToastType type;
  final ZephyrToastPosition position;
  final Widget? icon;
  final bool showCloseButton;
  final VoidCallback onClose;
  final ZephyrToastTheme? theme;

  @override
  State<_ZephyrToastWidget> createState() => _ZephyrToastWidgetState();
}

class _ZephyrToastWidgetState extends State<_ZephyrToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: _getInitialOffset(),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Offset _getInitialOffset() {
    switch (widget.position) {
      case ZephyrToastPosition.top:
      case ZephyrToastPosition.topCenter:
        return const Offset(0, -1);
      case ZephyrToastPosition.bottom:
      case ZephyrToastPosition.bottomCenter:
        return const Offset(0, 1);
      case ZephyrToastPosition.center:
        return const Offset(0, 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? ZephyrToastTheme.of(context);

    return Positioned.fill(
      child: IgnorePointer(
        ignoring: false,
        child: Container(
          alignment: _getAlignment(),
          padding: theme.margin,
          child: SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: theme.maxWidth,
                  ),
                  decoration: BoxDecoration(
                    color: _getBackgroundColor(theme),
                    borderRadius: theme.borderRadius,
                    boxShadow: [
                      BoxShadow(
                        color: theme.shadowColor,
                        blurRadius: theme.elevation,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: theme.padding,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.icon != null || _hasDefaultIcon()) ...[
                        _buildIcon(theme),
                        SizedBox(width: theme.spacing),
                      ],
                      Flexible(
                        child: Text(
                          widget.message,
                          style: theme.textStyle.copyWith(
                            color: _getTextColor(theme),
                          ),
                        ),
                      ),
                      if (widget.showCloseButton) ...[
                        SizedBox(width: theme.spacing),
                        GestureDetector(
                          onTap: widget.onClose,
                          child: Icon(
                            Icons.close,
                            size: 16,
                            color: _getIconColor(theme),
                          ),
                        ),
                      ],
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

  Alignment _getAlignment() {
    switch (widget.position) {
      case ZephyrToastPosition.top:
        return Alignment.topLeft;
      case ZephyrToastPosition.topCenter:
        return Alignment.topCenter;
      case ZephyrToastPosition.bottom:
        return Alignment.bottomLeft;
      case ZephyrToastPosition.bottomCenter:
        return Alignment.bottomCenter;
      case ZephyrToastPosition.center:
        return Alignment.center;
    }
  }

  bool _hasDefaultIcon() {
    return widget.type != ZephyrToastType.normal;
  }

  Widget _buildIcon(ZephyrToastTheme theme) {
    if (widget.icon != null) {
      return widget.icon!;
    }

    IconData iconData;
    switch (widget.type) {
      case ZephyrToastType.success:
        iconData = Icons.check_circle;
        break;
      case ZephyrToastType.warning:
        iconData = Icons.warning;
        break;
      case ZephyrToastType.error:
        iconData = Icons.error;
        break;
      case ZephyrToastType.info:
        iconData = Icons.info;
        break;
      case ZephyrToastType.normal:
        iconData = Icons.notifications;
        break;
    }

    return Icon(
      iconData,
      size: theme.iconSize,
      color: _getIconColor(theme),
    );
  }

  Color _getBackgroundColor(ZephyrToastTheme theme) {
    switch (widget.type) {
      case ZephyrToastType.success:
        return theme.successBackgroundColor;
      case ZephyrToastType.warning:
        return theme.warningBackgroundColor;
      case ZephyrToastType.error:
        return theme.errorBackgroundColor;
      case ZephyrToastType.info:
        return theme.infoBackgroundColor;
      case ZephyrToastType.normal:
        return theme.backgroundColor;
    }
  }

  Color _getTextColor(ZephyrToastTheme theme) {
    switch (widget.type) {
      case ZephyrToastType.success:
        return theme.successTextColor;
      case ZephyrToastType.warning:
        return theme.warningTextColor;
      case ZephyrToastType.error:
        return theme.errorTextColor;
      case ZephyrToastType.info:
        return theme.infoTextColor;
      case ZephyrToastType.normal:
        return theme.textColor;
    }
  }

  Color _getIconColor(ZephyrToastTheme theme) {
    switch (widget.type) {
      case ZephyrToastType.success:
        return theme.successIconColor;
      case ZephyrToastType.warning:
        return theme.warningIconColor;
      case ZephyrToastType.error:
        return theme.errorIconColor;
      case ZephyrToastType.info:
        return theme.infoIconColor;
      case ZephyrToastType.normal:
        return theme.iconColor;
    }
  }
}
