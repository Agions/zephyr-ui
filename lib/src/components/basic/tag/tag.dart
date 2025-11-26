/// ZephyrUI Tag 组件
///
/// 用于标记和分类的标签组件

library tag;

import 'package:flutter/material.dart';

/// Tag 样式枚举
enum ZephyrTagStyle {
  defaultStyle,
  success,
  warning,
  error,
  info,
}

/// Tag 大小枚举
enum ZephyrTagSize {
  small,
  medium,
  large,
}

/// Tag 组件
class ZephyrTag extends StatelessWidget {
  const ZephyrTag({
    required this.text,
    super.key,
    this.style = ZephyrTagStyle.defaultStyle,
    this.size = ZephyrTagSize.medium,
    this.color,
    this.backgroundColor,
    this.onTap,
    this.icon,
    this.closable = false,
    this.onClose,
    this.padding,
    this.borderRadius,
  });
  final String text;
  final ZephyrTagStyle style;
  final ZephyrTagSize size;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final IconData? icon;
  final bool closable;
  final VoidCallback? onClose;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // 根据样式获取颜色
    var tagColor = color ?? _getDefaultColor(context);
    var tagBackgroundColor =
        backgroundColor ?? _getDefaultBackgroundColor(context);

    // 根据大小获取内边距
    var tagPadding = padding ?? _getDefaultPadding();

    // 根据大小获取文字样式
    var textStyle = _getDefaultTextStyle(theme);

    // 构建标签内容
    var children = <Widget>[];

    if (icon != null) {
      children.add(
        Icon(
          icon,
          size: textStyle.fontSize! * 0.8,
          color: tagColor,
        ),
      );
      children.add(const SizedBox(width: 4));
    }

    children.add(
      Text(
        text,
        style: textStyle.copyWith(color: tagColor),
      ),
    );

    if (closable) {
      children.add(const SizedBox(width: 4));
      children.add(
        GestureDetector(
          onTap: onClose,
          child: Icon(
            Icons.close,
            size: textStyle.fontSize! * 0.8,
            color: tagColor,
          ),
        ),
      );
    }

    Widget tag = Container(
      padding: tagPadding,
      decoration: BoxDecoration(
        color: tagBackgroundColor,
        borderRadius:
            BorderRadius.circular(borderRadius ?? _getDefaultBorderRadius()),
        border: Border.all(
          color: tagColor.withValues(alpha:0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );

    if (onTap != null) {
      tag = GestureDetector(
        onTap: onTap,
        child: tag,
      );
    }

    return tag;
  }

  Color _getDefaultColor(BuildContext context) {
    switch (style) {
      case ZephyrTagStyle.success:
        return Colors.green;
      case ZephyrTagStyle.warning:
        return Colors.orange;
      case ZephyrTagStyle.error:
        return Colors.red;
      case ZephyrTagStyle.info:
        return Colors.blue;
      case ZephyrTagStyle.defaultStyle:
      default:
        return Theme.of(context).primaryColor;
    }
  }

  Color _getDefaultBackgroundColor(BuildContext context) {
    switch (style) {
      case ZephyrTagStyle.success:
        return Colors.green.withValues(alpha:0.1);
      case ZephyrTagStyle.warning:
        return Colors.orange.withValues(alpha:0.1);
      case ZephyrTagStyle.error:
        return Colors.red.withValues(alpha:0.1);
      case ZephyrTagStyle.info:
        return Colors.blue.withValues(alpha:0.1);
      case ZephyrTagStyle.defaultStyle:
      default:
        return Theme.of(context).primaryColor.withValues(alpha:0.1);
    }
  }

  EdgeInsets _getDefaultPadding() {
    switch (size) {
      case ZephyrTagSize.small:
        return const EdgeInsets.symmetric(horizontal: 6, vertical: 2);
      case ZephyrTagSize.large:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
      case ZephyrTagSize.medium:
      default:
        return const EdgeInsets.symmetric(horizontal: 8, vertical: 4);
    }
  }

  TextStyle _getDefaultTextStyle(ThemeData theme) {
    switch (size) {
      case ZephyrTagSize.small:
        return theme.textTheme.bodySmall!;
      case ZephyrTagSize.large:
        return theme.textTheme.titleSmall!;
      case ZephyrTagSize.medium:
      default:
        return theme.textTheme.bodyMedium!;
    }
  }

  double _getDefaultBorderRadius() {
    switch (size) {
      case ZephyrTagSize.small:
        return 4;
      case ZephyrTagSize.large:
        return 8;
      case ZephyrTagSize.medium:
      default:
        return 6;
    }
  }
}

/// 可关闭的标签组件
class ZephyrCloseableTag extends StatefulWidget {
  const ZephyrCloseableTag({
    required this.text,
    super.key,
    this.style = ZephyrTagStyle.defaultStyle,
    this.size = ZephyrTagSize.medium,
    this.onClose,
    this.onTap,
    this.icon,
  });
  final String text;
  final ZephyrTagStyle style;
  final ZephyrTagSize size;
  final VoidCallback? onClose;
  final VoidCallback? onTap;
  final IconData? icon;

  @override
  State<ZephyrCloseableTag> createState() => _ZephyrCloseableTagState();
}

class _ZephyrCloseableTagState extends State<ZephyrCloseableTag> {
  bool _isClosed = false;

  @override
  Widget build(BuildContext context) {
    if (_isClosed) {
      return const SizedBox.shrink();
    }

    return ZephyrTag(
      text: widget.text,
      style: widget.style,
      size: widget.size,
      closable: true,
      onClose: () {
        setState(() {
          _isClosed = true;
        });
        widget.onClose?.call();
      },
      onTap: widget.onTap,
      icon: widget.icon,
    );
  }
}

/// 标签组组件
class ZephyrTagGroup extends StatelessWidget {
  const ZephyrTagGroup({
    required this.tags,
    super.key,
    this.style = ZephyrTagStyle.defaultStyle,
    this.size = ZephyrTagSize.medium,
    this.spacing = 8,
    this.runSpacing = 4,
    this.alignment = WrapAlignment.start,
    this.onTagTap,
    this.onTagClose,
  });
  final List<String> tags;
  final ZephyrTagStyle style;
  final ZephyrTagSize size;
  final double spacing;
  final double runSpacing;
  final WrapAlignment alignment;
  final ValueChanged<String>? onTagTap;
  final ValueChanged<String>? onTagClose;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing,
      runSpacing: runSpacing,
      alignment: alignment,
      children: tags.map((tag) {
        return ZephyrTag(
          text: tag,
          style: style,
          size: size,
          onTap: () => onTagTap?.call(tag),
          onClose: () => onTagClose?.call(tag),
        );
      }).toList(),
    );
  }
}
