/// VelocityUI 加载动画组件
library velocity_spinner;

import 'package:flutter/material.dart';
import 'spinner_style.dart';

export 'spinner_style.dart';

/// 加载动画类型
enum VelocitySpinnerType { circular, dots, wave, pulse, ring }

/// VelocityUI 加载动画
class VelocitySpinner extends StatefulWidget {
  const VelocitySpinner({
    super.key,
    this.type = VelocitySpinnerType.circular,
    this.size = 32,
    this.color,
    this.style,
  });

  final VelocitySpinnerType type;
  final double size;
  final Color? color;
  final VelocitySpinnerStyle? style;

  @override
  State<VelocitySpinner> createState() => _VelocitySpinnerState();
}

class _VelocitySpinnerState extends State<VelocitySpinner>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  Color _applyOpacity(Color color, double opacity) {
    return Color.fromARGB(
      (opacity * 255).round(),
      (color.r * 255).round(),
      (color.g * 255).round(),
      (color.b * 255).round(),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1200), vsync: this)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = widget.style ?? const VelocitySpinnerStyle();
    final color = widget.color ?? effectiveStyle.color;

    switch (widget.type) {
      case VelocitySpinnerType.dots:
        return _buildDots(color);
      case VelocitySpinnerType.wave:
        return _buildWave(color);
      case VelocitySpinnerType.pulse:
        return _buildPulse(color);
      case VelocitySpinnerType.ring:
        return _buildRing(color);
      default:
        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: CircularProgressIndicator(
              strokeWidth: effectiveStyle.strokeWidth,
              valueColor: AlwaysStoppedAnimation(color)),
        );
    }
  }

  Widget _buildDots(Color color) {
    return SizedBox(
      width: widget.size,
      height: widget.size / 3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
            3,
            (i) => AnimatedBuilder(
                  animation: _controller,
                  builder: (_, __) {
                    final value =
                        ((_controller.value * 3 - i) % 3).clamp(0.0, 1.0);
                    return Container(
                      width: widget.size / 5,
                      height: widget.size / 5,
                      decoration: BoxDecoration(
                          color: _applyOpacity(color, 0.3 + value * 0.7),
                          shape: BoxShape.circle),
                    );
                  },
                )),
      ),
    );
  }

  Widget _buildWave(Color color) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
            4,
            (i) => AnimatedBuilder(
                  animation: _controller,
                  builder: (_, __) {
                    final value =
                        (((_controller.value + i * 0.15) % 1.0) * 2 - 1).abs();
                    return Container(
                      width: widget.size / 8,
                      height: widget.size * (0.3 + value * 0.7),
                      decoration: BoxDecoration(
                          color: color,
                          borderRadius:
                              BorderRadius.circular(widget.size / 16)),
                    );
                  },
                )),
      ),
    );
  }

  Widget _buildPulse(Color color) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: _applyOpacity(color, 1 - _controller.value),
            shape: BoxShape.circle,
          ),
          child: Transform.scale(
            scale: 0.5 + _controller.value * 0.5,
            child: Container(
                decoration: BoxDecoration(
                    color: _applyOpacity(color, 0.3), shape: BoxShape.circle)),
          ),
        );
      },
    );
  }

  Widget _buildRing(Color color) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => Transform.rotate(
        angle: _controller.value * 6.28,
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: _applyOpacity(color, 0.2), width: 3),
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
          ),
        ),
      ),
    );
  }
}
