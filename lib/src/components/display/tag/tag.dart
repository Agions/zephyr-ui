/// VelocityUI 标签组件
library velocity_tag;

import 'package:flutter/material.dart';
import 'tag_style.dart';

export 'tag_style.dart';

/// 标签类型
enum VelocityTagType { primary, success, warning, error, info, default_ }

/// VelocityUI 标签组件
class VelocityTag extends StatelessWidget {
  /// 创建标签组件
  const VelocityTag({
    required this.text, super.key,
    this.type = VelocityTagType.default_,
    this.closable = false,
    this.onClose,
    this.icon,
    this.outlined = false,
    this.style,
  });

  /// 文本
  final String text;

  /// 类型
  final VelocityTagType type;

  /// 是否可关闭
  final bool closable;

  /// 关闭回调
  final VoidCallback? onClose;

  /// 图标
  final IconData? icon;

  /// 是否轮廓样式
  final bool outlined;

  /// 自定义样式
  final VelocityTagStyle? style;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle =
        style ?? VelocityTagStyle.fromType(type, outlined: outlined);

    return Container(
      height: effectiveStyle.height,
      padding: effectiveStyle.padding,
      decoration: BoxDecoration(
        color: effectiveStyle.backgroundColor,
        borderRadius: effectiveStyle.borderRadius,
        border: effectiveStyle.border,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon,
                size: effectiveStyle.iconSize,
                color: effectiveStyle.foregroundColor),
            SizedBox(width: effectiveStyle.spacing),
          ],
          Text(text,
              style: effectiveStyle.textStyle
                  ?.copyWith(color: effectiveStyle.foregroundColor)),
          if (closable) ...[
            SizedBox(width: effectiveStyle.spacing),
            GestureDetector(
              onTap: onClose,
              child: Icon(Icons.close,
                  size: effectiveStyle.iconSize,
                  color: effectiveStyle.foregroundColor),
            ),
          ],
        ],
      ),
    );
  }
}
