/// VelocityUI 倒计时组件
library velocity_countdown;

import 'dart:async';
import 'package:flutter/material.dart';
import 'countdown_style.dart';

/// VelocityUI 倒计时组件
class VelocityCountDown extends StatefulWidget {
  /// 创建倒计时组件
  const VelocityCountDown({
    required this.duration,
    super.key,
    this.style,
    this.onEnd,
    this.onUpdate,
    this.onStatusChange,
    this.autoStart = true,
    this.controller,
    this.showDays,
    this.showHours,
    this.showMinutes,
    this.showSeconds,
    this.showMilliseconds,
    this.showLabels,
    this.showSeparators,
    this.format,
  });

  /// 倒计时时长（毫秒）
  final int duration;

  /// 倒计时样式
  final VelocityCountDownStyle? style;

  /// 倒计时结束回调
  final VoidCallback? onEnd;

  /// 倒计时更新回调
  final ValueChanged<Duration>? onUpdate;

  /// 倒计时状态变化回调
  final ValueChanged<VelocityCountDownStatus>? onStatusChange;

  /// 是否自动开始
  final bool autoStart;

  /// 倒计时控制器
  final VelocityCountDownController? controller;

  /// 是否显示天（优先级高于 style 中的 showDays）
  final bool? showDays;

  /// 是否显示时（优先级高于 style 中的 showHours）
  final bool? showHours;

  /// 是否显示分（优先级高于 style 中的 showMinutes）
  final bool? showMinutes;

  /// 是否显示秒（优先级高于 style 中的 showSeconds）
  final bool? showSeconds;

  /// 是否显示毫秒（优先级高于 style 中的 showMilliseconds）
  final bool? showMilliseconds;

  /// 是否显示标签（优先级高于 style 中的 showLabels）
  final bool? showLabels;

  /// 是否显示分隔符（优先级高于 style 中的 showSeparators）
  final bool? showSeparators;

  /// 时间格式（优先级高于 style 中的 format）
  final String? format;

  @override
  State<VelocityCountDown> createState() => _VelocityCountDownState();
}

class _VelocityCountDownState extends State<VelocityCountDown> {
  late VelocityCountDownController _controller;
  late int _remainingTime;
  late VelocityCountDownStatus _status;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.duration;
    _status = VelocityCountDownStatus.paused;
    _controller = widget.controller ?? VelocityCountDownController();
    _controller.addListener(_onControllerUpdate);

