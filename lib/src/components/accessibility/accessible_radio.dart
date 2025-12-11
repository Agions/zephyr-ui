import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VelocityAccessibleRadio extends StatefulWidget {
  const VelocityAccessibleRadio({
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
  State<VelocityAccessibleRadio> createState() =>
      _VelocityAccessibleRadioState();
}

class _VelocityAccessibleRadioState extends State<VelocityAccessibleRadio> {
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
  void didUpdateWidget(VelocityAccessibleRadio oldWidget) {
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
          _toggleRadio();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: Semantics(
        label: widget.semanticLabel ?? widget.label,
        checked: _isChecked,
        enabled: isEnabled,
        child: GestureDetector(
          onTap: isEnabled ? _toggleRadio : null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _isChecked ? Colors.blue : Colors.grey[400]!,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
                ),
                child: _isChecked
                    ? Container(
                        width: 12,
                        height: 12,
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      )
                    : null,
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

  void _toggleRadio() {
    setState(() {
      _isChecked = !_isChecked;
    });
    widget.onChanged?.call(_isChecked);
  }
}
