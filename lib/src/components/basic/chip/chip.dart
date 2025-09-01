import 'package:flutter/material.dart';

import 'chip_theme.dart';

/// 标签组件变体
enum ZephyrChipVariant {
  /// 默认标签
  standard,

  /// 可选择标签
  choice,

  /// 过滤标签
  filter,

  /// 输入标签
  input,

  /// 操作标签
  action,
}

/// ZephyrUI 标签组件
///
/// 一个多功能的标签组件，支持多种变体和交互模式。
///
/// 示例用法:
/// ```dart
/// ZephyrChip(
///   label: 'Flutter',
///   onPressed: () => print('Chip pressed'),
/// )
///
/// ZephyrChip.choice(
///   label: '前端开发',
///   selected: true,
///   onSelected: (selected) => print('Selected: $selected'),
/// )
///
/// ZephyrChip.filter(
///   label: '已完成',
///   selected: false,
///   onSelected: (selected) => print('Filter: $selected'),
/// )
/// ```
class ZephyrChip extends StatelessWidget {
  /// 创建一个标准标签
  const ZephyrChip({
    Key? key,
    required this.label,
    this.avatar,
    this.deleteIcon,
    this.onPressed,
    this.onDeleted,
    this.selected = false,
    this.enabled = true,
    this.variant = ZephyrChipVariant.standard,
    this.theme,
  })  : onSelected = null,
        super(key: key);

  /// 创建一个可选择标签
  const ZephyrChip.choice({
    Key? key,
    required this.label,
    this.avatar,
    this.selected = false,
    this.enabled = true,
    this.onSelected,
    this.theme,
  })  : variant = ZephyrChipVariant.choice,
        deleteIcon = null,
        onPressed = null,
        onDeleted = null,
        super(key: key);

  /// 创建一个过滤标签
  const ZephyrChip.filter({
    Key? key,
    required this.label,
    this.avatar,
    this.selected = false,
    this.enabled = true,
    this.onSelected,
    this.theme,
  })  : variant = ZephyrChipVariant.filter,
        deleteIcon = null,
        onPressed = null,
        onDeleted = null,
        super(key: key);

  /// 创建一个输入标签
  const ZephyrChip.input({
    Key? key,
    required this.label,
    this.avatar,
    this.deleteIcon,
    this.enabled = true,
    this.onDeleted,
    this.theme,
  })  : variant = ZephyrChipVariant.input,
        selected = false,
        onPressed = null,
        onSelected = null,
        super(key: key);

  /// 创建一个操作标签
  const ZephyrChip.action({
    Key? key,
    required this.label,
    this.avatar,
    this.enabled = true,
    this.onPressed,
    this.theme,
  })  : variant = ZephyrChipVariant.action,
        deleteIcon = null,
        selected = false,
        onDeleted = null,
        onSelected = null,
        super(key: key);

  /// 标签文本
  final String label;

  /// 头像组件
  final Widget? avatar;

  /// 删除图标
  final Widget? deleteIcon;

  /// 是否选中
  final bool selected;

  /// 是否启用
  final bool enabled;

  /// 标签变体
  final ZephyrChipVariant variant;

  /// 点击回调
  final VoidCallback? onPressed;

  /// 选择状态变更回调
  final ValueChanged<bool>? onSelected;

  /// 删除回调
  final VoidCallback? onDeleted;

