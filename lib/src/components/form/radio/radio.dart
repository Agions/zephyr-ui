/// VelocityUI 单选框组件
library velocity_radio;

import 'package:flutter/material.dart';
import 'radio_style.dart';

export 'radio_style.dart';

/// VelocityUI 单选框
class VelocityRadio<T> extends StatelessWidget {
  const VelocityRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label,
    this.disabled = false,
    this.style,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final bool disabled;
  final VelocityRadioStyle? style;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? VelocityRadioStyle.defaults();

    Widget radio = Radio<T>(
      value: value,
      groupValue: groupValue,
      onChanged: disabled ? null : onChanged,
      activeColor: effectiveStyle.activeColor,
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled))
          return effectiveStyle.disabledColor;
        if (states.contains(WidgetState.selected))
          return effectiveStyle.activeColor;
        return effectiveStyle.inactiveColor;
      }),
    );

    if (label != null) {
      radio = GestureDetector(
        onTap: disabled ? null : () => onChanged?.call(value),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            radio,
            SizedBox(width: effectiveStyle.labelSpacing),
            Text(label!,
                style: effectiveStyle.labelStyle?.copyWith(
                  color: disabled ? effectiveStyle.disabledLabelColor : null,
                )),
          ],
        ),
      );
    }

    return radio;
  }
}
