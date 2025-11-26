import 'package:flutter/material.dart';
import 'package:zephyr_ui/zephyr_ui.dart';

/// CheckboxGroup是一个复选框组组件，用于在表单中选择多个选项
///
/// 该组件提供以下功能：
/// - 垂直或水平排列的复选框列表
/// - 支持禁用状态
/// - 自定义主题样式
/// - 选中状态变化回调
class ZephyrCheckboxGroup extends StatefulWidget {
  /// 复选框组选项列表
  final List<ZephyrCheckboxItem> items;

  /// 当前选中的值列表
  final List<String> value;

  /// 选中状态变化回调
  final ValueChanged<List<String>>? onChanged;

  /// 排列方向，默认垂直排列
  final Axis direction;

  /// 是否禁用整个复选框组
  final bool disabled;

  /// 主题数据
  final ZephyrCheckboxGroupTheme? theme;

  /// 复选框组间距
  final double spacing;

  /// 构造函数
  const ZephyrCheckboxGroup({
    super.key,
    required this.items,
    required this.value,
    this.onChanged,
    this.direction = Axis.vertical,
    this.disabled = false,
    this.theme,
    this.spacing = 8.0,
  });

  @override
  State<ZephyrCheckboxGroup> createState() => _ZephyrCheckboxGroupState();
}

class _ZephyrCheckboxGroupState extends State<ZephyrCheckboxGroup> {
  late List<String> _selectedValues;

  @override
  void initState() {
    super.initState();
    _selectedValues = List.from(widget.value);
  }

  @override
  void didUpdateWidget(ZephyrCheckboxGroup oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _selectedValues = List.from(widget.value);
    }
  }

  void _handleValueChange(String value, bool? checked) {
    if (widget.disabled) return;

    final newValues = List<String>.from(_selectedValues);

    if (checked == true && !newValues.contains(value)) {
      newValues.add(value);
    } else if (checked == false && newValues.contains(value)) {
      newValues.remove(value);
    }

    setState(() {
      _selectedValues = newValues;
    });

    widget.onChanged?.call(newValues);
  }

  @override
  Widget build(BuildContext context) {
    final theme =
        ZephyrTheme.of(context).checkboxGroupTheme.merge(widget.theme);

    final children = widget.items.map((item) {
      final isSelected = _selectedValues.contains(item.value);
      final isDisabled = widget.disabled || item.disabled;

      return _ZephyrCheckbox(
        value: isSelected,
        onChanged: isDisabled
            ? null
            : (bool? checked) => _handleValueChange(item.value, checked),
        label: item.label,
        disabled: isDisabled,
        theme: theme,
      );
    }).toList();

    return widget.direction == Axis.vertical
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _addSpacing(children, widget.spacing),
          )
        : Row(
            children: _addSpacing(children, widget.spacing),
          );
  }

  List<Widget> _addSpacing(List<Widget> widgets, double spacing) {
    if (widgets.isEmpty) return [];
    if (widgets.length == 1) return widgets;

    final result = <Widget>[];
    for (int i = 0; i < widgets.length; i++) {
      result.add(widgets[i]);
      if (i < widgets.length - 1) {
        if (widget.direction == Axis.vertical) {
          result.add(SizedBox(height: spacing));
        } else {
          result.add(SizedBox(width: spacing));
        }
      }
    }
    return result;
  }
}

/// 单个复选框组件（内部使用）
class _ZephyrCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final String label;
  final bool disabled;
  final ZephyrCheckboxGroupTheme theme;

  const _ZephyrCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
    required this.disabled,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTextStyle =
        disabled ? theme.disabledTextStyle : theme.textStyle;

    return InkWell(
      onTap: onChanged == null ? null : () => onChanged!(!value),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: theme.activeColor,
              checkColor: theme.checkColor,
              side: const BorderSide(
                color: disabled ? theme.disabledBorderColor : theme.borderColor,
                width: theme.borderWidth,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(theme.borderRadius),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              style: effectiveTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}

/// 复选框选项数据模型
class ZephyrCheckboxItem {
  /// 选项值（唯一标识）
  final String value;

  /// 选项显示文本
  final String label;

  /// 是否禁用单个选项
  final bool disabled;

  /// 构造函数
  const ZephyrCheckboxItem({
    required this.value,
    required this.label,
    this.disabled = false,
  });
}