  /// 自定义主题
  final ZephyrChipTheme? theme;

  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? Theme.of(context).extension<ZephyrChipTheme>() ??
        ZephyrChipTheme.fallback(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: enabled ? _handleTap : null,
        borderRadius: theme.borderRadius,
        child: Container(
          height: theme.height,
          decoration: BoxDecoration(
            color: _getBackgroundColor(theme),
            border: Border.all(
              color: _getBorderColor(theme),
              width: theme.borderWidth,
            ),
            borderRadius: theme.borderRadius,
          ),
          padding: theme.padding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (avatar != null) ...[
                SizedBox(
                  width: theme.iconSize,
                  height: theme.iconSize,
                  child: avatar,
                ),
                SizedBox(width: theme.spacing),
              ],
              if (variant == ZephyrChipVariant.filter && selected) ...[
                Icon(
                  Icons.check,
                  size: theme.iconSize,
                  color: _getTextColor(theme),
                ),
                SizedBox(width: theme.spacing),
              ],
              Flexible(
                child: Text(
                  label,
                  style: theme.textStyle?.copyWith(
                    color: _getTextColor(theme),
                  ) ?? TextStyle(color: _getTextColor(theme)),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (onDeleted != null) ...[
                SizedBox(width: theme.spacing),
                GestureDetector(
                  onTap: enabled ? onDeleted : null,
                  child: deleteIcon ??
                      Icon(
                        Icons.close,
                        size: theme.iconSize,
                        color: enabled
                            ? theme.deleteIconColor
                            : theme.disabledTextColor,
                      ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _handleTap() {
    if (onPressed != null) {
      onPressed!();
    } else if (onSelected != null) {
      onSelected!(!selected);
    }
  }

  Color _getBackgroundColor(ZephyrChipTheme theme) {
    if (!enabled) {
      return theme.disabledBackgroundColor ?? theme.backgroundColor ?? Colors.grey.shade200;
    }

    if (selected) {
      return theme.selectedBackgroundColor ?? theme.backgroundColor ?? Colors.blue.shade100;
    }

    return theme.backgroundColor ?? Colors.grey.shade100;
  }

  Color _getBorderColor(ZephyrChipTheme theme) {
    if (!enabled) {
      return theme.disabledBorderColor ?? theme.borderColor;
    }

    if (selected) {
      return theme.selectedBorderColor ?? theme.borderColor;
    }

    return theme.borderColor;
  }

  Color _getTextColor(ZephyrChipTheme theme) {
    if (!enabled) {
      return theme.disabledTextColor ?? theme.textColor;
    }

    if (selected) {
      return theme.selectedTextColor ?? theme.textColor;
    }

    return theme.textColor;
  }
}

/// 标签组
class ZephyrChipGroup extends StatefulWidget {
  /// 创建一个标签组
  const ZephyrChipGroup({
    Key? key,
    required this.chips,
    this.selectedChips = const [],
    this.multiSelect = false,
    this.onSelectionChanged,
    this.spacing = 8.0,
    this.runSpacing = 8.0,
    this.theme,
  }) : super(key: key);

  /// 标签列表
  final List<ZephyrChipData> chips;

  /// 选中的标签索引列表
  final List<int> selectedChips;

  /// 是否支持多选
  final bool multiSelect;

  /// 选择变更回调
  final ValueChanged<List<int>>? onSelectionChanged;

  /// 水平间距
  final double spacing;

  /// 垂直间距
  final double runSpacing;

  /// 自定义主题
  final ZephyrChipTheme? theme;

  @override
  State<ZephyrChipGroup> createState() => _ZephyrChipGroupState();
}

class _ZephyrChipGroupState extends State<ZephyrChipGroup> {
  late List<int> _selectedChips;

  @override
  void initState() {
    super.initState();
    _selectedChips = List.from(widget.selectedChips);
  }

  @override
  void didUpdateWidget(ZephyrChipGroup oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedChips != widget.selectedChips) {
      _selectedChips = List.from(widget.selectedChips);
    }
  }

  void _handleChipSelected(int index, bool selected) {
    setState(() {
      if (widget.multiSelect) {
        if (selected && !_selectedChips.contains(index)) {
          _selectedChips.add(index);
        } else if (!selected && _selectedChips.contains(index)) {
          _selectedChips.remove(index);
        }
      } else {
        _selectedChips = selected ? [index] : [];
      }
    });

    widget.onSelectionChanged?.call(_selectedChips);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: widget.spacing,
      runSpacing: widget.runSpacing,
      children: widget.chips.asMap().entries.map((entry) {
        final index = entry.key;
        final chipData = entry.value;
        final isSelected = _selectedChips.contains(index);

        return ZephyrChip.choice(
          label: chipData.label,
          avatar: chipData.avatar,
          selected: isSelected,
          enabled: chipData.enabled,
          onSelected: (selected) => _handleChipSelected(index, selected),
          theme: widget.theme,
        );
      }).toList(),
    );
  }
}

/// 标签数据
class ZephyrChipData {
  /// 创建标签数据
  const ZephyrChipData({
    required this.label,
    this.avatar,
    this.enabled = true,
  });

  /// 标签文本
  final String label;

  /// 头像组件
  final Widget? avatar;

  /// 是否启用
  final bool enabled;
}
