import 'package:flutter/material.dart';

/// 标签类型
enum ZephyrTagType {
  /// 默认标签
  default_,
  
  /// 主要标签
  primary,
  
  /// 成功标签
  success,
  
  /// 警告标签
  warning,
  
  /// 错误标签
  error,
  
  /// 信息标签
  info,
  
  /// 自定义标签
  custom,
}

/// 标签大小
enum ZephyrTagSize {
  /// 小
  small,
  
  /// 中等
  medium,
  
  /// 大
  large,
}

/// 标签形状
enum ZephyrTagShape {
  /// 圆角矩形
  rounded,
  
  /// 药丸形状
  pill,
  
  /// 方形
  square,
}

/// ZephyrUI 标签组件
///
/// 一个灵活的标签组件，用于显示分类、标签、关键词等信息。
///
/// 特性：
/// - 多种标签类型和形状
/// - 自定义颜色和大小
/// - 图标支持
/// - 点击交互
/// - 关闭按钮
/// - 响应式设计
///
/// 示例用法：
/// ```dart
/// ZephyrTag(
///   text: 'React',
///   type: ZephyrTagType.primary,
///   size: ZephyrTagSize.medium,
///   closable: true,
/// )
/// ```
class ZephyrTag extends StatefulWidget {
  /// 标签文本
  final String text;
  
  /// 标签类型
  final ZephyrTagType type;
  
  /// 标签大小
  final ZephyrTagSize size;
  
  /// 标签形状
  final ZephyrTagShape shape;
  
  /// 自定义颜色
  final Color? color;
  
  /// 文本颜色
  final Color? textColor;
  
  /// 图标
  final Widget? icon;
  
  /// 是否可关闭
  final bool closable;
  
  /// 是否选中
  final bool selected;
  
  /// 是否禁用
  final bool disabled;
  
  /// 是否显示边框
  final bool bordered;
  
  /// 点击回调
  final VoidCallback? onTap;
  
  /// 关闭回调
  final VoidCallback? onClose;
  
  /// 创建标签组件
  const ZephyrTag({
    Key? key,
    required this.text,
    this.type = ZephyrTagType.default_,
    this.size = ZephyrTagSize.medium,
    this.shape = ZephyrTagShape.rounded,
    this.color,
    this.textColor,
    this.icon,
    this.closable = false,
    this.selected = false,
    this.disabled = false,
    this.bordered = true,
    this.onTap,
    this.onClose,
  }) : super(key: key);

  @override
  State<ZephyrTag> createState() => _ZephyrTagState();
}

class _ZephyrTagState extends State<ZephyrTag> {
  bool _isHovered = false;

  Color _getTagColor() {
    if (widget.color != null) return widget.color!;
    
    switch (widget.type) {
      case ZephyrTagType.primary:
        return widget.selected 
            ? const Color(0xFF3B82F6) 
            : const Color(0xFFEFF6FF);
      case ZephyrTagType.success:
        return widget.selected 
            ? const Color(0xFF10B981) 
            : const Color(0xFFD1FAE5);
      case ZephyrTagType.warning:
        return widget.selected 
            ? const Color(0xFFF59E0B) 
            : const Color(0xFFFEF3C7);
      case ZephyrTagType.error:
        return widget.selected 
            ? const Color(0xFFEF4444) 
            : const Color(0xFFFEE2E2);
      case ZephyrTagType.info:
        return widget.selected 
            ? const Color(0xFF6366F1) 
            : const Color(0xFFE0E7FF);
      default:
        return widget.selected 
            ? const Color(0xFF6B7280) 
            : const Color(0xFFF3F4F6);
    }
  }

  Color _getTextColor() {
    if (widget.textColor != null) return widget.textColor!;
    
    switch (widget.type) {
      case ZephyrTagType.primary:
        return widget.selected 
            ? Colors.white 
            : const Color(0xFF3B82F6);
      case ZephyrTagType.success:
        return widget.selected 
            ? Colors.white 
            : const Color(0xFF10B981);
      case ZephyrTagType.warning:
        return widget.selected 
            ? Colors.white 
            : const Color(0xFFF59E0B);
      case ZephyrTagType.error:
        return widget.selected 
            ? Colors.white 
            : const Color(0xFFEF4444);
      case ZephyrTagType.info:
        return widget.selected 
            ? Colors.white 
            : const Color(0xFF6366F1);
      default:
        return widget.selected 
            ? Colors.white 
            : const Color(0xFF6B7280);
    }
  }

  double _getFontSize() {
    switch (widget.size) {
      case ZephyrTagSize.small:
        return 11.0;
      case ZephyrTagSize.medium:
        return 12.0;
      case ZephyrTagSize.large:
        return 14.0;
    }
  }

  EdgeInsets _getPadding() {
    switch (widget.size) {
      case ZephyrTagSize.small:
        return const EdgeInsets.symmetric(horizontal: 8, vertical: 4);
      case ZephyrTagSize.medium:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
      case ZephyrTagSize.large:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
    }
  }

  BorderRadius _getBorderRadius() {
    switch (widget.shape) {
      case ZephyrTagShape.rounded:
        return BorderRadius.circular(4);
      case ZephyrTagShape.pill:
        return BorderRadius.circular(100);
      case ZephyrTagShape.square:
        return BorderRadius.zero;
    }
  }