    if (widget.autoStart) {
      _start();
    } else {
      _updateStatus(VelocityCountDownStatus.paused);
    }
  }

  @override
  void didUpdateWidget(VelocityCountDown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_onControllerUpdate);
      _controller = widget.controller ?? VelocityCountDownController();
      _controller.addListener(_onControllerUpdate);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerUpdate);
    if (widget.controller == null) {
      _controller.dispose();
    }
    _stopTimer();
    super.dispose();
  }

  void _onControllerUpdate(VelocityCountDownController controller) {
    switch (controller.action) {
      case VelocityCountDownAction.start:
        _start();
        break;
      case VelocityCountDownAction.pause:
        _pause();
        break;
      case VelocityCountDownAction.reset:
        _reset();
        break;
      case VelocityCountDownAction.restart:
        _restart();
        break;
    }
  }

  void _start() {
    if (_status == VelocityCountDownStatus.running || _remainingTime <= 0) {
      return;
    }
    _stopTimer();
    _updateStatus(VelocityCountDownStatus.running);
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        _remainingTime = _remainingTime - 10;
        if (_remainingTime <= 0) {
          _remainingTime = 0;
          _stopTimer();
          _updateStatus(VelocityCountDownStatus.finished);
          widget.onEnd?.call();
        }
        widget.onUpdate?.call(Duration(milliseconds: _remainingTime));
      });
    });
  }

  void _pause() {
    if (_status == VelocityCountDownStatus.paused) return;
    _stopTimer();
    _updateStatus(VelocityCountDownStatus.paused);
  }

  void _reset() {
    _stopTimer();
    setState(() {
      _remainingTime = widget.duration;
    });
    _updateStatus(VelocityCountDownStatus.paused);
  }

  void _restart() {
    _stopTimer();
    setState(() {
      _remainingTime = widget.duration;
    });
    _start();
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _updateStatus(VelocityCountDownStatus status) {
    _status = status;
    _controller._status = status;
    widget.onStatusChange?.call(status);
  }

  String _formatTime(int time, int digits) {
    return time.toString().padLeft(digits, '0');
  }

  Widget _buildDigitContainer(int value, String label) {
    final effectiveStyle = widget.style ?? VelocityCountDownStyle();
    final effectiveShowLabels = widget.showLabels ?? effectiveStyle.showLabels;
    return Container(
      margin: effectiveStyle.digitMargin,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: effectiveStyle.digitPadding,
            decoration: BoxDecoration(
              color: effectiveStyle.digitBackgroundColor,
              borderRadius: effectiveStyle.digitBorderRadius,
            ),
            child: Text(
              _formatTime(value, 2),
              style: effectiveStyle.digitStyle,
            ),
          ),
          if (effectiveShowLabels)
            Container(
              margin: effectiveStyle.labelMargin,
              child: Text(
                label,
                style: effectiveStyle.labelStyle,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSeparator() {
    final effectiveStyle = widget.style ?? VelocityCountDownStyle();
    return Container(
      margin: effectiveStyle.separatorMargin,
      child: Text(
        ':',
        style: effectiveStyle.separatorStyle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = widget.style ?? VelocityCountDownStyle();
    final duration = Duration(milliseconds: _remainingTime);
    final days = duration.inDays;
    final hours = duration.inHours.remainder(24);
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    final milliseconds = duration.inMilliseconds.remainder(1000) ~/ 10;

    final effectiveShowDays = widget.showDays ?? effectiveStyle.showDays;
    final effectiveShowHours = widget.showHours ?? effectiveStyle.showHours;
    final effectiveShowMinutes =
        widget.showMinutes ?? effectiveStyle.showMinutes;
    final effectiveShowSeconds =
        widget.showSeconds ?? effectiveStyle.showSeconds;
    final effectiveShowMilliseconds =
        widget.showMilliseconds ?? effectiveStyle.showMilliseconds;
    final effectiveShowSeparators =
        widget.showSeparators ?? effectiveStyle.showSeparators;

    final parts = <Widget>[];

    if (effectiveShowDays) {
      parts.add(_buildDigitContainer(days, '天'));
      if (effectiveShowSeparators) {
        parts.add(_buildSeparator());
      }
    }

    if (effectiveShowHours) {
      parts.add(_buildDigitContainer(hours, '时'));
      if (effectiveShowSeparators) {
        parts.add(_buildSeparator());
      }
    }

    if (effectiveShowMinutes) {
      parts.add(_buildDigitContainer(minutes, '分'));
      if (effectiveShowSeparators) {
        parts.add(_buildSeparator());
      }
    }

    if (effectiveShowSeconds) {
      parts.add(_buildDigitContainer(seconds, '秒'));
      if (effectiveShowSeparators && effectiveShowMilliseconds) {
        parts.add(_buildSeparator());
      }
    }

    if (effectiveShowMilliseconds) {
      parts.add(_buildDigitContainer(milliseconds, '毫秒'));
    }

    return Container(
      margin: effectiveStyle.margin,
      padding: effectiveStyle.padding,
      decoration: BoxDecoration(
        color: effectiveStyle.backgroundColor,
        borderRadius: effectiveStyle.borderRadius,
        border: effectiveStyle.border,
        boxShadow:
            effectiveStyle.shadow != null ? [effectiveStyle.shadow!] : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: parts,
      ),
    );
  }
}

/// 倒计时控制器动作
enum VelocityCountDownAction {
  /// 开始
  start,

  /// 暂停
  pause,

  /// 重置
  reset,

  /// 重新开始
  restart,
}

/// 倒计时状态
enum VelocityCountDownStatus {
  /// 运行中
  running,

  /// 暂停
  paused,

  /// 已结束
  finished,
}

/// 倒计时控制器
class VelocityCountDownController {
  /// 创建倒计时控制器
  VelocityCountDownController();

  late VelocityCountDownStatus _status = VelocityCountDownStatus.paused;
  VelocityCountDownStatus get status => _status;

  VelocityCountDownAction _action = VelocityCountDownAction.start;
  VelocityCountDownAction get action => _action;

  final List<ValueChanged<VelocityCountDownController>> _listeners = [];

  void addListener(ValueChanged<VelocityCountDownController> listener) {
    _listeners.add(listener);
  }

  void removeListener(ValueChanged<VelocityCountDownController> listener) {
    _listeners.remove(listener);
  }

  void _updateListeners() {
    for (final listener in _listeners) {
      listener(this);
    }
  }

  /// 开始倒计时
  void start() {
    _action = VelocityCountDownAction.start;
    _updateListeners();
  }

  /// 暂停倒计时
  void pause() {
    _action = VelocityCountDownAction.pause;
    _updateListeners();
  }

  /// 重置倒计时
  void reset() {
    _action = VelocityCountDownAction.reset;
    _updateListeners();
  }

  /// 重新开始倒计时
  void restart() {
    _action = VelocityCountDownAction.restart;
    _updateListeners();
  }

  /// 释放资源
  void dispose() {
    _listeners.clear();
  }
}
