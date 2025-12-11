/// VelocityUI Chip组件
library velocity_chip;

import 'package:flutter/material.dart';
import 'chip_style.dart';

export 'chip_style.dart';

/// Chip类型
enum VelocityChipType { filled, outlined, tonal }

/// VelocityUI Chip
class VelocityChip extends StatelessWidget {
  const VelocityChip({
    super.key,
    required this.label,
    this.avatar,
    this.icon,
    this.deleteIcon,
    this.onTap,
    this.onDelete,
    this.selected = false,
    this.disabled = false,
    this.type = VelocityChipType.filled,
    this.style,
  });

  final String label;
  final Widget? avatar;
  final IconData? icon;
  final IconData? deleteIcon;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final bool selected;
  final bool disabled;
  final VelocityChipType type;
  final VelocityChipStyle? style;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle =
        style ?? VelocityChipStyle.fromType(type, selected: selected);

    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: Container(
        padding: effectiveStyle.padding,
        decoration: BoxDecoration(
          color: disabled
              ? effectiveStyle.disabledBackgroundColor
              : effectiveStyle.backgroundColor,
          borderRadius: effectiveStyle.borderRadius,
          border: effectiveStyle.border,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (avatar != null) ...[
              avatar!,
              SizedBox(width: effectiveStyle.spacing)
            ],
            if (icon != null) ...[
              Icon(icon,
                  size: effectiveStyle.iconSize,
                  color: effectiveStyle.foregroundColor),
              SizedBox(width: effectiveStyle.spacing)
            ],
            Text(label,
                style: effectiveStyle.labelStyle.copyWith(
                    color: disabled
                        ? effectiveStyle.disabledForegroundColor
                        : effectiveStyle.foregroundColor)),
            if (onDelete != null) ...[
              SizedBox(width: effectiveStyle.spacing),
              GestureDetector(
                onTap: disabled ? null : onDelete,
                child: Icon(deleteIcon ?? Icons.close,
                    size: effectiveStyle.iconSize,
                    color: effectiveStyle.foregroundColor),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// VelocityUI 选择Chip
class VelocityChoiceChip extends StatelessWidget {
  const VelocityChoiceChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
    this.avatar,
    this.disabled = false,
    this.style,
  });

  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;
  final Widget? avatar;
  final bool disabled;
  final VelocityChipStyle? style;

  @override
  Widget build(BuildContext context) {
    return VelocityChip(
      label: label,
      avatar: avatar,
      selected: selected,
      disabled: disabled,
      onTap: () => onSelected(!selected),
      style: style,
    );
  }
}