  void _handleTap() {
    if (widget.disabled) return;
    widget.onTap?.call();
  }

  void _handleClose() {
    if (widget.disabled) return;
    widget.onClose?.call();
  }

  @override
  Widget build(BuildContext context) {
    final tagColor = _getTagColor();
    final textColor = _getTextColor();
    final fontSize = _getFontSize();
    final padding = _getPadding();
    final borderRadius = _getBorderRadius();

    Widget tag = MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: widget.disabled 
              ? const Color(0xFFF3F4F6) 
              : _isHovered && widget.onTap != null
                  ? tagColor.withValues(alpha: 0.8)
                  : tagColor,
          borderRadius: borderRadius,
          border: widget.bordered
              ? Border.all(
                  color: widget.disabled 
                      ? const Color(0xFFE5E7EB) 
                      : textColor.withValues(alpha: 0.3),
                  width: 1,
                )
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.icon != null) ...[
              IconTheme(
                data: IconThemeData(
                  color: widget.disabled ? const Color(0xFF9CA3AF) : textColor,
                  size: fontSize * 1.2,
                ),
                child: widget.icon!,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              widget.text,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
                color: widget.disabled ? const Color(0xFF9CA3AF) : textColor,
              ),
            ),
            if (widget.closable) ...[
              const SizedBox(width: 6),
              GestureDetector(
                onTap: _handleClose,
                child: Icon(
                  Icons.close,
                  size: fontSize * 1.1,
                  color: widget.disabled ? const Color(0xFF9CA3AF) : textColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );

    if (widget.onTap != null) {
      tag = GestureDetector(
        onTap: _handleTap,
        child: tag,
      );
    }

    return tag;
  }
}

/// 标签云组件
class ZephyrTagCloud extends StatelessWidget {
  /// 标签列表
  final List<ZephyrTag> tags;
  
  /// 标签间距
  final double spacing;
  
  /// 换行间距
  final double runSpacing;
  
  /// 对齐方式
  final WrapAlignment alignment;
  
  /// 文本方向
  final TextDirection textDirection;
  
  /// 垂直方向
  final VerticalDirection verticalDirection;
  
  /// 创建标签云组件
  const ZephyrTagCloud({
    Key? key,
    required this.tags,
    this.spacing = 8.0,
    this.runSpacing = 8.0,
    this.alignment = WrapAlignment.start,
    this.textDirection = TextDirection.ltr,
    this.verticalDirection = VerticalDirection.down,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) {
      return const SizedBox();
    }

    return Wrap(
      spacing: spacing,
      runSpacing: runSpacing,
      alignment: alignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      children: tags,
    );
  }
}

/// 可选标签云组件
class ZephyrSelectableTagCloud extends StatefulWidget {
  /// 标签选项
  final List<String> options;
  
  /// 选中的标签
  final List<String> selectedTags;
  
  /// 标签类型
  final ZephyrTagType type;
  
  /// 标签大小
  final ZephyrTagSize size;
  
  /// 标签形状
  final ZephyrTagShape shape;
  
  /// 是否多选
  final bool multiSelect;
  
  /// 标签间距
  final double spacing;
  
  /// 换行间距
  final double runSpacing;
  
  /// 选择回调
  final Function(List<String> selectedTags)? onSelectionChanged;
  
  /// 创建可选标签云组件
  const ZephyrSelectableTagCloud({
    Key? key,
    required this.options,
    required this.selectedTags,
    this.type = ZephyrTagType.default_,
    this.size = ZephyrTagSize.medium,
    this.shape = ZephyrTagShape.rounded,
    this.multiSelect = true,
    this.spacing = 8.0,
    this.runSpacing = 8.0,
    this.onSelectionChanged,
  }) : super(key: key);

  @override
  State<ZephyrSelectableTagCloud> createState() => _ZephyrSelectableTagCloudState();
}

class _ZephyrSelectableTagCloudState extends State<ZephyrSelectableTagCloud> {
  late List<String> _selectedTags;

  @override
  void initState() {
    super.initState();
    _selectedTags = List.from(widget.selectedTags);
  }

  @override
  void didUpdateWidget(ZephyrSelectableTagCloud oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedTags != oldWidget.selectedTags) {
      _selectedTags = List.from(widget.selectedTags);
    }
  }

  void _handleTagTap(String tag) {
    setState(() {
      if (widget.multiSelect) {
        if (_selectedTags.contains(tag)) {
          _selectedTags.remove(tag);
        } else {
          _selectedTags.add(tag);
        }
      } else {
        _selectedTags = [tag];
      }
    });
    
    widget.onSelectionChanged?.call(_selectedTags);
  }

  @override
  Widget build(BuildContext context) {
    final tags = widget.options.map((option) {
      return ZephyrTag(
        text: option,
        type: widget.type,
        size: widget.size,
        shape: widget.shape,
        selected: _selectedTags.contains(option),
        onTap: () => _handleTagTap(option),
      );
    }).toList();

    return ZephyrTagCloud(
      tags: tags,
      spacing: widget.spacing,
      runSpacing: widget.runSpacing,
    );
  }
}