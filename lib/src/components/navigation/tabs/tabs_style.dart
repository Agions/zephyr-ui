/// VelocityUI 标签页样式
library velocity_tabs_style;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';

class VelocityTabsStyle {
  const VelocityTabsStyle({
    this.labelColor = VelocityColors.primary,
    this.unselectedLabelColor = VelocityColors.gray500,
    this.indicatorColor = VelocityColors.primary,
    this.indicatorWeight = 2,
    this.labelStyle = const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    this.unselectedLabelStyle = const TextStyle(fontSize: 14),
  });
  
  final Color labelColor;
  final Color unselectedLabelColor;
  final Color indicatorColor;
  final double indicatorWeight;
  final TextStyle labelStyle;
  final TextStyle unselectedLabelStyle;
}
