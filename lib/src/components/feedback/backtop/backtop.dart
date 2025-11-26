/// ZephyrUI 返回顶部组件
///
/// 提供返回页面顶部功能。
library backtop;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI 返回顶部组件
///
/// 用于在页面滚动到一定位置时显示返回顶部按钮。
///
/// 示例用法:
/// ```dart
/// ZephyrBackTop(
///   targetHeight: 400,
///   duration: Duration(milliseconds: 500),
///   child: Container(
///     width: 40,
///     height: 40,
///     child: Icon(Icons.arrow_upward),
///   ),
/// )
/// ```
class ZephyrBackTop extends StatefulWidget {
  /// 创建一个返回顶部组件
  const ZephyrBackTop({
    super.key,
    this.targetHeight = 400,
    this.duration = const Duration(milliseconds: 500),
    this.child,
    this.theme,
    this.visible = false,
    this.onClick,
    this.scrollController,
    this.right = 24,
    this.bottom = 24,
  });

  /// 触发显示的滚动高度
  final double targetHeight;

  /// 滚动动画时长
  final Duration duration;

  /// 自定义子组件
  final Widget? child;

  /// 自定义主题
  final ZephyrBackTopTheme? theme;

  /// 是否可见
  final bool visible;

  /// 点击回调
  final VoidCallback? onClick;

  /// 滚动控制器
  final ScrollController? scrollController;

  /// 距离右边的距离
  final double right;

  /// 距离底部的距离
  final double bottom;

  @override
  State<ZephyrBackTop> createState() => _ZephyrBackTopState();
}

class _ZephyrBackTopState extends State<ZephyrBackTop> {
  bool _isVisible = false;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(_scrollListener);
    _updateVisibility();
  }

  @override
  void didUpdateWidget(ZephyrBackTop oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.scrollController != oldWidget.scrollController) {
      oldWidget.scrollController?.removeListener(_scrollListener);
      _scrollController = widget.scrollController ?? ScrollController();
      _scrollController.addListener(_scrollListener);
    }
    if (widget.visible != oldWidget.visible) {
      _updateVisibility();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    if (widget.scrollController == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.hasClients) {
      final offset = _scrollController.offset;
      final shouldBeVisible = offset > widget.targetHeight;

      if (shouldBeVisible != _isVisible) {
        setState(() {
          _isVisible = shouldBeVisible;
        });
      }
    }
  }

  void _updateVisibility() {
    if (widget.visible) {
      setState(() {
        _isVisible = true;
      });
    }
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: widget.duration,
        curve: Curves.easeInOut,
      );
    }
    widget.onClick?.call();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) {
      return const SizedBox.shrink();
    }

    final theme =
        widget.theme ?? ZephyrBackTopTheme.fromTheme(Theme.of(context));

    return Positioned(
      right: widget.right,
      bottom: widget.bottom,
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: GestureDetector(
          onTap: _scrollToTop,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: theme.backgroundColor,
              borderRadius: theme.borderRadius,
              boxShadow: theme.boxShadow,
            ),
            child: widget.child ?? _buildDefaultChild(theme),
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultChild(ZephyrBackTopTheme theme) {
    return Icon(
      Icons.arrow_upward,
      color: theme.iconColor,
      size: 20,
    );
  }
}

/// ZephyrUI 返回顶部包装器
///
/// 用于包装需要返回顶部功能的可滚动组件。
class ZephyrBackTopWrapper extends StatefulWidget {
  /// 创建一个返回顶部包装器
  const ZephyrBackTopWrapper({
    required this.child,
    super.key,
    this.targetHeight = 400,
    this.duration = const Duration(milliseconds: 500),
    this.backTopChild,
    this.theme,
    this.right = 24,
    this.bottom = 24,
    this.onBackTopClick,
  });

  /// 子组件
  final Widget child;

  /// 触发显示的滚动高度
  final double targetHeight;

  /// 滚动动画时长
  final Duration duration;

  /// 返回顶部按钮子组件
  final Widget? backTopChild;

  /// 自定义主题
  final ZephyrBackTopTheme? theme;

  /// 距离右边的距离
  final double right;

  /// 距离底部的距离
  final double bottom;

  /// 返回顶部点击回调
  final VoidCallback? onBackTopClick;

  @override
  State<ZephyrBackTopWrapper> createState() => _ZephyrBackTopWrapperState();
}

class _ZephyrBackTopWrapperState extends State<ZephyrBackTopWrapper> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            // 可以在这里处理滚动通知
            return false;
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            child: widget.child,
          ),
        ),
        ZephyrBackTop(
          targetHeight: widget.targetHeight,
          duration: widget.duration,
          theme: widget.theme,
          scrollController: _scrollController,
          right: widget.right,
          bottom: widget.bottom,
          onClick: widget.onBackTopClick,
          child: widget.backTopChild,
        ),
      ],
    );
  }
}
