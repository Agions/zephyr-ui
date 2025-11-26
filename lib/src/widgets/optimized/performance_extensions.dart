/// ZephyrUI 性能优化扩展
///
/// 为现有组件提供性能优化功能。
library performance_extensions;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:zephyr_ui/src/utils/performance/performance_optimizer.dart';

/// 性能优化的输入框扩展
extension ZephyrInputPerformanceExtension on StatefulWidget {
  /// 创建性能优化的输入框包装器
  Widget withPerformanceMonitoring({
    String? name,
    bool enabled = true,
  }) {
    if (!enabled) return this;

    return _PerformanceMonitorWidget(
      name: name ?? runtimeType.toString(),
      child: this,
    );
  }
}

/// 性能监控包装器
class _PerformanceMonitorWidget extends StatefulWidget {
  const _PerformanceMonitorWidget({
    required this.child,
    required this.name,
  });
  final Widget child;
  final String name;

  @override
  State<_PerformanceMonitorWidget> createState() =>
      _PerformanceMonitorWidgetState();
}

class _PerformanceMonitorWidgetState extends State<_PerformanceMonitorWidget> {
  @override
  Widget build(BuildContext context) {
    return ZephyrPerformanceUtils.measureTime(
      '${widget.name}_build',
      () => widget.child,
    );
  }
}

/// 防抖的文本字段
class ZephyrDebouncedTextField extends StatefulWidget {
  const ZephyrDebouncedTextField({
    super.key,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.debounceDuration = const Duration(milliseconds: 300),
    this.decoration,
    this.style,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.enabled = true,
    this.keyboardType,
    this.textInputAction,
  });
  final TextEditingController? controller;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final Duration debounceDuration;
  final InputDecoration? decoration;
  final TextStyle? style;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;
  final bool enabled;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  @override
  State<ZephyrDebouncedTextField> createState() =>
      _ZephyrDebouncedTextFieldState();
}

class _ZephyrDebouncedTextFieldState extends State<ZephyrDebouncedTextField> {
  late TextEditingController _controller;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    _controller.addListener(_handleTextChanged);
  }

  @override
  void didUpdateWidget(ZephyrDebouncedTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      _controller.removeListener(_handleTextChanged);
      _controller =
          widget.controller ?? TextEditingController(text: widget.initialValue);
      _controller.addListener(_handleTextChanged);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChanged);
    if (widget.controller == null) {
      _controller.dispose();
    }
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _handleTextChanged() {
    if (_debounceTimer?.isActive == true) {
      _debounceTimer!.cancel();
    }

    _debounceTimer = Timer(widget.debounceDuration, () {
      if (mounted) {
        widget.onChanged?.call(_controller.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ZephyrPerformanceUtils.measureTime(
      'ZephyrDebouncedTextField_build',
      () => TextField(
        controller: _controller,
        decoration: widget.decoration,
        style: widget.style,
        obscureText: widget.obscureText,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        enabled: widget.enabled,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
      ),
    );
  }
}

/// 优化的列表视图
class ZephyrOptimizedListView extends StatefulWidget {
  const ZephyrOptimizedListView({
    required this.children,
    super.key,
    this.controller,
    this.padding,
    this.shrinkWrap = false,
    this.separator,
    this.itemCount,
    this.itemBuilder,
  });
  final List<Widget> children;
  final ScrollController? controller;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final Widget? separator;
  final int? itemCount;
  final Widget Function(BuildContext, int)? itemBuilder;

  @override
  State<ZephyrOptimizedListView> createState() =>
      _ZephyrOptimizedListViewState();
}

class _ZephyrOptimizedListViewState extends State<ZephyrOptimizedListView> {
  final _cache = <int, Widget>{};

  @override
  void didUpdateWidget(ZephyrOptimizedListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.children != widget.children) {
      _cache.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ZephyrPerformanceUtils.measureTime(
      'ZephyrOptimizedListView_build',
      () => ListView.builder(
        controller: widget.controller,
        padding: widget.padding,
        shrinkWrap: widget.shrinkWrap,
        itemCount: widget.itemCount ?? widget.children.length,
        itemBuilder: (context, index) {
          if (widget.itemBuilder != null) {
            return widget.itemBuilder!(context, index);
          }

          if (!_cache.containsKey(index)) {
            _cache[index] = widget.children[index];
          }

          final item = _cache[index]!;
          if (widget.separator != null && index > 0) {
            return Column(
              children: [
                widget.separator!,
                item,
              ],
            );
          }
          return item;
        },
      ),
    );
  }
}

/// 优化的网格视图
class ZephyrOptimizedGridView extends StatefulWidget {
  const ZephyrOptimizedGridView({
    required this.children,
    required this.crossAxisCount,
    super.key,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    this.childAspectRatio = 1.0,
    this.padding,
    this.controller,
  });
  final List<Widget> children;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;
  final EdgeInsetsGeometry? padding;
  final ScrollController? controller;

  @override
  State<ZephyrOptimizedGridView> createState() =>
      _ZephyrOptimizedGridViewState();
}

class _ZephyrOptimizedGridViewState extends State<ZephyrOptimizedGridView> {
  final _cache = <int, Widget>{};

  @override
  void didUpdateWidget(ZephyrOptimizedGridView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.children != widget.children) {
      _cache.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ZephyrPerformanceUtils.measureTime(
      'ZephyrOptimizedGridView_build',
      () => GridView.builder(
        controller: widget.controller,
        padding: widget.padding,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.crossAxisCount,
          mainAxisSpacing: widget.mainAxisSpacing,
          crossAxisSpacing: widget.crossAxisSpacing,
          childAspectRatio: widget.childAspectRatio,
        ),
        itemCount: widget.children.length,
        itemBuilder: (context, index) {
          if (!_cache.containsKey(index)) {
            _cache[index] = widget.children[index];
          }
          return _cache[index]!;
        },
      ),
    );
  }
}

/// 性能监控的包装器
class ZephyrPerformanceWrapper extends StatefulWidget {
  const ZephyrPerformanceWrapper({
    required this.child,
    required this.name,
    super.key,
    this.enabled = true,
  });
  final Widget child;
  final String name;
  final bool enabled;

  @override
  State<ZephyrPerformanceWrapper> createState() =>
      _ZephyrPerformanceWrapperState();
}

class _ZephyrPerformanceWrapperState extends State<ZephyrPerformanceWrapper> {
  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child;
    }

    return ZephyrPerformanceUtils.measureTime(
      '${widget.name}_wrapper',
      () => widget.child,
    );
  }
}
