/// VelocityUI 输入框组件
library velocity_input;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'input_style.dart';

export 'input_style.dart';

/// VelocityUI 输入框组件
class VelocityInput extends StatefulWidget {
  /// 创建输入框组件
  const VelocityInput({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.helper,
    this.error,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.validator,
    this.autovalidateMode,
    this.style,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hint;
  final String? helper;
  final String? error;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Widget? prefix;
  final Widget? suffix;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final VelocityInputStyle? style;

  @override
  State<VelocityInput> createState() => _VelocityInputState();
}

class _VelocityInputState extends State<VelocityInput> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = widget.style ?? VelocityInputStyle.defaults();
    final hasError = widget.error != null && widget.error!.isNotEmpty;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!, style: effectiveStyle.labelStyle),
          SizedBox(height: effectiveStyle.labelSpacing),
        ],
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          obscureText: _obscureText,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          autofocus: widget.autofocus,
          maxLines: widget.obscureText ? 1 : widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          inputFormatters: widget.inputFormatters,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          onTap: widget.onTap,
          validator: widget.validator,
          autovalidateMode: widget.autovalidateMode,
          style: effectiveStyle.textStyle,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: effectiveStyle.hintStyle,
            filled: effectiveStyle.filled,
            fillColor: widget.enabled ? effectiveStyle.fillColor : effectiveStyle.disabledFillColor,
            contentPadding: effectiveStyle.contentPadding,
            prefixIcon: widget.prefixIcon != null 
                ? Icon(widget.prefixIcon, size: effectiveStyle.iconSize, color: effectiveStyle.iconColor) 
                : widget.prefix,
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, size: effectiveStyle.iconSize, color: effectiveStyle.iconColor),
                    onPressed: () => setState(() => _obscureText = !_obscureText),
                  )
                : widget.suffixIcon != null 
                    ? Icon(widget.suffixIcon, size: effectiveStyle.iconSize, color: effectiveStyle.iconColor) 
                    : widget.suffix,
            border: OutlineInputBorder(borderRadius: effectiveStyle.borderRadius, borderSide: BorderSide(color: effectiveStyle.borderColor)),
            enabledBorder: OutlineInputBorder(borderRadius: effectiveStyle.borderRadius, borderSide: BorderSide(color: hasError ? effectiveStyle.errorBorderColor : effectiveStyle.borderColor)),
            focusedBorder: OutlineInputBorder(borderRadius: effectiveStyle.borderRadius, borderSide: BorderSide(color: hasError ? effectiveStyle.errorBorderColor : effectiveStyle.focusedBorderColor, width: 2)),
            errorBorder: OutlineInputBorder(borderRadius: effectiveStyle.borderRadius, borderSide: BorderSide(color: effectiveStyle.errorBorderColor)),
            focusedErrorBorder: OutlineInputBorder(borderRadius: effectiveStyle.borderRadius, borderSide: BorderSide(color: effectiveStyle.errorBorderColor, width: 2)),
            disabledBorder: OutlineInputBorder(borderRadius: effectiveStyle.borderRadius, borderSide: BorderSide(color: effectiveStyle.disabledBorderColor)),
            counterText: '',
          ),
        ),
        if (widget.error != null && widget.error!.isNotEmpty) ...[
          SizedBox(height: effectiveStyle.helperSpacing),
          Text(widget.error!, style: effectiveStyle.errorStyle),
        ] else if (widget.helper != null && widget.helper!.isNotEmpty) ...[
          SizedBox(height: effectiveStyle.helperSpacing),
          Text(widget.helper!, style: effectiveStyle.helperStyle),
        ],
      ],
    );
  }
}

/// VelocityUI 文本区域
class VelocityTextArea extends StatelessWidget {
  const VelocityTextArea({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.helper,
    this.error,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 5,
    this.minLines = 3,
    this.maxLength,
    this.onChanged,
    this.onSubmitted,
    this.style,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hint;
  final String? helper;
  final String? error;
  final bool enabled;
  final bool readOnly;
  final int maxLines;
  final int minLines;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VelocityInputStyle? style;

  @override
  Widget build(BuildContext context) {
    return VelocityInput(
      controller: controller,
      focusNode: focusNode,
      label: label,
      hint: hint,
      helper: helper,
      error: error,
      enabled: enabled,
      readOnly: readOnly,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      style: style,
    );
  }
}
