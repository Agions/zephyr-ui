/// VelocityUI 开关组件
library velocity_switch;

import 'package:flutter/material.dart';
import 'switch_style.dart';

export 'switch_style.dart';

/// VelocityUI 开关
class VelocitySwitch extends StatelessWidget {
  const VelocitySwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.disabled = false,
    this.style,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final bool disabled;
  final VelocitySwitchStyle? style;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? VelocitySwitchStyle.defaults();

    Widget switchWidget = Switch(
      value: value,
      onChanged: disabled ? null : onChanged,
      activeColor: effectiveStyle.thumbColor,
      activeTrackColor: effectiveStyle.activeTrackColor,
      inactiveThumbColor: effectiveStyle.thumbColor,
      inactiveTrackColor: effectiveStyle.inactiveTrackColor,
    );

    if (label != null) {
      switchWidget = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          switchWidget,
          SizedBox(width: effectiveStyle.labelSpacing),
          Text(label!,
              style: effectiveStyle.labelStyle?.copyWith(
                color: disabled ? effectiveStyle.disabledLabelColor : null,
              )),
        ],
      );
    }

    return switchWidget;
  }
}
