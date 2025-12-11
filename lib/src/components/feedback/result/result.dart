/// VelocityUI 结果页组件
library velocity_result;

import 'package:flutter/material.dart';
import '../../../core/theme/velocity_colors.dart';
import 'result_style.dart';

export 'result_style.dart';

/// 结果类型
enum VelocityResultType { success, error, warning, info }

/// VelocityUI 结果页
class VelocityResult extends StatelessWidget {
  const VelocityResult({
    required this.type, required this.title, super.key,
    this.icon,
    this.subtitle,
    this.extra,
    this.actions,
    this.style,
  });

  final VelocityResultType type;
  final IconData? icon;
  final String title;
  final String? subtitle;
  final Widget? extra;
  final List<Widget>? actions;
  final VelocityResultStyle? style;

  IconData get _defaultIcon {
    switch (type) {
      case VelocityResultType.success:
        return Icons.check_circle;
      case VelocityResultType.error:
        return Icons.cancel;
      case VelocityResultType.warning:
        return Icons.warning;
      case VelocityResultType.info:
        return Icons.info;
    }
  }

  Color get _defaultColor {
    switch (type) {
      case VelocityResultType.success:
        return VelocityColors.success;
      case VelocityResultType.error:
        return VelocityColors.error;
      case VelocityResultType.warning:
        return VelocityColors.warning;
      case VelocityResultType.info:
        return VelocityColors.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? const VelocityResultStyle();

    return Center(
      child: Padding(
        padding: effectiveStyle.padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon ?? _defaultIcon,
                size: effectiveStyle.iconSize, color: _defaultColor),
            SizedBox(height: effectiveStyle.spacing),
            Text(title,
                style: effectiveStyle.titleStyle, textAlign: TextAlign.center),
            if (subtitle != null) ...[
              SizedBox(height: effectiveStyle.subtitleSpacing),
              Text(subtitle!,
                  style: effectiveStyle.subtitleStyle,
                  textAlign: TextAlign.center),
            ],
            if (extra != null) ...[
              SizedBox(height: effectiveStyle.spacing),
              extra!,
            ],
            if (actions != null && actions!.isNotEmpty) ...[
              SizedBox(height: effectiveStyle.actionSpacing),
              Wrap(
                  spacing: 16,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: actions!),
            ],
          ],
        ),
      ),
    );
  }
}
