/// VelocityUI 链接组件
library velocity_link;

import 'package:flutter/material.dart';
import 'link_style.dart';

export 'link_style.dart';

/// VelocityUI 链接
class VelocityLink extends StatelessWidget {
  const VelocityLink({
    super.key,
    required this.text,
    this.onTap,
    this.icon,
    this.underline = false,
    this.disabled = false,
    this.style,
  });

  final String text;
  final VoidCallback? onTap;
  final IconData? icon;
  final bool underline;
  final bool disabled;
  final VelocityLinkStyle? style;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? const VelocityLinkStyle();
    final color = disabled ? effectiveStyle.disabledColor : effectiveStyle.color;
    
    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: effectiveStyle.iconSize, color: color),
            SizedBox(width: effectiveStyle.iconSpacing),
          ],
          Text(
            text,
            style: effectiveStyle.textStyle.copyWith(
              color: color,
              decoration: underline ? TextDecoration.underline : null,
              decorationColor: color,
            ),
          ),
        ],
      ),
    );
  }
}
