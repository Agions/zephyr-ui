/// VelocityUI 分隔线组件
library velocity_divider;

import 'package:flutter/material.dart';
import 'divider_style.dart';

export 'divider_style.dart';

/// VelocityUI 分隔线
class VelocityDivider extends StatelessWidget {
  const VelocityDivider({super.key, this.vertical = false, this.style});
  final bool vertical;
  final VelocityDividerStyle? style;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? VelocityDividerStyle.defaults();
    if (vertical) {
      return Container(width: effectiveStyle.thickness, height: effectiveStyle.length, margin: effectiveStyle.margin, color: effectiveStyle.color);
    }
    return Container(height: effectiveStyle.thickness, width: effectiveStyle.length, margin: effectiveStyle.margin, color: effectiveStyle.color);
  }
}
