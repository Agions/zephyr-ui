import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VelocityAccessibleSwitch extends StatefulWidget {
  const VelocityAccessibleSwitch({
    super.key,
    this.label,
    this.isChecked = false,
    this.value,
    this.onChanged,
    this.isDisabled = false,
    this.semanticLabel,
    this.focusNode,
  });

  final String? label;
  final bool isChecked;
  final bool? value;
  final ValueChanged<bool>? onChanged;
  final bool isDisabled;
  final String? semanticLabel;
  final FocusNode? focusNode;

  @override
  State<VelocityAccessibleSwitch> createState() =>
      _VelocityAccessibleSwitchState();
}

class _VelocityAccessibleSwitchState extends State<VelocityAccessibleSwitch> {
  late bool _isChecked;
  late FocusNode _internalFocusNode;
  FocusNode get _focusNode => widget.focusNode ?? _internalFocusNode;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.value ?? widget.isChecked;
    _internalFocusNode = FocusNode();
  }

  @override
  void didUpdateWidget(VelocityAccessibleSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newValue = widget.value ?? widget.isChecked;
    if (newValue != _isChecked) {
      setState(() {
        _isChecked = newValue;
      });
    }
  }

  @override
  void dispose() {
    _internalFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = !widget.isDisabled;

    return Focus(
      focusNode: _focusNode,
      onKeyEvent: (node, event) {
        if (isEnabled &&
            event is KeyDownEvent &&
            (event.logicalKey == LogicalKeyboardKey.enter ||
                event.logicalKey == LogicalKeyboardKey.space)) {
          _toggleSwitch();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: Semantics(
        label: widget.semanticLabel ?? widget.label,
        checked: _isChecked,
        enabled: isEnabled,
        child: GestureDetector(
          onTap: isEnabled ? _toggleSwitch : null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color:
                      _isChecked && isEnabled ? Colors.blue : Colors.grey[400]!,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: AnimatedAlign(
                    alignment: _isChecked
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              if (widget.label != null) ...[
                const SizedBox(width: 8),
                Text(
                  widget.label!,
                  style: TextStyle(
                    fontSize: 14,
                    color: isEnabled ? Colors.black : Colors.grey,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _toggleSwitch() {
    setState(() {
      _isChecked = !_isChecked;
    });
    widget.onChanged?.call(_isChecked);
  }
}
