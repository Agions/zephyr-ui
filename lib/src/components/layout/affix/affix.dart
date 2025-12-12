/// VelocityUI 固钉组件
library velocity_affix;

import 'package:flutter/material.dart';
import 'affix_style.dart';

/// VelocityUI 固钉组件
class VelocityAffix extends StatefulWidget {
  /// 创建固钉组件
  const VelocityAffix({
    required this.child,
    super.key,
    this.style = const VelocityAffixStyle(),
    this.offset,
    this.offsetBottom,
    this.zIndex,
    this.onChange,
    this.target,
  });

  /// 子组件
  final Widget child;

  /// 固钉样式
  final VelocityAffixStyle style;

  /// 顶部偏移量（优先级高于 style 中的 offset）
  final double? offset;

  /// 底部偏移量（优先级高于 style 中的 offsetBottom）
  final double? offsetBottom;

  /// 固定时的 z-index（优先级高于 style 中的 zIndex）
  final int? zIndex;

  /// 固定状态变化回调
  final ValueChanged<bool>? onChange;

  /// 滚动目标容器
  final ScrollController? target;

  @override
  State<VelocityAffix> createState() => _VelocityAffixState();
}

class _VelocityAffixState extends State<VelocityAffix> {
  final GlobalKey _childKey = GlobalKey();
  ScrollController? _scrollController;
  bool _isFixed = false;
  double _offsetTop = 0.0;
  double _offsetBottom = 0.0;
  double _initialOffset = 0.0;
  double _childHeight = 0.0;
  bool _isBottomFixed = false;

  @override
  void initState() {
    super.initState();
    _offsetTop = widget.offset ?? widget.style.offset;
    _offsetBottom = widget.offsetBottom ?? widget.style.offsetBottom;
    _isBottomFixed = _offsetBottom > 0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updatePosition();
      _initScrollController();
    });
  }

  @override
  void didUpdateWidget(VelocityAffix oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldOffsetTop = oldWidget.offset ?? oldWidget.style.offset;
    final oldOffsetBottom =
        oldWidget.offsetBottom ?? oldWidget.style.offsetBottom;
    final newOffsetTop = widget.offset ?? widget.style.offset;
    final newOffsetBottom = widget.offsetBottom ?? widget.style.offsetBottom;

    if (oldOffsetTop != newOffsetTop || oldOffsetBottom != newOffsetBottom) {
      _offsetTop = newOffsetTop;
      _offsetBottom = newOffsetBottom;
      _isBottomFixed = _offsetBottom > 0;
      _updatePosition();
    }

    if (oldWidget.target != widget.target) {
      _disposeScrollController();
      _initScrollController();
    }
  }

  @override
  void dispose() {
    _disposeScrollController();
    super.dispose();
  }

  void _initScrollController() {
    _scrollController = widget.target ?? PrimaryScrollController.of(context);
    if (_scrollController != null) {
      _scrollController!.addListener(_handleScroll);
    }
  }

  void _disposeScrollController() {
    if (_scrollController != null && widget.target == null) {
      _scrollController!.removeListener(_handleScroll);
      // 不要 dispose 外部传入的 controller
    }
    _scrollController = null;
  }

  void _updatePosition() {
    final renderBox =
        _childKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final offset = renderBox.localToGlobal(Offset.zero);
      _initialOffset = offset.dy;
      _childHeight = renderBox.size.height;
    }
  }

  void _handleScroll() {
    final scrollPosition = _scrollController?.position.pixels ?? 0.0;
    var shouldBeFixed = false;

    if (_isBottomFixed) {
      final viewportHeight = MediaQuery.of(context).size.height;
      final bottomThreshold =
          _initialOffset + _childHeight + _offsetBottom - viewportHeight;
      shouldBeFixed = scrollPosition > bottomThreshold;
    } else {
      shouldBeFixed = scrollPosition > _initialOffset - _offsetTop;
    }

    if (_isFixed != shouldBeFixed) {
      setState(() {
        _isFixed = shouldBeFixed;
      });
      widget.onChange?.call(shouldBeFixed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final child = KeyedSubtree(
      key: _childKey,
      child: widget.child,
    );

    if (!_isFixed) {
      return child;
    }

    final fixedStyle = widget.style;

    return Container(
      width: double.infinity,
      color: fixedStyle.fixedBackgroundColor,
      margin: fixedStyle.fixedMargin,
      padding: fixedStyle.fixedPadding,
      decoration: BoxDecoration(
        border: fixedStyle.fixedBorder,
        boxShadow: fixedStyle.fixedBoxShadow != null
            ? [fixedStyle.fixedBoxShadow!]
            : null,
      ),
      child: Stack(
        children: [
          Positioned(
            top: _isBottomFixed ? null : _offsetTop,
            bottom: _isBottomFixed ? _offsetBottom : null,
            left: 0,
            right: 0,
            child: Material(
              color: Colors.transparent,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
