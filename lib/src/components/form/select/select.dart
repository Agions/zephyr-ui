/// VelocityUI 下拉选择组件
library velocity_select;

import 'package:flutter/material.dart';
import 'select_style.dart';

export 'select_style.dart';

/// VelocityUI 选择器
class VelocitySelect<T> extends StatelessWidget {
  const VelocitySelect({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hint,
    this.label,
    this.disabled = false,
    this.style,
  });

  final T? value;
  final List<VelocitySelectItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? hint;
  final String? label;
  final bool disabled;
  final VelocitySelectStyle? style;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? const VelocitySelectStyle();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(label!, style: effectiveStyle.labelStyle),
          SizedBox(height: effectiveStyle.labelSpacing),
        ],
        Container(
          decoration: BoxDecoration(
            color: disabled
                ? effectiveStyle.disabledBackgroundColor
                : effectiveStyle.backgroundColor,
            borderRadius: effectiveStyle.borderRadius,
            border: Border.all(color: effectiveStyle.borderColor),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              items: items
                  .map((item) => DropdownMenuItem<T>(
                        value: item.value,
                        enabled: !item.disabled,
                        child: Row(
                          children: [
                            if (item.icon != null) ...[
                              Icon(item.icon,
                                  size: 20, color: effectiveStyle.iconColor),
                              const SizedBox(width: 8)
                            ],
                            Text(item.label,
                                style: item.disabled
                                    ? effectiveStyle.disabledItemStyle
                                    : effectiveStyle.itemStyle),
                          ],
                        ),
                      ))
                  .toList(),
              onChanged: disabled ? null : onChanged,
              hint: hint != null
                  ? Text(hint!, style: effectiveStyle.hintStyle)
                  : null,
              icon: Icon(Icons.keyboard_arrow_down,
                  color: effectiveStyle.iconColor),
              isExpanded: true,
              padding: effectiveStyle.padding,
              dropdownColor: effectiveStyle.dropdownColor,
              borderRadius: effectiveStyle.borderRadius,
              style: effectiveStyle.itemStyle,
            ),
          ),
        ),
      ],
    );
  }
}

/// 选择项
class VelocitySelectItem<T> {
  const VelocitySelectItem(
      {required this.value,
      required this.label,
      this.icon,
      this.disabled = false});
  final T value;
  final String label;
  final IconData? icon;
  final bool disabled;
}
