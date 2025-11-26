/// ZephyrUI 加载中组件
///
/// 提供加载中状态显示功能。
library spin;

import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// ZephyrUI 加载中组件
///
/// 用于显示加载中状态，可以是全屏遮罩或局部加载指示器。
///
/// 示例用法:
/// ```dart
/// ZephyrSpin(
///   spinning: true,
///   size: ZephyrSpinSize.medium,
///   tip: '加载中...',
///   child: Container(
///     width: 200,
///     height: 200,
///     child: Text('内容'),
///   ),
/// )
/// ```
class ZephyrSpin extends StatefulWidget {
  /// 创建一个加载中组件
  const ZephyrSpin({
    super.key,
    this.spinning = true,
    this.size = ZephyrSpinSize.medium,
    this.tip,
    this.delay = const Duration(milliseconds: 0),
    this.indicator,
    this.theme,
    this.child,
    this.fullscreen = false,
  });

  /// 创建小尺寸加载中组件
  const ZephyrSpin.small({
    super.key,
    this.spinning = true,
    this.tip,
    this.delay = const Duration(milliseconds: 0),
    this.indicator,
    this.theme,
    this.child,
    this.fullscreen = false,
  }) : size = ZephyrSpinSize.small;

  /// 创建中等尺寸加载中组件
  const ZephyrSpin.medium({
    super.key,
    this.spinning = true,
    this.tip,
    this.delay = const Duration(milliseconds: 0),
    this.indicator,
    this.theme,
    this.child,
    this.fullscreen = false,
  }) : size = ZephyrSpinSize.medium;

  /// 创建大尺寸加载中组件
  const ZephyrSpin.large({
    super.key,
    this.spinning = true,
    this.tip,
    this.delay = const Duration(milliseconds: 0),
    this.indicator,
    this.theme,
    this.child,
    this.fullscreen = false,
  }) : size = ZephyrSpinSize.large;

  /// 是否显示加载状态
  final bool spinning;

  /// 加载指示器尺寸
  final ZephyrSpinSize size;

  /// 加载提示文本
  final String? tip;

  /// 延迟显示时间
  final Duration delay;

  /// 自定义加载指示器
  final Widget? indicator;

  /// 自定义主题
  final ZephyrSpinTheme? theme;

  /// 子组件
  final Widget? child;

  /// 是否全屏显示
  final bool fullscreen;

  /// 显示全屏加载
  static void showFullscreen(
    BuildContext context, {
    String? tip,
    ZephyrSpinSize size = ZephyrSpinSize.medium,
    Widget? indicator,
    ZephyrSpinTheme? theme,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ZephyrSpin(
        spinning: true,
        size: size,
        tip: tip,
        indicator: indicator,
        theme: theme,
        fullscreen: true,
      ),
    );
  }

  /// 隐藏全屏加载
  static void hideFullscreen(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  State<ZephyrSpin> createState() => _ZephyrSpinState();
}

class _ZephyrSpinState extends State<ZephyrSpin> {
  bool _showSpinner = false;

  @override
  void initState() {
    super.initState();
    if (widget.spinning) {
      _startSpinner();
    }
  }

  @override
  void didUpdateWidget(ZephyrSpin oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.spinning != oldWidget.spinning) {
      if (widget.spinning) {
        _startSpinner();
      } else {
        _stopSpinner();
      }
    }
  }

  void _startSpinner() {
    if (widget.delay.inMilliseconds > 0) {
      Future.delayed(widget.delay, () {
        if (mounted && widget.spinning) {
          setState(() {
            _showSpinner = true;
          });
        }
      });
    } else {
      setState(() {
        _showSpinner = true;
      });
    }
  }

  void _stopSpinner() {
    setState(() {
      _showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.fullscreen) {
      return _buildFullscreenSpinner();
    }

    return Stack(
      children: [
        if (widget.child != null) widget.child!,
        if (_showSpinner) _buildOverlay(),
      ],
    );
  }

  Widget _buildFullscreenSpinner() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha:0.9),
          borderRadius: BorderRadius.circular(8),
        ),
        child: _buildSpinner(),
      ),
    );
  }

  Widget _buildOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.white.withValues(alpha:0.7),
        child: Center(
          child: _buildSpinner(),
        ),
      ),
    );
  }

  Widget _buildSpinner() {
    final theme = widget.theme ?? ZephyrSpinTheme.fromTheme(Theme.of(context));

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.indicator != null) ...[
          widget.indicator!,
        ] else ...[
          _buildDefaultSpinner(theme),
        ],
        if (widget.tip != null) ...[
          const SizedBox(height: 8),
          Text(
            widget.tip!,
            style: theme.tipStyle,
          ),
        ],
      ],
    );
  }

  Widget _buildDefaultSpinner(ZephyrSpinTheme theme) {
    final size = _getSize();
    final strokeWidth = _getStrokeWidth();

    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(theme.color),
      ),
    );
  }

  double _getSize() {
    switch (widget.size) {
      case ZephyrSpinSize.small:
        return 20;
      case ZephyrSpinSize.medium:
        return 32;
      case ZephyrSpinSize.large:
        return 48;
      default:
        return 32;
    }
  }

  double _getStrokeWidth() {
    switch (widget.size) {
      case ZephyrSpinSize.small:
        return 2;
      case ZephyrSpinSize.medium:
        return 3;
      case ZephyrSpinSize.large:
        return 4;
      default:
        return 3;
    }
  }
}
