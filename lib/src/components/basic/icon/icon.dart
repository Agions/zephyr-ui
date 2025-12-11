/// VelocityUI 图标组件
library velocity_icon;

import 'package:flutter/material.dart';
import 'icon_style.dart';

export 'icon_style.dart';

/// 图标尺寸
enum VelocityIconSize { xs, sm, md, lg, xl }

/// VelocityUI 图标组件
class VelocityIcon extends StatelessWidget {
  /// 创建图标组件
  const VelocityIcon(
    this.icon, {
    super.key,
    this.size = VelocityIconSize.md,
    this.customSize,
    this.color,
    this.style,
    this.semanticLabel,
  });

  /// 图标数据
  final IconData icon;

  /// 尺寸
  final VelocityIconSize size;

  /// 自定义尺寸
  final double? customSize;

  /// 颜色
  final Color? color;

  /// 自定义样式
  final VelocityIconStyle? style;

  /// 语义标签
  final String? semanticLabel;

  double get _size {
    if (customSize != null) return customSize!;
    switch (size) {
      case VelocityIconSize.xs:
        return 14;
      case VelocityIconSize.sm:
        return 18;
      case VelocityIconSize.md:
        return 24;
      case VelocityIconSize.lg:
        return 32;
      case VelocityIconSize.xl:
        return 48;
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? VelocityIconStyle.defaults();

    return Icon(
      icon,
      size: _size,
      color: color ?? effectiveStyle.color,
      semanticLabel: semanticLabel,
    );
  }
}
