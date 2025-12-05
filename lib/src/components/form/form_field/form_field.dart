/// VelocityUI 表单字段组件
library velocity_form_field;

import 'package:flutter/material.dart';
import 'form_field_style.dart';

export 'form_field_style.dart';

/// VelocityUI 表单字段
class VelocityFormField extends StatelessWidget {
  const VelocityFormField({
    super.key,
    required this.label,
    required this.child,
    this.required = false,
    this.helper,
    this.error,
    this.direction = Axis.vertical,
    this.style,
  });

  final String label;
  final Widget child;
  final bool required;
  final String? helper;
  final String? error;
  final Axis direction;
  final VelocityFormFieldStyle? style;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? const VelocityFormFieldStyle();

    final labelWidget = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: effectiveStyle.labelStyle),
        if (required) Text(' *', style: TextStyle(color: effectiveStyle.requiredColor, fontSize: 14)),
      ],
    );

    if (direction == Axis.horizontal) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: effectiveStyle.labelWidth, child: Padding(padding: EdgeInsets.only(top: effectiveStyle.horizontalLabelOffset), child: labelWidget)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                child,
                if (helper != null && error == null) Padding(padding: EdgeInsets.only(top: effectiveStyle.helperSpacing), child: Text(helper!, style: effectiveStyle.helperStyle)),
                if (error != null) Padding(padding: EdgeInsets.only(top: effectiveStyle.helperSpacing), child: Text(error!, style: effectiveStyle.errorStyle)),
              ],
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        labelWidget,
        SizedBox(height: effectiveStyle.labelSpacing),
        child,
        if (helper != null && error == null) Padding(padding: EdgeInsets.only(top: effectiveStyle.helperSpacing), child: Text(helper!, style: effectiveStyle.helperStyle)),
        if (error != null) Padding(padding: EdgeInsets.only(top: effectiveStyle.helperSpacing), child: Text(error!, style: effectiveStyle.errorStyle)),
      ],
    );
  }
}

/// VelocityUI 表单
class VelocityForm extends StatelessWidget {
  const VelocityForm({
    super.key,
    required this.children,
    this.spacing = 16,
    this.padding,
  });

  final List<Widget> children;
  final double spacing;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            if (i < children.length - 1) SizedBox(height: spacing),
          ],
        ],
      ),
    );
  }
}
