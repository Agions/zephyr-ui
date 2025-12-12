/// VelocityUI 气泡卡片组件
library velocity_popover;

import 'dart:async';
import 'package:flutter/material.dart';
import 'popover_style.dart';

/// VelocityUI 气泡卡片组件
class VelocityPopOver extends StatefulWidget {
  /// 创建气泡卡片组件
  const VelocityPopOver({
    required this.child,
    required this.content,
    super.key,
    this.position = VelocityPopOverPosition.bottom,
    this.trigger = VelocityPopOverTrigger.click,
    this.style,
    this.isOpen = false,
    this.onOpenChange,
    this.delay = const Duration(milliseconds: 100),
    this.closeDelay = const Duration(milliseconds: 150),
    this.showArrow = true,
    this.closeOnClickOutside = true,
    this.closeOnClickInside = false,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
  });

  /// 目标组件
  final Widget child;

  /// 气泡内容
  final Widget content;

  /// 气泡位置
  final VelocityPopOverPosition position;

  /// 触发方式
  final VelocityPopOverTrigger trigger;

  /// 气泡样式
  final VelocityPopOverStyle? style;

  /// 初始是否显示
  final bool isOpen;

  /// 显示状态变化回调
  final ValueChanged<bool>? onOpenChange;

  /// 悬停显示延迟
  final Duration delay;

  /// 悬停隐藏延迟
  final Duration closeDelay;

  /// 是否显示箭头
  final bool showArrow;

  /// 点击外部是否关闭
  final bool closeOnClickOutside;

  /// 点击内部是否关闭
  final bool closeOnClickInside;

  /// 动画持续时间
  final Duration animationDuration;

  /// 动画曲线
  final Curve animationCurve;

  @override
  State<VelocityPopOver> createState() => _VelocityPopOverState();
}

