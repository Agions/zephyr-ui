import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VelocityAccessibleTextField extends StatefulWidget {
  const VelocityAccessibleTextField({
    super.key,
    this.label,
    this.hintText,
    this.hint,
    this.initialValue = '',
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.isDisabled = false,
    this.isReadOnly = false,
    this.isRequired = false,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.semanticLabel,
    this.focusNode,
    this.textCapitalization = TextCapitalization.none,
    this.textInputFormatter,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength,
    this.obscureText = false,
    this.isObscured,
  });

  final String? label;
  final String? hintText;
  final String? hint;
  final String initialValue;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool isDisabled;
  final bool isReadOnly;
  final bool isRequired;
  final String? errorText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? semanticLabel;
  final FocusNode? focusNode;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? textInputFormatter;
  final int maxLines;
  final int minLines;
  final int? maxLength;
  final bool obscureText;
  final bool? isObscured;

  @override
  State<VelocityAccessibleTextField> createState() =>
      _VelocityAccessibleTextFieldState();
}

class _VelocityAccessibleTextFieldState
    extends State<VelocityAccessibleTextField> {
  late TextEditingController _internalController;
  TextEditingController get _controller =>
      widget.controller ?? _internalController;
  late FocusNode _internalFocusNode;
  FocusNode get _focusNode => widget.focusNode ?? _internalFocusNode;

  @override
  void initState() {
    super.initState();
    _internalController = TextEditingController(text: widget.initialValue);
    _internalFocusNode = FocusNode();
  }

  @override
  void didUpdateWidget(VelocityAccessibleTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      // If controller changes, we don't need to do anything as we're already using the new controller
    }
  }

  @override
  void dispose() {
    _internalController.dispose();
    _internalFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = !widget.isDisabled && !widget.isReadOnly;
    final hint = widget.hint ?? widget.hintText;
    final isObscured = widget.isObscured ?? widget.obscureText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Row(
            children: [
              Text(
                widget.label!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              if (widget.isRequired) const SizedBox(width: 4),
              if (widget.isRequired)
                const Text('*', style: TextStyle(color: Colors.red)),
            ],
          ),
          const SizedBox(height: 8),
        ],
        Semantics(
          label: widget.semanticLabel ?? widget.label,
          hint: hint,
          value: _controller.text,
          textField: true,
          enabled: isEnabled,
          readOnly: widget.isReadOnly,
          child: Focus(
            focusNode: _focusNode,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      widget.errorText != null ? Colors.red : Colors.grey[300]!,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                onChanged: widget.onChanged,
                onSubmitted: widget.onSubmitted,
                enabled: isEnabled,
                readOnly: widget.isReadOnly,
                keyboardType: widget.keyboardType,
                textInputAction: widget.textInputAction,
                textCapitalization: widget.textCapitalization,
                inputFormatters: widget.textInputFormatter,
                maxLines: widget.maxLines,
                minLines: widget.minLines,
                maxLength: widget.maxLength,
                obscureText: isObscured,
                decoration: InputDecoration(
                  hintText: hint,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(12),
                  errorText: widget.errorText,
                  counterText: '',
                ),
                style: TextStyle(
                  fontSize: 16,
                  color: isEnabled ? Colors.black : Colors.grey[500],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
