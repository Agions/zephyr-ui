/// VelocityUI 数字输入组件
library velocity_counter;

import 'package:flutter/material.dart';
import 'counter_style.dart';

export 'counter_style.dart';

/// VelocityUI 计数器/数字输入
class VelocityCounter extends StatefulWidget {
  const VelocityCounter({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 99999,
    this.step = 1,
    this.disabled = false,
    this.showInput = true,
    this.style,
  });

  final int value;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;
  final int step;
  final bool disabled;
  final bool showInput;
  final VelocityCounterStyle? style;

  @override
  State<VelocityCounter> createState() => _VelocityCounterState();
}

class _VelocityCounterState extends State<VelocityCounter> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value.toString());
  }

  @override
  void didUpdateWidget(VelocityCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _controller.text = widget.value.toString();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _decrease() {
    if (widget.disabled) return;
    final newValue = (widget.value - widget.step).clamp(widget.min, widget.max);
    widget.onChanged(newValue);
  }

  void _increase() {
    if (widget.disabled) return;
    final newValue = (widget.value + widget.step).clamp(widget.min, widget.max);
    widget.onChanged(newValue);
  }

  void _onInputChanged(String text) {
    final newValue = int.tryParse(text);
    if (newValue != null) {
      widget.onChanged(newValue.clamp(widget.min, widget.max));
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = widget.style ?? const VelocityCounterStyle();
    final canDecrease = !widget.disabled && widget.value > widget.min;
    final canIncrease = !widget.disabled && widget.value < widget.max;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildButton(Icons.remove, canDecrease, _decrease, effectiveStyle),
        if (widget.showInput)
          Container(
            width: effectiveStyle.inputWidth,
            height: effectiveStyle.height,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: effectiveStyle.inputBackgroundColor,
              border: Border.symmetric(
                  vertical: BorderSide(color: effectiveStyle.borderColor)),
            ),
            child: TextField(
              controller: _controller,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              enabled: !widget.disabled,
              onChanged: _onInputChanged,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero),
              style: effectiveStyle.inputStyle,
            ),
          )
        else
          Container(
            width: effectiveStyle.inputWidth,
            height: effectiveStyle.height,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: effectiveStyle.inputBackgroundColor,
              border: Border.symmetric(
                  vertical: BorderSide(color: effectiveStyle.borderColor)),
            ),
            child:
                Text(widget.value.toString(), style: effectiveStyle.inputStyle),
          ),
        _buildButton(Icons.add, canIncrease, _increase, effectiveStyle),
      ],
    );
  }

  Widget _buildButton(IconData icon, bool enabled, VoidCallback onTap,
      VelocityCounterStyle style) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: style.buttonSize,
        height: style.height,
        decoration: BoxDecoration(
          color:
              enabled ? style.buttonBackgroundColor : style.disabledButtonColor,
          borderRadius: icon == Icons.remove
              ? BorderRadius.horizontal(left: style.borderRadius.topLeft)
              : BorderRadius.horizontal(right: style.borderRadius.topRight),
          border: Border.all(color: style.borderColor),
        ),
        child: Icon(icon,
            size: style.iconSize,
            color: enabled ? style.iconColor : style.disabledIconColor),
      ),
    );
  }
}