class _VelocityPopOverState extends State<VelocityPopOver>
    with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _childKey = GlobalKey();
  Timer? _delayTimer;
  Timer? _closeDelayTimer;

  @override
  void initState() {
    super.initState();
    _isOpen = widget.isOpen;
    if (_isOpen) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showPopOver();
      });
    }
  }

  @override
  void didUpdateWidget(VelocityPopOver oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOpen != oldWidget.isOpen) {
      _isOpen = widget.isOpen;
      if (_isOpen) {
        _showPopOver();
      } else {
        _hidePopOver();
      }
    }
  }

  @override
  void dispose() {
    _hidePopOver();
    _delayTimer?.cancel();
    _closeDelayTimer?.cancel();
    super.dispose();
  }

  void _showPopOver() {
    if (_overlayEntry != null) return;

    final overlayState = Overlay.of(context);

    _overlayEntry = OverlayEntry(
      builder: (context) => _buildPopOver(),
    );

    overlayState.insert(_overlayEntry!);
    widget.onOpenChange?.call(true);
  }

  void _hidePopOver() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      widget.onOpenChange?.call(false);
    }
  }

  void _togglePopOver() {
    setState(() {
      _isOpen = !_isOpen;
    });
    if (_isOpen) {
      _showPopOver();
    } else {
      _hidePopOver();
    }
  }

  Widget _buildPopOver() {
    final effectiveStyle = widget.style ?? VelocityPopOverStyle();
    return Stack(
      children: [
        if (widget.closeOnClickOutside)
          Positioned.fill(
            child: GestureDetector(
              onTap: _hidePopOver,
              behavior: HitTestBehavior.opaque,
            ),
          ),
        Positioned.fill(
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset.zero,
            child: Builder(builder: (context) {
              return CustomSingleChildLayout(
                delegate: _PopOverLayoutDelegate(
                  position: widget.position,
                  arrowSize: widget.showArrow ? effectiveStyle.arrowSize : 0,
                  margin: effectiveStyle.margin,
                  childRect: _getWidgetRect(),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: GestureDetector(
                    onTap: widget.closeOnClickInside ? _hidePopOver : null,
                    child: FadeTransition(
                      opacity: Tween(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: AnimationController(
                            duration: widget.animationDuration,
                            vsync: this,
                          )..forward(),
                          curve: widget.animationCurve,
                        ),
                      ),
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: _getSlideBeginOffset(),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: AnimationController(
                              duration: widget.animationDuration,
                              vsync: this,
                            )..forward(),
                            curve: widget.animationCurve,
                          ),
                        ),
                        child: Container(
                          constraints: BoxConstraints(
                            minWidth: effectiveStyle.minWidth,
                            minHeight: effectiveStyle.minHeight,
                            maxWidth: effectiveStyle.maxWidth,
                          ),
                          decoration: BoxDecoration(
                            color: effectiveStyle.backgroundColor,
                            border: effectiveStyle.showBorder
                                ? Border.all(
                                    color: effectiveStyle.borderColor,
                                    width: effectiveStyle.borderWidth,
                                  )
                                : null,
                            borderRadius: effectiveStyle.borderRadius,
                            boxShadow: [
                              BoxShadow(
                                color: effectiveStyle.shadowColor,
                                offset: const Offset(0, 2),
                                blurRadius: effectiveStyle.elevation,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (widget.showArrow) _buildArrow(),
                              Padding(
                                padding: effectiveStyle.padding,
                                child: widget.content,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildArrow() {
    final effectiveStyle = widget.style ?? VelocityPopOverStyle();
    return Align(
      alignment: _getArrowAlignment(),
      child: CustomPaint(
        painter: _ArrowPainter(
          color: effectiveStyle.arrowColor,
          size: effectiveStyle.arrowSize,
          position: widget.position,
        ),
        size: Size(effectiveStyle.arrowSize * 2, effectiveStyle.arrowSize * 2),
      ),
    );
  }

  Alignment _getArrowAlignment() {
    switch (widget.position) {
      case VelocityPopOverPosition.top:
        return Alignment.bottomCenter;
      case VelocityPopOverPosition.bottom:
        return Alignment.topCenter;
      case VelocityPopOverPosition.left:
        return Alignment.centerRight;
      case VelocityPopOverPosition.right:
        return Alignment.centerLeft;
      case VelocityPopOverPosition.topLeft:
        return Alignment.bottomLeft;
      case VelocityPopOverPosition.topRight:
        return Alignment.bottomRight;
      case VelocityPopOverPosition.bottomLeft:
        return Alignment.topLeft;
      case VelocityPopOverPosition.bottomRight:
        return Alignment.topRight;
      case VelocityPopOverPosition.leftTop:
        return Alignment.topRight;
      case VelocityPopOverPosition.leftBottom:
        return Alignment.bottomRight;
      case VelocityPopOverPosition.rightTop:
        return Alignment.topLeft;
      case VelocityPopOverPosition.rightBottom:
        return Alignment.bottomLeft;
    }
  }

  Offset _getSlideBeginOffset() {
    switch (widget.position) {
      case VelocityPopOverPosition.top:
        return const Offset(0, 10);
      case VelocityPopOverPosition.bottom:
        return const Offset(0, -10);
      case VelocityPopOverPosition.left:
        return const Offset(10, 0);
      case VelocityPopOverPosition.right:
        return const Offset(-10, 0);
      case VelocityPopOverPosition.topLeft:
        return const Offset(5, 10);
      case VelocityPopOverPosition.topRight:
        return const Offset(-5, 10);
      case VelocityPopOverPosition.bottomLeft:
        return const Offset(5, -10);
      case VelocityPopOverPosition.bottomRight:
        return const Offset(-5, -10);
      case VelocityPopOverPosition.leftTop:
        return const Offset(10, 5);
      case VelocityPopOverPosition.leftBottom:
        return const Offset(10, -5);
      case VelocityPopOverPosition.rightTop:
        return const Offset(-10, 5);
      case VelocityPopOverPosition.rightBottom:
        return const Offset(-10, -5);
    }
  }

  Rect _getWidgetRect() {
    final renderBox =
        _childKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return Rect.zero;
    final offset = renderBox.localToGlobal(Offset.zero);
    return Rect.fromLTWH(
      offset.dx,
      offset.dy,
      renderBox.size.width,
      renderBox.size.height,
    );
  }

  Widget _buildChild() {
    final child = CompositedTransformTarget(
      link: _layerLink,
      child: KeyedSubtree(
        key: _childKey,
        child: widget.child,
      ),
    );

    switch (widget.trigger) {
      case VelocityPopOverTrigger.click:
        return GestureDetector(
          onTap: _togglePopOver,
          child: child,
        );
      case VelocityPopOverTrigger.hover:
        return MouseRegion(
          onEnter: (_) {
            _closeDelayTimer?.cancel();
            _delayTimer = Timer(widget.delay, () {
              if (mounted) {
                setState(() {
                  _isOpen = true;
                });
                _showPopOver();
              }
            });
          },
          onExit: (_) {
            _delayTimer?.cancel();
            _closeDelayTimer = Timer(widget.closeDelay, () {
              if (mounted) {
                setState(() {
                  _isOpen = false;
                });
                _hidePopOver();
              }
            });
          },
          child: child,
        );
      case VelocityPopOverTrigger.manual:
        return child;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildChild();
  }
}

class _PopOverLayoutDelegate extends SingleChildLayoutDelegate {
  _PopOverLayoutDelegate({
    required this.position,
    required this.arrowSize,
    required this.margin,
    required this.childRect,
  });

  final VelocityPopOverPosition position;
  final double arrowSize;
  final EdgeInsets margin;
  final Rect childRect;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return constraints.loosen();
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    switch (position) {
      case VelocityPopOverPosition.top:
        return Offset(
          childRect.left + (childRect.width - childSize.width) / 2,
          childRect.top - childSize.height - arrowSize - margin.top,
        );
      case VelocityPopOverPosition.bottom:
        return Offset(
          childRect.left + (childRect.width - childSize.width) / 2,
          childRect.bottom + arrowSize + margin.bottom,
        );
      case VelocityPopOverPosition.left:
        return Offset(
          childRect.left - childSize.width - arrowSize - margin.left,
          childRect.top + (childRect.height - childSize.height) / 2,
        );
      case VelocityPopOverPosition.right:
        return Offset(
          childRect.right + arrowSize + margin.right,
          childRect.top + (childRect.height - childSize.height) / 2,
        );
      case VelocityPopOverPosition.topLeft:
        return Offset(
          childRect.left,
          childRect.top - childSize.height - arrowSize - margin.top,
        );
      case VelocityPopOverPosition.topRight:
        return Offset(
          childRect.right - childSize.width,
          childRect.top - childSize.height - arrowSize - margin.top,
        );
      case VelocityPopOverPosition.bottomLeft:
        return Offset(
          childRect.left,
          childRect.bottom + arrowSize + margin.bottom,
        );
      case VelocityPopOverPosition.bottomRight:
        return Offset(
          childRect.right - childSize.width,
          childRect.bottom + arrowSize + margin.bottom,
        );
      case VelocityPopOverPosition.leftTop:
        return Offset(
          childRect.left - childSize.width - arrowSize - margin.left,
          childRect.top,
        );
      case VelocityPopOverPosition.leftBottom:
        return Offset(
          childRect.left - childSize.width - arrowSize - margin.left,
          childRect.bottom - childSize.height,
        );
      case VelocityPopOverPosition.rightTop:
        return Offset(
          childRect.right + arrowSize + margin.right,
          childRect.top,
        );
      case VelocityPopOverPosition.rightBottom:
        return Offset(
          childRect.right + arrowSize + margin.right,
          childRect.bottom - childSize.height,
        );
    }
  }

  @override
  bool shouldRelayout(_PopOverLayoutDelegate oldDelegate) {
    return position != oldDelegate.position ||
        arrowSize != oldDelegate.arrowSize ||
        margin != oldDelegate.margin ||
        childRect != oldDelegate.childRect;
  }
}

class _ArrowPainter extends CustomPainter {
  _ArrowPainter({
    required this.color,
    required this.size,
    required this.position,
  });

  final Color color;
  final double size;
  final VelocityPopOverPosition position;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();

    switch (position) {
      case VelocityPopOverPosition.top:
      case VelocityPopOverPosition.topLeft:
      case VelocityPopOverPosition.topRight:
        path.moveTo(size.width / 2, 0);
        path.lineTo(0, size.height);
        path.lineTo(size.width, size.height);
        break;
      case VelocityPopOverPosition.bottom:
      case VelocityPopOverPosition.bottomLeft:
      case VelocityPopOverPosition.bottomRight:
        path.moveTo(0, 0);
        path.lineTo(size.width / 2, size.height);
        path.lineTo(size.width, 0);
        break;
      case VelocityPopOverPosition.left:
      case VelocityPopOverPosition.leftTop:
      case VelocityPopOverPosition.leftBottom:
        path.moveTo(size.width, 0);
        path.lineTo(0, size.height / 2);
        path.lineTo(size.width, size.height);
        break;
      case VelocityPopOverPosition.right:
      case VelocityPopOverPosition.rightTop:
      case VelocityPopOverPosition.rightBottom:
        path.moveTo(0, 0);
        path.lineTo(size.width, size.height / 2);
        path.lineTo(0, size.height);
        break;
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_ArrowPainter oldDelegate) {
    return color != oldDelegate.color ||
        size != oldDelegate.size ||
        position != oldDelegate.position;
  }
}
