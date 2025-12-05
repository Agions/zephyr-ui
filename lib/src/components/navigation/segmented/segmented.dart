/// VelocityUI 分段控制器组件
library velocity_segmented;

import 'package:flutter/material.dart';
import 'segmented_style.dart';

export 'segmented_style.dart';

/// VelocityUI 分段控制器
class VelocitySegmented<T> extends StatelessWidget {
  const VelocitySegmented({
    super.key,
    required this.value,
    required this.segments,
    required this.onChanged,
    this.disabled = false,
    this.style,
  });

  final T value;
  final List<VelocitySegment<T>> segments;
  final ValueChanged<T> onChanged;
  final bool disabled;
  final VelocitySegmentedStyle? style;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? const VelocitySegmentedStyle();

    return Container(
      padding: effectiveStyle.padding,
      decoration: BoxDecoration(
        color: effectiveStyle.backgroundColor,
        borderRadius: effectiveStyle.borderRadius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: segments.map((segment) {
          final isSelected = segment.value == value;
          return Expanded(
            child: GestureDetector(
              onTap: disabled || segment.disabled ? null : () => onChanged(segment.value),
              child: AnimatedContainer(
                duration: effectiveStyle.animationDuration,
                padding: effectiveStyle.segmentPadding,
                decoration: BoxDecoration(
                  color: isSelected ? effectiveStyle.activeBackgroundColor : Colors.transparent,
                  borderRadius: effectiveStyle.segmentBorderRadius,
                  boxShadow: isSelected ? effectiveStyle.activeShadow : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (segment.icon != null) ...[
                      Icon(segment.icon, size: effectiveStyle.iconSize, color: isSelected ? effectiveStyle.activeTextColor : effectiveStyle.textColor),
                      SizedBox(width: effectiveStyle.iconSpacing),
                    ],
                    Text(segment.label, style: isSelected ? effectiveStyle.activeTextStyle : effectiveStyle.textStyle),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class VelocitySegment<T> {
  const VelocitySegment({required this.value, required this.label, this.icon, this.disabled = false});
  final T value;
  final String label;
  final IconData? icon;
  final bool disabled;
}
