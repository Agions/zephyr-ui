/// VelocityUI 复选框组件
library velocity_checkbox;

import 'package:flutter/material.dart';
import 'checkbox_style.dart';

export 'checkbox_style.dart';

/// VelocityUI 复选框
class VelocityCheckbox extends StatelessWidget {
  const VelocityCheckbox({
    required this.value, required this.onChanged, super.key,
    this.label,
    this.disabled = false,
    this.style,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final bool disabled;
  final VelocityCheckboxStyle? style;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? const VelocityCheckboxStyle();

    Widget checkbox = Checkbox(
      value: value,
      onChanged: disabled ? null : (v) => onChanged?.call(v ?? false),
      activeColor: effectiveStyle.activeColor,
      checkColor: effectiveStyle.checkColor,
      side: BorderSide(
          color: disabled
              ? effectiveStyle.disabledBorderColor
              : effectiveStyle.borderColor),
      shape: RoundedRectangleBorder(borderRadius: effectiveStyle.borderRadius),
    );

    if (label != null) {
      checkbox = GestureDetector(
        onTap: disabled ? null : () => onChanged?.call(!value),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            checkbox,
            SizedBox(width: effectiveStyle.labelSpacing),
            Text(label!,
                style: effectiveStyle.labelStyle.copyWith(
                  color: disabled ? effectiveStyle.disabledLabelColor : null,
                )),
          ],
        ),
      );
    }

    return checkbox;
  }
}
